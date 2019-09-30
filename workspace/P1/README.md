# P3DX Locomotion

The general objective of this work is to build, on the V-REP robotic simulator, an odometry and feature extraction system for the Pioneer P3-DX robot.

[ [Specification (PDF)](https://www.ic.unicamp.br/~esther/teaching/2019s2/mo651/P1.pdf) ]

## Content

[**P3DX Kinematic Model**](P3DX%20Kinematic%20Model.ipynb) ([NBViewer](https://nbviewer.jupyter.org/github/cirocavani/MO651-Robotics/blob/master/workspace/P1/P3DX%20Kinematic%20Model.ipynb))

Kinematic model of the differential robot P3DX.


[**P3DX Sensor Data**](P3DX%20Sensor%20Data.ipynb) ([NBViewer](https://nbviewer.jupyter.org/github/cirocavani/MO651-Robotics/blob/master/workspace/P1/P3DX%20Sensor%20Data.ipynb))

Sensor data aquisition as the robot P3DX moves around.


[**P3DX Sensor Analysis**](P3DX%20Sensor%20Analysis.ipynb) ([NBViewer](https://nbviewer.jupyter.org/github/cirocavani/MO651-Robotics/blob/master/workspace/P1/P3DX%20Sensor%20Analysis.ipynb))

Sensor data visualization.


[**sensor-data.csv**](sensor-data.csv)

Sensor data.

Format 1697 columns:

* `timestamp` (1 column, float, seconds)
* `x`, `y`, `z` (position, 3 columns, float, meters, global coordinates)
* `alpha`, `beta`, `gamma` (orientation, 3 columns, float, radians, global coordinates)
* `us_1`-`us_16` (ultrasound sensor readings, 16 columns, float, meters, robot coordinates)
* `laser_1_x`-`laser_558_z` (laser sensor readings, 1674 columns, float, meters, robot coordinates)
    - at most 558 readings of each x, y, z component (empty when no readings)
