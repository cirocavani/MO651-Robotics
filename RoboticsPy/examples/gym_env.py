import gym

env = gym.make('robotics:p3dx-empty-v0')

observation = env.reset()
for t in range(1, 100+1):
    action = env.action_space.sample()
    observation, reward, done, info = env.step(action)
    if done:
        print(f"Episode finished after {t} timesteps")
        break
env.close()
