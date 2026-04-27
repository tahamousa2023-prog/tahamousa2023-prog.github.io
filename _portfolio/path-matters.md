---
title: "Path Matters: Learning Optimal Inference-Time Trajectories for Robotic 2D to 3D AI Reconstruction"
excerpt: "Full pipeline for robotic 3D reconstruction in Isaac Sim: trajectory planning, VGGT reconstruction, ICP and BUFFER-X registration, and PPO reinforcement learning for viewpoint selection."
collection: portfolio
date: 2026-04-14
---

Path Matters is a five-person automation project at TU Berlin (WiSe 25/26), supervised by Adam Altenbuchner at the Institut für Werkzeugmaschinen und Fabrikbetrieb. The central question is whether the choice and sequence of camera viewpoints significantly affects the quality of 3D reconstruction, and whether a reinforcement learning agent can learn to make better viewpoint decisions than hand-designed trajectory patterns.

My responsibility in the project was trajectory planning: designing and evaluating the motion strategies used to position the UR5e camera arm, implementing the ROS2 and MoveIt2 control pipeline, and running the scanning experiments that underpin the trajectory comparison results.

**System Overview**

The pipeline connects four independent modules. The trajectory module generates and executes viewpoint sequences through Isaac Sim and ROS2. The data module manages image export and point cloud conversion. The reconstruction module wraps VGGT, Fast3R, and SAM3D behind a common interface. The evaluation module performs ICP registration and computes Fitness and RMSE against ground-truth meshes. All modules communicate through a shared configuration file and standardised directory structure, so any component can be replaced without touching the others.

The robot is a UR5e with a Basler camera mounted at the wrist in an eye-in-hand configuration. The simulation runs in Isaac Sim 5.1 with Isaac Lab 0.48, robot control runs through ROS2 Humble and MoveIt2 with KDL inverse kinematics, and all experiments run on a workstation with an NVIDIA RTX A6000 GPU and Intel Core i9-14900K CPU.

**Reconstruction Results (28 objects)**

Three reconstruction methods were evaluated on a fixed evaluation set of 28 objects from four sources: a synthetic Isaac Sim dataset, Google Scanned Objects, T-LESS and Linemod benchmarks, and real-world hand-held captures.

VGGT achieved the highest Fitness (0.93) and lowest RMSE (0.002 m), outperforming both Fast3R (Fitness 0.89, RMSE 0.010 m) and SAM3D (Fitness 0.91, RMSE 0.008 m) while maintaining comparable inference time of around 7 seconds. VGGT was selected as the primary reconstruction backbone for all subsequent experiments.

**Registration Results**

ICP with FPFH initialisation outperformed BUFFER-X on all metrics: Fitness 0.87 versus 0.81, RMSE 0.0041 m versus 0.0063 m, and recall above the 0.8 threshold at 78.6% versus 67.9%. BUFFER-X is faster (1.8 s versus 3.2 s) and more robust when RANSAC initialisation fails, making the two methods complementary rather than competing.

**Trajectory Experiments**

Five trajectory patterns were evaluated under two camera orientation strategies. Approach 1 keeps the camera pointing straight down at all waypoints. Approach 2 computes the orientation dynamically at each waypoint so the optical axis always points toward the detected object centre.

Approach 1 mean results across all patterns: ICP Fitness 0.68, RMSE 0.035 m. Approach 2 mean results: ICP Fitness 0.79, RMSE 0.022 m. The improvement was consistent across all five patterns (Lawnmower, Zigzag, Hemisphere, Spiral, Random) with no change to trajectory geometry or number of viewpoints. Camera orientation turned out to be the single largest controllable factor in reconstruction quality.

The best result was Hemisphere with Approach 2: Fitness 0.86, RMSE 0.015 m. This served as the fixed-trajectory baseline for comparison with the RL policy.

**Reinforcement Learning Results**

The RL environment uses Isaac Lab with 16 parallel UR5e robots, PPO with an MLP policy, and an 86-dimensional state space including joint positions, camera pose, coverage percentage, and an 8x8 downsampled voxel coverage map.

The first experiment (exp_06) used coverage rewards only, with no signal guiding the robot toward the scanning volume. Task success rate: 0.4%. The robot occasionally found good positions by chance but could not reproduce the behaviour consistently.

The second experiment (exp_07) added proximity shaping rewards providing a continuous gradient toward the workspace volume. Task success rate: 45.2% — a 113x improvement. Coverage achieved: 75% or more per episode. The trained policy achieved 3.6x higher coverage than a random baseline, and 75%+ coverage versus 20.6% for random exploration.

The proximity shaping approach resolved the sparse reward problem: the agent first learns to approach the scanning volume, then learns to scan effectively. Without the proximity gradient, coverage rewards never activate because the robot is too far from the workspace to trigger them.

**Key Findings**

Camera orientation is the single largest controllable factor in reconstruction quality at this scale, more impactful than trajectory pattern geometry or number of viewpoints. VGGT outperforms Fast3R and SAM3D on alignment quality for this task. ICP with FPFH initialisation outperforms BUFFER-X when a reasonable coarse estimate is available. Proximity shaping is essential for RL-based viewpoint selection — sparse coverage rewards alone are insufficient for learning in this environment. The modular pipeline architecture enables reproducible cross-method comparisons by allowing any component to be swapped independently.

**Team**

Artem Balatsiuk, Aziz Louati (documentation and reporting), Haroun Lallouche (point cloud evaluation), Taha Mohammed (trajectory planning), Ziad Abouhalawa (reconstruction and project coordination).

Supervisor: Adam Altenbuchner, Institut für Werkzeugmaschinen und Fabrikbetrieb, TU Berlin.

Submission: April 14, 2026.
