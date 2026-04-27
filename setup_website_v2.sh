#!/bin/bash
# ============================================================
# Taha Mohammed — Full Website Upgrade v2
# Run from inside: tahamousa2023-prog.github.io/
# ============================================================

echo "Starting full website upgrade v2..."

# ── 1. REWRITE ABOUT PAGE (natural, no AI dividers) ────────
echo "Rewriting About page..."
cat > _pages/about.md << 'ABOUTEOF'
---
permalink: /
title: "About Me"
author_profile: true
redirect_from:
  - /about/
  - /about.html
---

I am a mechatronics engineer and MSc Computational Engineering Science student at TU Berlin, currently completing my Master's thesis at Fraunhofer IPK Berlin. My work sits at the intersection of robot perception, deep learning, and real-world system integration — and I care about building things that actually work outside of controlled lab conditions.

Before coming back to academia, I spent four and a half years at Siemens AG through the Europeans@Siemens programme, working on PLC programming, machine vision systems, robotics integration, and a 4800 MW power plant control system (SPPA-T3000 DCS). That industrial grounding shapes how I approach research: I think in terms of deployability, not just benchmark numbers.

My Master's thesis at Fraunhofer IPK focused on vision-based TCP calibration for collaborative robots. Using a ResNet-18 CNN trained in PyTorch to predict which calibration poses carry the most geometric information, I showed that five intelligently selected poses outperform forty random ones — cutting calibration time by 87.5% and improving accuracy by 76%. The key insight was that pose diversity matters more than pose count, which challenges the standard assumption that more data always helps.

At TU Berlin, I am one of five engineers in the Path Matters project, an automation project investigating how different camera trajectory strategies affect 3D reconstruction quality and efficiency for robotic inspection tasks. My specific responsibility is trajectory planning: designing and evaluating multi-view scanning strategies for a UR5e robot arm operating in NVIDIA Isaac Sim, controlled through ROS2 and MoveIt2. The project also includes a reinforcement learning component trained with PPO in Isaac Lab, where the agent learns to select informative viewpoints autonomously — achieving 45.2% task success compared to 0.4% without reward shaping, and 3.6 times higher coverage than random exploration. I am actively looking for a funded PhD position or industrial doctorate where I can continue this kind of work, ideally in Berlin or Germany.

**Education**

MSc Computational Engineering Science, TU Berlin (2023 – present). Specialisations in Computer Science and Mathematics, Simulation and Optimisation, and Measurement, Control and Regulation. Relevant courses include Applied Deep Learning in Engineering, Motion Planning, Mobile Working Robot, Applied Machine Learning, and Software Engineering eingebetteter Systeme. My thesis, supervised by Prof. Dr.-Ing. Jörg Krüger and M.Sc. Oliver Krumpek, is on development and evaluation of a system for integrating and calibrating a surface processing tool into the system environment of a cobot.

BSc Mechatronics Engineering, Assiut University (2011–2016). Graduated 4th in the mechatronics section. Bachelor thesis: Autonomous Navigation for Flying Robots.

**Experience**

Master's Thesis Researcher, Fraunhofer IPK Berlin (April 2025 – January 2026). Vision-based TCP calibration using CNN (ResNet-18, PyTorch) with sensor fusion of RGB-D data, robot kinematics, and visual odometry under ROS2. Hardware-in-the-loop validation on NVIDIA Jetson Orin NX. Result: 87.5% faster calibration, 76% better accuracy than conventional 40-pose methods.

Mechatronic Systems Developer, TU Berlin (January–December 2025). AI-based image recognition and motor control for pesticide-free agriculture. Real-time deployment on NVIDIA Jetson Orin NX, Orin Nano, and Xavier NX using CUDA and C++. Autonomous system simulation with ROS2 and Gazebo.

