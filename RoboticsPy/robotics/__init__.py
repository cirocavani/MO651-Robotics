from .vrepConst import *
from .vrep import *
from .p3dx import *
from .utils import *
from .envs import *

from gym.envs.registration import register

register(
    id='p3dx-empty-v0',
    entry_point='robotics:P3DXEmptyEnv',
)
