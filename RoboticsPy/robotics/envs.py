import gym

from gym.spaces import Box

import numpy as np

from .p3dx import Robot, reset, release

class P3DXEmptyEnv(gym.Env):

    def __init__(self):
        self.robot = None
        self.action_space = Box(low=-5.0, high=5.0, shape=(2,), dtype=np.float32)
        self.observation_space = None

    def read_sensors(self):
        sonar = self.robot.read_ultrasonic_sensors()
        laser = self.robot.read_laser()
        return sonar, laser

    def compute_reward(self):
        return 1.0

    def step(self, action):
        """Run one timestep of the environment's dynamics. When end of
        episode is reached, you are responsible for calling `reset()`
        to reset this environment's state.

        Accepts an action and returns a tuple (observation, reward, done, info).

        Args:
            action (object): an action provided by the agent

        Returns:
            observation (object): agent's observation of the current environment
            reward (float) : amount of reward returned after previous action
            done (bool): whether the episode has ended, in which case further step() calls will return undefined results
            info (dict): contains auxiliary diagnostic information (helpful for debugging, and sometimes learning)
        """
        self.robot.set_left_velocity(action[0])
        self.robot.set_right_velocity(action[1])
        observation = self.read_sensors()
        reward = self.compute_reward()
        done = False
        info = dict()
        return observation, reward, done, info

    def reset(self):
        """Resets the state of the environment and returns an initial observation.

        Returns:
            observation (object): the initial observation.
        """
        if self.robot is not None:
            release(self.robot)
            self.robot = None
        reset()
        self.robot = Robot()
        observation = self.read_sensors()
        return observation

    def close(self):
        """Override close in your subclass to perform any necessary cleanup.

        Environments will automatically close() themselves when
        garbage collected or when the program exits.
        """
        if self.robot is not None:
            release(self.robot)
            self.robot = None
