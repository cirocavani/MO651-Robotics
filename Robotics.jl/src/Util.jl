using Images

function show_vision(robot; size=(800, 800))
    resolution, image_data = read_vision(robot)
    image = imrotate(colorview(RGB, reshape(Float64.(image_data) / 255, 3, Int64.(resolution)...)), 3π/2)
    image = imresize(image, size...)
    return image
end

function pose2D(robot)
    position = get_current_position(robot)
    orientation = get_current_orientation(robot)
    # x, y, θ
    return position[1], position[2], orientation[3]
end

function T_r2g(x, y, θ)
    Ttrans = [1.0 0.0   x
              0.0 1.0   y
              0.0 0.0 1.0]
    Trot = [cos(θ) -sin(θ) 0.0
            sin(θ)  cos(θ) 0.0
               0.0     0.0 1.0]
    return Ttrans * Trot
end

function coords_global(x, y, θ, xr, yr)
    T = T_r2g(x, y, θ)
    R = [xr
         yr
         1]
    xg, yg, _ = T * R

    return xg, yg
end

function T_g2r(x, y, θ)
    Trot = [ cos(θ) sin(θ) 0.0
            -sin(θ) cos(θ) 0.0
                0.0    0.0 1.0]
    Ttrans = [1.0 0.0  -x
              0.0 1.0  -y
              0.0 0.0 1.0]
    return Trot * Ttrans
end

function coords_robot(x, y, θ, xg, yg)
    T = T_g2r(x, y, θ)
    G = [xg
         yg
         1]
    xr, yr, _ = T * G

    return xr, yr
end
