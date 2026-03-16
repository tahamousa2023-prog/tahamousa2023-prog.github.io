---
title: "Path Matters: Learning Optimal Inference-Time Trajectories 
for Robotic 2D→3D AI Reconstruction"
excerpt: "Reinforcement learning-guided camera trajectory optimization 
for robotic 3D reconstruction using Isaac Sim, UR5e, ROS2 and deep learning."
collection: portfolio
date: 2026-03-16
---

## Project Overview

**Institution:** Technische Universität Berlin  
**Course:** Automation Project — Industrial Automation Technology  
**Semester:** WiSe 25/26  
**Supervisor:** Adam Altenbuchner  
**Team:** Group 03

## Core Question
How do different viewpoint sequences and trajectory strategies 
affect reconstruction quality, completeness and efficiency?

## Goals
- Adaptive pipeline: optimize viewpoint selection and 
reconstruction jointly for quality and efficiency
- Learning-based optimization: guide robot toward informative 
views while minimizing frames required
- Reliable 3D reconstruction with reduced data requirements

## System Setup
- **Robot:** UR5e collaborative arm
- **Simulation:** NVIDIA Isaac Sim + Isaac Lab
- **Motion Planning:** ROS2 Humble + MoveIt2
- **Camera:** Simulated Basler RGB-D camera

## Pipeline
```
Isaac Sim → Basler Camera → .PLY Export
→ 2D→3D Reconstruction → Preprocessing
→ BUFFER-X Alignment → ICP Refinement
→ Fitness/RMSE → RL Reward Signal
```

## Methods Explored

| Method | Purpose | Status |
|--------|---------|--------|
| VGGT | 3D Gaussian Splatting reconstruction | ✅ Tested |
| Fast3R | Transformer-based reconstruction | ✅ Tested |
| SAM3D | 3D segmentation | ✅ Tested |
| ICP | Point cloud alignment | ✅ Integrated |
| BUFFER-X | Zero-shot registration | ✅ Integrated |
| PPO (RL) | Trajectory optimization | 🔄 In training |

## Reinforcement Learning Setup

| Component | Detail |
|-----------|--------|
| Agent | Neural network (MLP) |
| Environment | Isaac Sim + UR5e |
| State | Joint positions, camera pose, object location |
| Action | 6 joint movements + capture trigger |
| Algorithm | Proximal Policy Optimization (PPO) |

## Reward Structure

| Reward Term | Weight | Purpose |
|-------------|--------|---------|
| camera_facing_object | +10 | Point camera at object |
| object_in_frame | +3 | Keep object visible |
| capture_bonus | +5 | Reward each capture |
| viewpoint_diversity | +4 | Reward new angles |
| task_completion | +15 | Bonus for 8 captures |
| action_rate | -0.001 | Smooth motion |
| joint_velocity | -0.0001 | Prevent jerky movement |

## Key Results

**BUFFER-X on 3DMatch benchmark:**
- Recall: 97.1% — RMSE Recall: 95.2%
- RTE: 5.79 cm — RRE: 1.80°

**Isaac Sim Custom Test:**
- Fitness: 0.3342 — RMSE: 2.87 cm

## Presentations
📊 [Interim Presentation](/files/PathMatters_Interim.pptx)  
📊 [BUFFER-X Weekly Meeting](/files/BUFFERX_PathMatters_Weekly.pptx)

## Related Posts
- [BUFFER-X Integration](/posts/2026/03/bufferx-registration/)
- [ICP Alignment Pipeline]()
- [RL PPO Training in Isaac Lab]()
- [UR5e + ROS2 + MoveIt2 Setup]()
```

---

## What Your Website Will Look Like When Complete
```
Home          → your bio, photo, TU Berlin, Siemens, Fraunhofer
Blog Posts    → 10 technical posts with results + images + videos
Portfolio     → 4 projects with full descriptions
CV            → downloadable PDF
