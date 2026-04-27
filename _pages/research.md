---
permalink: /research/
title: "Research Interests"
author_profile: true
---

My research sits at the intersection of robot perception, learning-based control, and real-world deployment. I am drawn to problems where the gap between simulation results and physical performance is the core challenge — which is why I tend to work on pipelines that span from sensor data to robot behaviour, rather than isolated algorithmic contributions.

**3D perception and reconstruction for robotics.** My current work in the Path Matters project involves evaluating VGGT, Fast3R, and SAM3D as reconstruction backbones for robotic inspection, with quantitative comparison using ICP and BUFFER-X registration metrics across 28 objects. VGGT achieved the highest quality (Fitness 0.93, RMSE 0.002 m), and I am interested in understanding when and why learning-based reconstruction models fail — particularly on textureless, symmetric, or occluded industrial parts.

**Trajectory planning and viewpoint selection.** The central question of Path Matters is whether the sequence and geometry of camera viewpoints significantly affects reconstruction quality. Switching from fixed downward orientation to object-pointing orientation improved mean ICP Fitness from 0.68 to 0.79 across five scanning patterns with no change to the number of viewpoints. This result suggests that camera orientation is a larger controllable factor than trajectory geometry, which has implications for how inspection paths are designed in industrial deployments.

**Reinforcement learning for robotic scanning.** The RL component of Path Matters uses PPO in Isaac Lab to train a UR5e agent to maximise volumetric workspace coverage by selecting informative viewpoints. The main challenge was the sparse reward problem: without a gradient signal toward the scanning volume, the agent achieved only 0.4% task success. Adding proximity shaping rewards resolved this, reaching 45.2% success and 3.6x higher coverage than random exploration. I am interested in tighter integration between reconstruction quality and the reward signal — using ICP Fitness or VGGT confidence directly rather than geometric voxel coverage as a proxy.

**Data-efficient robot calibration.** My Fraunhofer thesis showed that a CNN trained to score calibration pose quality enables five poses to outperform forty random ones in TCP calibration accuracy. The underlying principle — that data diversity and geometric coverage matter more than data volume — extends beyond calibration and connects to active learning, next-best-view planning, and adaptive sampling in robotics more broadly.

**Sim-to-real transfer.** All Path Matters experiments run in Isaac Sim, and I am interested in what it takes to close the gap to the physical UR5e robot. The simulated Basler camera does not replicate real sensor noise or lens distortion, and the trained RL policy was not yet validated on hardware. Domain randomisation, photorealistic rendering, and calibrated sensor modelling are the open problems I expect to work on next.

**Open questions I am thinking about**

Can reconstruction quality (ICP Fitness, RMSE) replace hand-crafted geometric metrics as the RL reward signal, and does this change the kind of trajectories the agent learns? How many viewpoints does a robot actually need to achieve a given reconstruction quality threshold, and how does this depend on object geometry? What is the right state representation for a viewpoint selection agent — partial point cloud, voxel grid, or learned embedding? How do you validate a sim-trained scanning policy on a physical robot without collecting thousands of real trajectories?

**Looking for**

I am actively looking for a funded PhD or industrial doctorate position in one or more of these areas, ideally starting in 2026 and based in Berlin or Germany. If you work on intelligent robotic systems, perception-action loops, learning for manipulation, or related topics and think there might be a good fit, I would be glad to talk.

📧 [taha.mousa2023@gmail.com](mailto:taha.mousa2023@gmail.com) · [LinkedIn](https://linkedin.com/in/taha-mahmoud)
