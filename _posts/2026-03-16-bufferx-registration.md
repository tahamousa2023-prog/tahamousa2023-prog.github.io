---
title: "BUFFER-X: Zero-Shot Point Cloud Registration in Isaac Sim"
date: 2026-03-16
permalink: /posts/2026/03/bufferx-registration/
tags:
  - Isaac Sim
  - Point Cloud
  - 3D Reconstruction
  - ROS2
  - TU Berlin
  - Robotics
  - BUFFER-X
---

## Overview

As part of the **Path Matters** project at TU Berlin, this week I integrated 
**BUFFER-X** into our robotic 2D→3D reconstruction pipeline. BUFFER-X is a 
zero-shot point cloud registration method published as an **ICCV 2025 Highlight 
paper** by MIT SPARK Lab. It aligns two 3D point clouds into the same coordinate 
frame without any retraining or fine-tuning — across any scene or sensor type.

---

## The Problem We Were Solving

Our pipeline uses a **UR5e robot arm** with a simulated **Basler camera** in 
**NVIDIA Isaac Sim** to capture multiple views of an object and reconstruct it 
in 3D. The reconstruction methods we tested — VGGT, Fast3R, and SAM3D — each 
produce point clouds in their own coordinate frames.

The challenge: **ICP (Iterative Closest Point)** alignment was failing because 
it had no reliable initial pose to start from. Without a good starting point, 
ICP diverges and gives wrong results.

**BUFFER-X solves this** by providing a robust initial alignment before ICP runs.

---

## Where BUFFER-X Fits in Our Pipeline
```
Isaac Sim Scene
      ↓
Basler Camera Capture
      ↓
.PLY Export + Ground Truth Pose
      ↓
2D→3D Reconstruction (VGGT / Fast3R / SAM3D)
      ↓
Preprocessing (remove background)
      ↓
BUFFER-X Initial Alignment   ← NEW
      ↓
ICP Refinement
      ↓
Fitness / RMSE Score → RL Reward Signal
```

---

## What is BUFFER-X?

BUFFER-X (Balanced Unified Feature-based Framework for Extended Registration) 
works in two stages:

1. **Descriptor stage** — extracts local geometric features using a 
PointNet++ backbone with multi-scale grouping
2. **Pose estimation stage** — uses RANSAC or KISS-Matcher to find the 
optimal 6-DoF rigid transformation T ∈ SE(3)

Key facts:
- Only **0.91M trainable parameters** — extremely lightweight
- **~1 second** per point cloud pair
- Trained once on indoor RGB-D data → works on outdoor LiDAR, 
synthetic Isaac Sim data, and more
- **ICCV 2025 Highlight** · MIT SPARK Lab

---

## Benchmark Results — 3DMatch Indoor Dataset

I ran the full 3DMatch benchmark (1623 point cloud pairs) on our machine 
with an NVIDIA RTX A6000.

| Metric | Result |
|--------|--------|
| **Recall** | 97.1% |
| **RMSE Recall** | 95.2% |
| **RTE** | 5.79 cm |
| **RRE** | 1.80° |
| **Failed pairs** | 47 / 1623 |
| **Inference time** | ~0.89 s per pair |
| **Total runtime** | 28 minutes |

### Why did 47 pairs fail?

The failures fall into two clear categories:

**1. Symmetric scenes (majority of failures)**
These have RRE near 90°, 125°, or exactly 180° — the scene geometry is 
rotationally symmetric (empty corridors, white walls, repetitive patterns). 
No registration method can reliably distinguish these orientations.
```
Example: fragment 798 → RRE: 180.00° (perfect flip — geometrically identical)
```

**2. Low-overlap pairs**
The two scans share very little overlapping geometry. With insufficient 
matching surface, no reliable transformation can be estimated.
```
Example: fragment 1544 → RRE: 1.89°, RTE: 1.15m
```

These are fundamental data challenges, not model failures.

---

## Custom Test — Isaac Sim Basler Camera

I tested BUFFER-X on our own dataset: a **Baby Yoda figurine** scanned 
in Isaac Sim using a simulated Basler camera.

**Setup:**
- Ground truth: `Baby_Yoda.ply` — 10,000 points, clean object, no color
- Reconstruction: `points.ply` — 100,000 points, full scene with RGB color

**Command:**
```bash
python compare.py Test/Baby_Yoda.ply Test/points.ply
```

**Results:**

| Metric | Value |
|--------|-------|
| **Fitness** | 0.3342 |
| **RMSE** | 0.0287 m (2.87 cm) |

### Before Alignment
![Before alignment — blue cloud misaligned with red ground truth](/images/before1.png)

### After Alignment
![After alignment — green cloud aligned with red ground truth](/images/After1.png)

### Why is Fitness 0.33?

The Fitness score of 0.33 means 33% of points were matched — which looks 
low but has a clear explanation: `points.ply` contains 100,000 points 
including the **full Isaac Sim scene background** (table, walls, floor), 
while `Baby_Yoda.ply` is a clean 10,000-point isolated object model.

The background clutter counts as unmatched points, pulling Fitness down. 
The **RMSE of 2.87 cm on matched points** shows the object itself aligned 
correctly — confirmed visually in the After image above.

**Next step:** run our preprocessing pipeline (background removal, 
outlier filtering) on `points.ply` before comparison — this is already 
part of our pipeline from the interim presentation.

---

## Key Takeaway

BUFFER-X gives ICP a reliable initial pose — without it, ICP was diverging 
on our Isaac Sim data. The zero-shot capability means it works on our 
completely unseen Isaac Sim Basler camera data without any retraining, 
which is exactly what our pipeline needs.

The Fitness and RMSE scores output by BUFFER-X can also feed directly into 
our **PPO reinforcement learning reward function** — replacing the current 
geometric heuristics with a direct alignment quality signal.

---

## Tools & Setup

| Component | Version |
|-----------|---------|
| OS | Ubuntu 22.04 LTS |
| Python | 3.8 |
| PyTorch | 1.9.1+cu111 |
| CUDA | 11.1 |
| GPU | NVIDIA RTX A6000 (49GB) |
| Open3D | 0.13.0 |

---

## Resources

- [BUFFER-X GitHub](https://github.com/MIT-SPARK/BUFFER-X)
- [BUFFER-X Paper (arXiv)](https://arxiv.org/abs/2503.07940)
- [Path Matters Project — TU Berlin]()
- [3DMatch Dataset](http://3dmatch.cs.princeton.edu/)
