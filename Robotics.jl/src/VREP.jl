module VREP

export simx_start,
    simx_finish,
    simx_get_object_handle,
    simx_get_string_signal,
    simx_unpack_floats,
    simx_get_vision_sensor_image,
    simx_get_object_position,
    simx_get_object_orientation,
    simx_set_joint_target_velocity,
    simx_start_simulation,
    simx_stop_simulation,
    simx_opmode_oneshot,
    simx_opmode_oneshot_wait,
    simx_opmode_streaming,
    simx_opmode_buffer,
    simx_return_ok

const simx_opmode_oneshot      = 0x000000
const simx_opmode_oneshot_wait = 0x010000
const simx_opmode_streaming    = 0x020000
const simx_opmode_buffer       = 0x060000

const simx_return_ok = 0x000000


const library = joinpath(dirname(@__FILE__), "remoteApi.so")
const simx_start_fn = (:simxStart, library)
const simx_finish_fn = (:simxFinish, library)
const simx_get_object_handle_fn = (:simxGetObjectHandle, library)
const simx_read_proximity_sensor_fn = (:simxReadProximitySensor, library)
const simx_get_string_signal_fn = (:simxGetStringSignal, library)
const simx_get_vision_sensor_image_fn = (:simxGetVisionSensorImage, library)
const simx_get_object_position_fn = (:simxGetObjectPosition, library)
const simx_get_object_orientation_fn = (:simxGetObjectOrientation, library)
const simx_set_joint_target_velocity_fn = (:simxSetJointTargetVelocity, library)
const simx_start_simulation_fn = (:simxStartSimulation, library)
const simx_stop_simulation_fn = (:simxStopSimulation, library)

function simx_start(connection_address, connection_port, wait_until_connected,
                    do_dot_reconnect_once_disconnected, timeout_in_ms, comm_thread_cycle_in_ms)
    client_id = ccall(simx_start_fn,
        Cint, (Cstring, Cint, Cuchar, Cuchar, Cint, Cint),
        connection_address, connection_port, wait_until_connected,
        do_dot_reconnect_once_disconnected, timeout_in_ms, comm_thread_cycle_in_ms)
    return client_id
end

function simx_finish(client_id)
    ccall(simx_finish_fn,
        Cvoid, (Cint,),
        client_id)
    return nothing
end

function simx_get_object_handle(client_id, object_name, operation_mode)
    handle = Ref{Cint}(0)
    ret = ccall(simx_get_object_handle_fn,
        Cint, (Cint, Cstring, Ref{Cint}, Cint),
        client_id, object_name, handle, operation_mode)
    return ret, handle[]
end

function simx_read_proximity_sensor(client_id, sensor_handle, operation_mode)
    detection_state = Ref{Cuchar}(0)
    detected_object_handle = Ref{Cint}(0)
    detected_point = Vector{Cfloat}(undef, 3)
    detected_surface_normal_vector = Vector{Cfloat}(undef, 3)
    ret = ccall(simx_read_proximity_sensor_fn,
        Cint, (Cint, Cint, Ref{Cuchar}, Ref{Cfloat}, Ref{Cint}, Ref{Cfloat}, Cint),
        client_id, sensor_handle, detection_state, detected_point, detected_object_handle,
        detected_surface_normal_vector, operation_mode)
    return ret, detection_state[] != 0, detected_point, detected_object_handle[], detected_surface_normal_vector
end

function simx_get_string_signal(client_id, signal_name, operation_mode)
    signal_length = Ref{Cint}(0)
    signal_value = Ref{Ptr{Cuchar}}()
    ret = ccall(simx_get_string_signal_fn,
        Cint, (Cint, Cstring, Ref{Ptr{Cuchar}}, Ref{Cint}, Cint),
        client_id, signal_name, signal_value, signal_length, operation_mode)
    signal_str = unsafe_string(signal_value[], signal_length[])
    return ret, signal_str
end

function simx_unpack_floats(floats_packed_in_string)
    v = Vector{Float32}(undef, 0)
    data = Vector{UInt8}(floats_packed_in_string)
    for i=1:4:length(data)
        n = reinterpret(Float32, data[i:i+3])[1]
        push!(v, n)
    end
    return v
end

function simx_get_vision_sensor_image(client_id, sensor_handle, options, operation_mode)
    resolution = Vector{Cint}(undef, 2)
    image_raw = Ref{Ptr{Cuchar}}()
    bytes_per_pixel = 3
    if (options & 1) != 0
        bytes_per_pixel = 1
    end
    ret = ccall(simx_get_vision_sensor_image_fn,
        Cint, (Cint, Cint, Ref{Cint}, Ref{Ptr{Cuchar}}, Cuchar, Cint),
        client_id, sensor_handle, resolution, image_raw, options, operation_mode)
    if ret != simx_return_ok
        return ret, resolution, Vector{UInt8}(undef, 0)
    end
    image_data = Vector{UInt8}(undef, resolution[1] * resolution[2] * bytes_per_pixel)
    for i=1:length(image_data)
        image_data[i] = unsafe_load(image_raw[], i)
    end
    return ret, resolution, image_data
end

function simx_get_object_position(client_id, object_handle, relative_to_object_handle, operation_mode)
    position = Vector{Cfloat}(undef, 3)
    ret = ccall(simx_get_object_position_fn,
        Cint, (Cint, Cint, Cint, Ref{Cfloat}, Cint),
        client_id, object_handle, relative_to_object_handle, position, operation_mode)
    return ret, position
end

function simx_get_object_orientation(client_id, object_handle, relative_to_object_handle, operation_mode)
    euler_angles = Vector{Cfloat}(undef, 3)
    ret = ccall(simx_get_object_orientation_fn,
        Cint, (Cint, Cint, Cint, Ref{Cfloat}, Cint),
        client_id, object_handle, relative_to_object_handle, euler_angles, operation_mode)
    return ret, euler_angles
end

function simx_set_joint_target_velocity(client_id, joint_handle, target_velocity, operation_mode)
    ret = ccall(simx_set_joint_target_velocity_fn,
        Cint, (Cint, Cint, Cfloat, Cint),
        client_id, joint_handle, target_velocity, operation_mode)
    return ret
end

function simx_start_simulation(client_id, operation_mode)
    ret = ccall(simx_start_simulation_fn,
        Cint, (Cint, Cint),
        client_id, operation_mode)
    return ret
end

function simx_stop_simulation(client_id, operation_mode)
    ret = ccall(simx_stop_simulation_fn,
        Cint, (Cint, Cint),
        client_id, operation_mode)
    return ret
end

end # module VREP