Mechatronics Engineer, Siemens AG – Europeans@Siemens Programme (August 2019 – February 2023). Hands-on work across PLC programming, machine vision, robotics, and embedded systems for industrial automation and Industry 4.0. Instrumentation and control at a 4800 MW power plant using SPPA-T3000 DCS. Final project: camera-based sorting system integrating machine vision and a robotic arm.

Projects Engineer, Origin Systems, Cairo (March 2018 – July 2019). Machine-vision automation in the pharmaceutical industry. Commissioned 11 track-and-trace systems at EIPICO and provided technical support for 8 machines at Medical Union Pharmaceutical.

**Technical Skills**

Robotics and simulation: ROS2, Isaac Sim, Isaac Lab, MoveIt2, Gazebo, UR5e, NVIDIA Jetson

AI and deep learning: PyTorch, TensorFlow, ResNet, PPO (RSL-RL), VGGT, Fast3R, SAM3D, YOLO

3D perception: ICP, FPFH, BUFFER-X, Open3D, point cloud registration, RGB-D sensor fusion

Systems and embedded: CUDA, C++, Python, Docker, PLC, DCS, hardware-in-the-loop integration

Industrial: machine vision, camera calibration, LabVIEW, Industry 4.0

**Languages**

Arabic (native), German (C1), English (C1)

**Contact**

📧 taha.mousa2023@gmail.com  — 📍 Berlin, Germany

