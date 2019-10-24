const ROBOT_WIDTH = Float32(0.381)
const WHEEL_RADIUS = Float32(0.195/2.0)

struct Robot
    client_id::Int32
    sonar_handle::Vector{Int32}
    laser_handle::Int32
    vision_handle::Int32
    motors_handle::Dict{Symbol, Int32}
    robot_handle::Int32
    robot_width::Float32
    wheel_radius::Float32
end

function Robot(connection_address="127.0.0.1", connection_port=UInt16(25000);
               robot_width=ROBOT_WIDTH, wheel_radius=WHEEL_RADIUS)
    client_id = start_sim(connection_address, connection_port)
    sonar_handle, laser_handle, vision_handle = start_sensors(client_id)
    motors_handle = start_motors(client_id)
    robot_handle = start_robot(client_id)
    return Robot(client_id,
                 sonar_handle,
                 laser_handle,
                 vision_handle,
                 motors_handle,
                 robot_handle,
                 robot_width,
                 wheel_radius)
end

function start_sim(connection_address, connection_port)
    VREP.simx_finish(-1)
    client_id = VREP.simx_start(connection_address, connection_port, true, true, 2000, 5)
    if client_id != -1
        println("Connected to remoteApi server.")
    else
        VREP.simx_finish(-1)
        error("Unable to connect to remoteApi server. Consider running scene before executing script.")
    end
    return client_id
end

function start_sensors(client_id)
    # Starting ultrasonic sensors
    sonar_handle = Vector{Int32}(undef, 16)
    for i=1:16
        sensor_name = string("Pioneer_p3dx_ultrasonicSensor", i)

        res, handle = VREP.simx_get_object_handle(client_id, sensor_name, VREP.simx_opmode_oneshot_wait)
        if res != VREP.simx_return_ok
            println(sensor_name, " not connected.")
        else
            println(sensor_name, " connected.")
            sonar_handle[i] = handle
        end
    end

    # Starting laser sensor
    res, laser_handle = VREP.simx_get_object_handle(client_id, "fastHokuyo", VREP.simx_opmode_oneshot_wait)
    if res != VREP.simx_return_ok
        println("Laser not connected.")
    else
        println("Laser connected.")
    end
    
    # Starting vision sensor
    res, vision_handle = VREP.simx_get_object_handle(client_id, "Vision_sensor", VREP.simx_opmode_oneshot_wait)
    if res != VREP.simx_return_ok
        println("Vision sensor not connected.")
    else
        println("Vision sensor connected.")
    end
    
    return sonar_handle, laser_handle, vision_handle
end

function start_motors(client_id)
    res, left_handle = VREP.simx_get_object_handle(client_id, "Pioneer_p3dx_leftMotor", VREP.simx_opmode_oneshot_wait)
    if res != VREP.simx_return_ok
        println("Left motor not connected.")
    else
        println("Left motor connected.")
    end
    
    res, right_handle = VREP.simx_get_object_handle(client_id, "Pioneer_p3dx_rightMotor", VREP.simx_opmode_oneshot_wait)
    if res != VREP.simx_return_ok
        println("Right motor not connected.")
    else
        println("Right motor connected.")
    end
    
    return Dict(:left => left_handle, :right => right_handle)
end

function start_robot(client_id)
    res, robot_handle = VREP.simx_get_object_handle(client_id, "Pioneer_p3dx", VREP.simx_opmode_oneshot_wait)
    if res != VREP.simx_return_ok
        println("Robot not connected.")
    else
        println("Robot connected.")
    end
    
    return robot_handle
end

