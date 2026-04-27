---
permalink: /research/
title: "Research Interests"
author_profile: true
---

## Research Vision

I am interested in building robotic systems that perceive, reason,
and act reliably in unstructured real-world environments — combining
classical engineering rigour with modern learning-based methods.

---

## Core Research Areas

**3D Perception and Scene Reconstruction**

How can robots build accurate 3D models of their environment from
limited observations? My current work explores multi-view reconstruction
(VGGT, Fast3R), point cloud registration (BUFFER-X, ICP), and how
reconstruction quality can drive robot behaviour. We achieved 81.7%
fitness and 2.87 cm RMSE on real industrial objects using a zero-shot
pipeline — no domain-specific retraining.

**Learning-Based Robot Control**

How can robots learn optimal policies without hand-crafted rules?
I work on PPO-based trajectory optimisation in Isaac Lab, using
alignment quality metrics as reward signals — connecting perception
directly to decision-making. The core research question: which camera
viewpoints give the best 3D reconstruction with the fewest captures?

**Sim-to-Real Transfer**

How can simulation-trained policies transfer to physical hardware?
My experience with Isaac Sim, ROS2, MoveIt2, and the UR5e gives me
a practical understanding of the sim-to-real gap in manipulation tasks.

**Data-Efficient Robot Calibration**

How can we reduce the data requirements for robot calibration without
sacrificing accuracy? My Fraunhofer thesis demonstrated that intelligent
pose selection using CNNs outperforms brute-force data collection —
5 poses beat 40 random poses, 87.5% faster, 76% more accurate.

---

## Open Research Questions I Care About

- Can reconstruction quality replace hand-crafted reward functions in RL?
- How many viewpoints does a robot actually need for reliable 3D reconstruction?
- How do we efficiently transfer Isaac Lab policies to real UR5e arms?
- Can BUFFER-X-style zero-shot registration generalise to grasping pipelines?
- What is the minimum data needed for reliable robot calibration?

---

## Current Projects

**Path Matters — TU Berlin (WiSe 25/26)**
RL-driven camera trajectory optimisation for robotic 3D reconstruction.
Isaac Sim · UR5e · ROS2 · VGGT · BUFFER-X · ICP · PPO

**Vision-Based TCP Calibration — Fraunhofer IPK (2024–2025)**
CNN-based intelligent pose selection for robot calibration.
ResNet-18 · PyTorch · ROS2 · Azure Kinect · NVIDIA Jetson Orin NX

---

## Looking For

I am actively seeking a **funded PhD position** or **Industrial Doctorate**
with a focus on one or more of the above areas — ideally in Berlin or
Germany, with strong industry connection.

If your research group works on intelligent robotic systems,
perception-action loops, or learning for manipulation:

📧 [taha.mousa2023@gmail.com](mailto:taha.mousa2023@gmail.com) ·
[LinkedIn](https://linkedin.com/in/taha-mahmoud)