[LinkedIn](https://linkedin.com/in/taha-mahmoud) · [GitHub](https://github.com/tahamousa2023-prog) · [Download CV](/files/CV_Taha_Mohammed.pdf)

Open to PhD positions, industrial doctorates, research engineer roles, and collaboration.
ABOUTEOF

# ── 2. REWRITE RESEARCH PAGE (natural tone) ────────────────
echo "Rewriting Research page..."
cat > _pages/research.md << 'RESEOF'
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
RESEOF

# ── 3. REWRITE PHD PAGE (natural tone) ─────────────────────
echo "Rewriting PhD page..."
cat > _pages/phd.md << 'PHDEOF'
---
permalink: /phd/
title: "PhD and Collaboration"
author_profile: true
---

I am looking for a funded PhD position or industrial doctorate starting in 2026, in Berlin or Germany. My background combines seven years of engineering practice with current research in robotic perception and learning-based control — which I think is a genuinely useful combination for applied robotics research.

**What I bring to a PhD project**

On the engineering side, I have real deployment experience: four and a half years at Siemens AG working on PLC systems, machine vision, robotics integration, and a 4800 MW power plant control system. I know how industrial robotic cells are actually structured, what goes wrong in practice, and what it means to deliver something that runs reliably in a production environment. At Fraunhofer IPK, I applied this background to a research problem and produced a calibration system that is 87.5% faster and 76% more accurate than the conventional approach — not by using more data, but by selecting better data.

On the research side, I have hands-on experience building end-to-end robotic pipelines: Isaac Sim environments, ROS2 and MoveIt2 motion control, VGGT and Fast3R reconstruction, ICP and BUFFER-X registration, and PPO reinforcement learning in Isaac Lab. I know how these components interact and where the hard integration problems are.

I am a C1 speaker of both German and English, which matters for working in German research institutions and industry partnerships.

**Research areas I want to work in**

3D perception and reconstruction for robotic inspection and manipulation planning. Learning-based trajectory planning and viewpoint selection. Sim-to-real transfer for manipulation and scanning tasks. Data-efficient methods for robot calibration and system identification. Vision-language-action models for industrial robotic systems.

**Institutions I am targeting**

TU Berlin (Robotics and Biology Lab, Control Systems Group, MAR — Institut für Werkzeugmaschinen und Fabrikbetrieb). TU Munich (robotics, AI, computer vision groups). Fraunhofer IPA and IPK. NVIDIA Research, Isaac and Robotics teams. Bosch Research and Siemens Research. German Aerospace Center (DLR).

**Timeline**

Available from February 2026 after Master's thesis submission at Fraunhofer IPK.

**Contact**

If you are a professor, research group leader, or industrial R&D manager and think there might be a good fit — or if you just want to discuss research ideas — I am happy to talk.

📧 [taha.mousa2023@gmail.com](mailto:taha.mousa2023@gmail.com) · [LinkedIn](https://linkedin.com/in/taha-mahmoud) · [Download CV](/files/CV_Taha_Mohammed.pdf)

I reply within 24 hours.
PHDEOF

# ── 4. CREATE PATH MATTERS PORTFOLIO PAGE ─────────────────
echo "Creating Path Matters portfolio page..."
mkdir -p _portfolio
cat > _portfolio/path-matters.md << 'PMEOF'
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
PMEOF

# ── 5. CREATE MASTER THESIS PORTFOLIO PAGE ────────────────
echo "Creating Master Thesis portfolio page..."
cat > _portfolio/fraunhofer-tcp-calibration.md << 'THEOF'
---
title: "Vision-Based TCP Calibration for Collaborative Robots — Fraunhofer IPK"
excerpt: "Deep learning-driven pose selection for robot tool calibration: 5 intelligently chosen poses outperform 40 random ones, with 87.5% faster calibration and 76% better accuracy."
collection: portfolio
date: 2025-03-07
---

This is my Master's thesis, conducted at the Fraunhofer Institute for Production Systems and Design Technology (IPK) in Berlin under Prof. Dr.-Ing. Jörg Krüger and M.Sc. Oliver Krumpek, as part of my MSc Computational Engineering Science at TU Berlin.

The title is: Development and evaluation of a system for integrating and calibrating a surface processing tool into the system environment of a cobot.

**The Problem**

Standard TCP (Tool Center Point) calibration for industrial collaborative robots requires collecting 40 or more calibration poses and running through a lengthy optimisation procedure — typically taking around 80 minutes per calibration cycle. This is a real bottleneck in production environments where robots need to be recalibrated after tool changes or maintenance. The implicit assumption behind current practice is that more data always produces better calibration.

**The Approach**

I trained a ResNet-18 CNN in PyTorch to predict the geometric quality of a calibration pose from the RGB-D camera image, without running the full calibration. The idea is that some poses carry much more information than others — poses with good geometric spread and low redundancy contribute more to the calibration accuracy than poses that are close together or from similar viewing angles. If you can identify the five most informative poses upfront, you do not need the other thirty-five.

The full system runs under ROS2 Humble on a NVIDIA Jetson Orin NX and uses an Azure Kinect RGB-D camera with ArUco marker detection. Calibration itself uses the Tsai-Lenz hand-eye calibration method with Levenberg-Marquardt optimisation.

**Results**

Five intelligently selected poses achieved lower RMS calibration error (11.82 mm) than forty randomly selected poses (20.43 mm) — a 76% improvement in accuracy. Calibration time dropped from 80 minutes to 10 minutes — an 87.5% reduction. Repeatability improved from 3.2 mm to 1.8 mm standard deviation.

A key engineering challenge was inference speed on the Jetson Orin NX: the initial PyTorch model ran at 250 ms per pose, too slow for the closed-loop control requirement of under 100 ms. Switching to a TensorRT-optimised model and reducing input resolution from 1920x1080 to 640x480 brought inference to 45 ms. ArUco marker detection robustness improved from 78% to 96% by adding adaptive histogram equalisation and multi-scale detection.

**What This Shows**

The result challenges the assumption that more calibration data always helps. The quality and geometric diversity of poses matters more than the quantity. This principle extends beyond calibration: it connects to active learning, next-best-view planning, and data-efficient robot learning more broadly — which is one reason I continued working on related problems in the Path Matters trajectory planning project.
THEOF

# ── 6. CREATE SIEMENS PORTFOLIO PAGE ──────────────────────
echo "Creating Siemens portfolio page..."
cat > _portfolio/siemens-engineer.md << 'SIEOF'
---
title: "Industrial Engineering at Siemens AG — Europeans@Siemens Programme"
excerpt: "Four and a half years in industrial automation: PLC programming, machine vision, robotics, and a 4800 MW power plant DCS at Siemens Berlin."
collection: portfolio
date: 2023-02-01
---

From August 2019 to February 2023, I was part of the Europeans@Siemens programme in Berlin — an international dual-education initiative combining structured engineering training with practical project work across Siemens' industrial divisions.

The programme covered PLC programming and industrial control systems, machine vision and sensor integration, robotics and automation systems, embedded systems for Industry 4.0 environments, and high-voltage electrical systems and cabinet wiring to DIN-VDE standards.

The most technically substantial work was instrumentation and control tasks at Siemens' 4800 MW power plant using the SPPA-T3000 Distributed Control System. Working on a live industrial DCS at that scale requires precision, systematic thinking, and an understanding of how safety-critical software behaves under real operating conditions — a very different environment from academic or prototyping contexts.

The final project of the programme was a camera-based sorting system integrating a machine vision pipeline with a robotic arm. This was my first hands-on experience combining computer vision and robotics in an industrial setting, and it directly motivated my later work on vision-based calibration and 3D reconstruction.

This background is what makes my research grounded in practice rather than purely theoretical. I understand what industrial robotic cells look like, what goes wrong in production environments, and what it means to deliver something that works reliably under real operating conditions.
SIEOF

# ── 7. UPGRADE NAVIGATION ─────────────────────────────────
echo "Updating navigation..."
cat > _data/navigation.yml << 'NAVEOF'
main:
  - title: "About"
    url: /
  - title: "Research"
    url: /research/
  - title: "Projects"
    url: /portfolio/
  - title: "Blog"
    url: /year-archive/
  - title: "CV"
    url: /files/CV_Taha_Mohammed.pdf
  - title: "PhD"
    url: /phd/
NAVEOF

# ── 8. UPDATE CONFIG ───────────────────────────────────────
echo "Updating _config.yml..."
python3 - << 'PYEOF'
with open('_config.yml', 'r') as f:
    content = f.read()

content = content.replace('locale                   : "en-US"', 'locale                   : "en-GB"')
content = content.replace('linkedin         : "taha-mohammed-berlin"', 'linkedin         : "taha-mahmoud"')
content = content.replace('linkedin         : "YOUR_LINKEDIN_HERE"', 'linkedin         : "taha-mahmoud"')
content = content.replace('"Your Name"', '"Taha Mohammed"')
content = content.replace('"Your Sidebar Name"', '"Taha Mohammed"')
content = content.replace('"Your Name / Site Title"', '"Taha Mohammed"')
content = content.replace('"Short biography for the left-hand sidebar"', '"Mechatronics Engineer and MSc CES student at TU Berlin. Robotics, deep learning, and 3D perception. Fraunhofer IPK, Siemens AG."')
content = content.replace('"Earth"', '"Berlin, Germany"')
content = content.replace('"Red Brick University"', '"TU Berlin"')
content = content.replace('"none@example.org"', '"taha.mousa2023@gmail.com"')
content = content.replace('github           : "academicpages"', 'github           : "tahamousa2023-prog"')

with open('_config.yml', 'w') as f:
    f.write(content)

print("_config.yml updated.")
PYEOF

# ── 9. CLEAN EMPTY POSTS ──────────────────────────────────
echo "Cleaning empty placeholder posts..."
for f in _posts/2026-01-15-fraunhofer-thesis.md \
          _posts/2026-02-10-rl-ppo-isaac-lab.md \
          _posts/2026-03-01-ur5e-ros2-moveit2.md \
          _posts/2026-03-05-isaac-sim-basler-camera.md \
          _posts/2026-03-08-icp-alignment.md \
          _posts/2026-03-10-fast3r-reconstruction.md \
          _posts/2026-03-10-sam3d-segmentation.md \
          _posts/2026-03-10-vggt-reconstruction.md; do
  if [ -f "$f" ]; then
    # Check if file is basically empty (no real content)
    lines=$(wc -l < "$f")
    if [ "$lines" -lt 15 ]; then
      echo "Removing empty post: $f"
      rm -f "$f"
    fi
  fi
done

# ── 10. CREATE PATH MATTERS BLOG POST ─────────────────────
echo "Creating Path Matters blog post..."
cat > _posts/2026-04-14-path-matters-final-report.md << 'BLOGEOF'
---
title: "Path Matters: What We Built, What We Found, and What Comes Next"
date: 2026-04-14
permalink: /posts/2026/04/path-matters-final-report/
tags:
  - Isaac Sim
  - UR5e
  - ROS2
  - VGGT
  - BUFFER-X
  - ICP
  - Reinforcement Learning
  - PPO
  - 3D Reconstruction
  - TU Berlin
  - Path Matters
---

After six months of work, the Path Matters project is submitted. This post is a summary of what we built, the results we got, and what I personally learned from it. The full report is available through TU Berlin.

The project ran as an automation engineering course at TU Berlin (WiSe 25/26), supervised by Adam Altenbuchner at the Institut für Werkzeugmaschinen und Fabrikbetrieb. Five engineers: Artem Balatsiuk, Aziz Louati, Haroun Lallouche, Taha Mohammed (me), and Ziad Abouhalawa. The question we were trying to answer was simple to state and genuinely hard to answer: does the choice and sequence of camera viewpoints significantly affect the quality of 3D reconstruction from a robotic scanner?

**What we built**

The system is a modular pipeline connecting a UR5e robot arm in NVIDIA Isaac Sim, controlled through ROS2 Humble and MoveIt2, to three reconstruction models (VGGT, Fast3R, SAM3D), and an evaluation pipeline using ICP and BUFFER-X to measure alignment quality against ground-truth meshes. My responsibility was trajectory planning — designing the motion strategies, implementing the ROS2 control pipeline, and running the scanning experiments.

The pipeline has four independent modules that communicate through a shared directory structure: trajectory (viewpoint generation and execution), data (image export and point cloud management), reconstruction (wrapping all three models behind a common interface), and evaluation (ICP registration and metric computation). This design made it possible to swap any component and compare results systematically.

**Reconstruction: VGGT wins clearly**

We evaluated VGGT, Fast3R, and SAM3D on 28 objects drawn from Isaac Sim synthetic data, Google Scanned Objects, T-LESS and Linemod benchmarks, and real-world hand-held captures. Each method received the same set of 12 images from a fixed hemispheric trajectory, and we measured ICP Fitness and RMSE after registration against the ground-truth mesh.

VGGT: Fitness 0.93, RMSE 0.002 m. Fast3R: Fitness 0.89, RMSE 0.010 m. SAM3D: Fitness 0.91, RMSE 0.008 m. All three finish inference in under 10 seconds on our RTX A6000. VGGT wins on both metrics and became the primary reconstruction backbone for all subsequent experiments.

One practical complication: VGGT and Fast3R produce reconstructions in an arbitrary scene-relative scale with no absolute metric information. Before registration, you need to estimate the scale factor. We used a median consensus approach combining three estimators — bounding box diagonal ratio, PCA axis length ratios, and convex hull volume ratio. In extreme mismatch cases, this improved ICP Fitness from 0.0 to 1.0. Without scale correction, the alignment metrics are meaningless.

**Registration: ICP outperforms BUFFER-X here, but context matters**

For our evaluation setting — preprocessed point clouds with reasonable initial alignment — ICP with FPFH initialisation outperformed BUFFER-X on all metrics: Fitness 0.87 versus 0.81, RMSE 0.0041 m versus 0.0063 m, recall above 0.8 threshold at 78.6% versus 67.9%. BUFFER-X is faster (1.8 s versus 3.2 s) and does not require a coarse initial alignment, which makes it useful when RANSAC fails. The two methods are complementary rather than competing.

**Trajectory: camera orientation is the biggest lever**

I ran five scanning patterns (Lawnmower, Zigzag, Hemisphere, Spiral, Random) under two camera orientation strategies. Approach 1: camera always points straight down. Approach 2: camera dynamically points toward the detected object centre at every waypoint.

Approach 1 mean ICP Fitness across all patterns: 0.68. Approach 2 mean: 0.79. The improvement was consistent across every pattern without changing the number of viewpoints or the trajectory geometry. The best single result was Hemisphere with Approach 2: Fitness 0.86, RMSE 0.015 m.

This was the clearest finding of the trajectory experiments: camera orientation matters more than trajectory pattern at this scale. Which pattern you use — lawnmower, hemisphere, spiral — has a secondary effect compared to whether the camera is actually looking at the object from each position. The implementation cost of dynamic object-pointing orientation is modest (slightly more complex IK solutions, around 5% IK failure rate versus 0% for fixed downward, and 0.5 s longer stabilisation pause), and the quality gain is substantial.

**Reinforcement learning: proximity shaping solves the sparse reward problem**

The RL component uses Isaac Lab with 16 parallel UR5e environments, PPO, and an 86-dimensional state space including joint positions, camera pose, coverage percentage, and an 8x8 downsampled voxel coverage map. The agent selects continuous joint position deltas; images are captured automatically every 20 steps.

First experiment (exp_06): coverage rewards only, no signal toward the scanning volume. Task success rate: 0.4%. The robot occasionally stumbled into good positions by chance but could not reproduce the behaviour.

Second experiment (exp_07): added three proximity shaping rewards providing a continuous gradient toward the workspace — a proximity gradient toward the volume centre, a binary reward for being inside the workspace bounds, and a dot-product reward for facing the volume. Task success rate: 45.2%. Coverage: 75% or more per episode. Versus random exploration: 3.6x higher coverage, 75%+ versus 20.6%.

The practical lesson is that proximity shaping is not a nice-to-have: it is necessary for this environment. Without a gradient guiding the robot toward the scanning volume, the coverage rewards never activate and learning stalls. The agent needs to learn to get close before it can learn to scan.

There is a known limitation: the RL agent maximises geometric voxel coverage (frustum-based), not actual reconstruction quality. Coverage and ICP Fitness are correlated but not identical. The obvious next step — and the open research question the project leaves behind — is to replace the geometric coverage metric with direct ICP Fitness or VGGT confidence as the reward signal.

**What I would do differently**

The preprocessing pipeline (RANSAC plane removal, DBSCAN clustering) failed on roughly 15% of objects — either removing part of the object or not finding the table plane. These failures propagated into degraded scale estimation and registration. More robust preprocessing, or replacing it with a learned segmentation approach like YOLO-based semantic crop, would have improved the tail of the distribution.

The RL training stability was also not fully resolved. The exp_07 task success rate peaks near 100% around iteration 1500 before settling at 40–45%. For deployment, you would need to select the peak checkpoint rather than the final one. Entropy coefficient scheduling and learning rate decay would likely improve convergence.

**What comes next**

For me personally, this project confirmed that I want to keep working on robotic perception and learning-based control, specifically the problems around sim-to-real transfer and direct optimisation of reconstruction quality through robot behaviour. The trajectory planning work connects directly to the reward signal design question in the RL component, and both connect to the calibration work I did at Fraunhofer IPK. I am looking for a PhD position where I can develop these threads further.

The full report, code, and results are available on request. If you are working on related problems and want to discuss, feel free to reach out.
BLOGEOF

# ── 11. COMMIT AND PUSH ───────────────────────────────────
echo ""
echo "Committing and pushing all changes..."
git add .
git commit -m "Full website upgrade v2: natural writing, real report data, portfolio pages, Path Matters post"
git push

echo ""
echo "============================================"
echo "Done! Website updates live in 2-3 minutes."
echo "https://tahamousa2023-prog.github.io"
echo "============================================"