function read_sonar(robot)
    distances = Vector{Float32}(undef, length(robot.sonar_handle))
    no_detection_dist = 5.0 # Here we define the maximum distance as 5 meters

    for (i, sensor) in enumerate(robot.sonar_handle)
        res, status, distance, _, _ = VREP.simx_read_proximity_sensor(robot.client_id,
                                                                      sensor,
                                                                      VREP.simx_opmode_streaming)
        while res != VREP.simx_return_ok
            res, status, distance, _, _ = VREP.simx_read_proximity_sensor(robot.client_id,
                                                                          sensor,
                                                                          VREP.simx_opmode_buffer)
        end
        distances[i] = status != 0 ? distance[3] : no_detection_dist
    end

    return distances
end

function read_laser(robot)
    res, laser = VREP.simx_get_string_signal(robot.client_id,
                                             "LasermeasuredDataAtThisTime",
                                             VREP.simx_opmode_streaming)
    while res != VREP.simx_return_ok
        res, laser = VREP.simx_get_string_signal(robot.client_id,
                                                 "LasermeasuredDataAtThisTime",
                                                 VREP.simx_opmode_buffer)
    end
    return VREP.simx_unpack_floats(laser)
end

function read_vision(robot)
    res, resolution, image_data = VREP.simx_get_vision_sensor_image(robot.client_id,
                                                                    robot.vision_handle,
                                                                    0,
                                                                    VREP.simx_opmode_streaming)
    while res != VREP.simx_return_ok
        res, resolution, image_data = VREP.simx_get_vision_sensor_image(robot.client_id,
                                                                        robot.vision_handle,
                                                                        0,
                                                                        VREP.simx_opmode_buffer)
    end
    return resolution, image_data
end

function get_current_position(robot)
    res, position = VREP.simx_get_object_position(robot.client_id,
                                                  robot.robot_handle,
                                                  -1,
                                                  VREP.simx_opmode_streaming)
    while res != VREP.simx_return_ok
        res, position = VREP.simx_get_object_position(robot.client_id,
                                                      robot.robot_handle,
                                                      -1,
                                                      VREP.simx_opmode_buffer)
    end
    return position
end

function get_current_orientation(robot)
    res, orientation = VREP.simx_get_object_orientation(robot.client_id,
                                                        robot.robot_handle,
                                                        -1,
                                                        VREP.simx_opmode_streaming)
    while res != VREP.simx_return_ok
        res, orientation = VREP.simx_get_object_orientation(robot.client_id,
                                                            robot.robot_handle,
                                                            -1,
                                                            VREP.simx_opmode_buffer)
    end
    return orientation
end

function set_right_velocity(robot, velocity)
    VREP.simx_set_joint_target_velocity(robot.client_id,
                                        robot.motors_handle[:right],
                                        velocity,
                                        VREP.simx_opmode_streaming)
    return nothing
end

function set_left_velocity(robot, velocity)
    VREP.simx_set_joint_target_velocity(robot.client_id,
                                        robot.motors_handle[:left],
                                        velocity,
                                        VREP.simx_opmode_streaming)
    return nothing
end

function set_velocity(robot, linear_velocity, angular_velocity)
    wheel_velocity = angular_velocity * (robot.robot_width / 2)
    left_velocity = (linear_velocity - wheel_velocity) / robot.wheel_radius
    right_velocity = (linear_velocity + wheel_velocity) / robot.wheel_radius
    set_left_velocity(robot, left_velocity)
    set_right_velocity(robot, right_velocity)
    return nothing
end

function stop(robot)
    set_velocity(robot, 0, 0)
    sleep(0.1)
    return nothing
end

function reset_simulation(connection_address="127.0.0.1", connection_port=UInt16(19997))
    client_id = VREP.simx_start(connection_address, connection_port, true, true, 2000, 5)
    if client_id == -1
        error("Unable to connect to V-REP!")
    end
    VREP.simx_stop_simulation(client_id, VREP.simx_opmode_oneshot)
    println("Simulation stopped...")
    sleep(2.0)
    VREP.simx_start_simulation(client_id, VREP.simx_opmode_oneshot)
    println("Simulation started...")
    sleep(3.0)
    VREP.simx_finish(client_id)
    return nothing
end
