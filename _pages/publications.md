---
layout: archive
title: "Publications"
permalink: /publications/
author_profile: true
---

## Journal Papers

**Camera-Orientation Effects in Robotic Viewpoint Acquisition for Feed-Forward 3D Reconstruction in Manufacturing Inspection Workcells**

Adam Michael Altenbuchner, Richard Matthias Hartisch, **Taha Mohammed**, Ziad Abouhalawa, Artem Balatsiuk, Aziz Louati, Haroun Lallouche, JÃ¶rg KrÃ¼ger.

*The International Journal of Advanced Manufacturing Technology* (Springer) â€” **under review**, submitted June 2026.

**Abstract.** This paper evaluates camera orientation as a controllable acquisition variable in a simulation-based robotic inspection pipeline combining UR5e eye-in-hand viewpoint execution in NVIDIA Isaac Sim, feed-forward reconstruction (VGGT, Fast3R, SAM3D), point-cloud preprocessing, metric-scale correction, and registration-based comparison against reference geometry. VGGT achieved the highest mean registration fitness (0.93) and lowest mean inlier RMSE (0.002 m) across a 28-object evaluation set. Across five reproducible scan patterns, object-pointing camera orientation increased mean registration fitness from 0.68 to 0.79 and reduced mean inlier RMSE from 0.035 m to 0.022 m versus fixed-downward orientation. A coverage-oriented RL module (PPO, Isaac Lab) required dense proximity reward shaping before sparse coverage rewards supported reliable exploration (45.2% success vs 0.4%).

**My contribution:** Data preparation and validation â€” dataset curation, ground-truth geometry preparation, and evaluation pipeline support across the 28-object registration protocol.

[Code and data](https://github.com/Adam-yes/robotic-viewpoint-acquisition-for-3d-reconstruction)

---

## Technical White Papers

**Path Matters: Reinforcement-Learning-Driven Camera Trajectory Optimization for Robotic 3D Reconstruction**

Taha Mohammed. *TU Berlin*, 2026.

Technical white paper documenting the MDP formulation, PPO training, reward shaping methodology, experimental results across multiple training seeds (with variance), and explicit limitations. Reports 45.2% task success versus 0.4% random-trajectory baseline under matched step budgets, with mean VGGT fitness 0.93 on held-out evaluation objects.

[White paper PDF](https://github.com/tahamousa2023-prog/path-matters-robotics/blob/main/whitepaper.pdf) Â· [Repository](https://github.com/tahamousa2023-prog/path-matters-robotics)
