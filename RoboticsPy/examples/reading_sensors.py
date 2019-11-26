import time, cv2

from matplotlib import pyplot as plt

from robotics import Robot, vrep2array

def display_image(image):
    """
        Displays a image with matplotlib.
        Args:
            image: The BGR image numpy array. See src/utils.py.
    """
    plt.imshow(image, cmap = 'gray', interpolation = 'bicubic')
    plt.xticks([]), plt.yticks([])  # to hide tick values on X and Y axis
    plt.show()

robot = Robot()

#Reading ultrasonic sensors
ultrasonic = robot.read_ultrasonic_sensors()
print("Ultrasonic: ", ultrasonic)

#Reading laser sensor
laser = robot.read_laser()
print("Laser: ", laser)

#Reading camera
resolution, raw_img = robot.read_vision_sensor()
img = vrep2array(raw_img, resolution)
display_image(img)
