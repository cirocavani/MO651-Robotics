module Robotics

# P3DX
export Robot,
    read_sonar,
    read_laser,
    read_vision,
    get_current_position,
    get_current_orientation,
    set_right_velocity,
    set_left_velocity,
    set_velocity,
    stop,
    release,
    reset_simulation,
# Util
    pose2D,
    show_vision,
    T_r2g,
    coords_global,
    T_g2r,
    coords_robot

include("VREP.jl")
include("P3DX.jl")
include("Util.jl")

end # module Robotics
