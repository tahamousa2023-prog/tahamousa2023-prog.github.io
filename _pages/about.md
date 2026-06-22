---
permalink: /
title: "About Me"
excerpt: "About me"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---

I am a mechatronics engineer and MSc Computational Engineering Science student at TU Berlin, currently completing my Master's thesis at Fraunhofer IPK Berlin. My work sits at the intersection of robot perception, deep learning, and real-world system integration â€” and I care about building things that actually work outside of controlled lab conditions.

Before coming back to academia, I spent four and a half years at Siemens AG through the Europeans@Siemens programme, working on PLC programming, machine vision systems, robotics integration, and a 4800 MW power plant control system (SPPA-T3000 DCS). That industrial grounding shapes how I approach research: I think in terms of deployability, not just benchmark numbers.

My Master's thesis at Fraunhofer IPK focused on vision-based TCP calibration for collaborative robots. Using a ResNet-18 CNN trained in PyTorch to predict which calibration poses carry the most geometric information, I showed that five intelligently selected poses outperform forty random ones â€” cutting calibration time by 87.5% and improving accuracy by 76%. The key insight was that pose diversity matters more than pose count, which challenges the standard assumption that more data always helps.

At TU Berlin, I am part of the team behind the [Path Matters project](https://github.com/tahamousa2023-prog/path-matters-robotics), investigating how different camera trajectory strategies affect 3D reconstruction quality for robotic inspection tasks. The work uses a UR5e robot arm in NVIDIA Isaac Sim, controlled through ROS2 and MoveIt2, with VGGT, Fast3R, and SAM3D as interchangeable reconstruction backbones evaluated via ICP/FPFH registration against ground-truth geometry across 28 objects. A key result is that switching from fixed-downward to object-pointing camera orientation improves mean ICP fitness from 0.68 to 0.79 across five scan patterns â€” with no change to the number of viewpoints. A reinforcement learning component (PPO, Isaac Lab) achieves 45.2% task success on coverage-seeking viewpoint behaviour versus 0.4% without reward shaping, and requires dense proximity shaping before sparse coverage rewards become useful. I wrote the project's [technical white paper](https://github.com/tahamousa2023-prog/path-matters-robotics/blob/main/whitepaper.pdf) documenting the MDP formulation, reward design, experimental results, and limitations.

This work led to a co-authored journal paper, currently under review at the **International Journal of Advanced Manufacturing Technology** (Springer):

> Altenbuchner, A.M., Hartisch, R.M., **Mohammed, T.**, Abouhalawa, Z., Balatsiuk, A., Louati, A., Lallouche, H., KrÃ¼ger, J. (2026). *Camera-Orientation Effects in Robotic Viewpoint Acquisition for Feed-Forward 3D Reconstruction in Manufacturing Inspection Workcells.* The International Journal of Advanced Manufacturing Technology. Under review.

**Education**

MSc Computational Engineering Science, TU Berlin (2023 â€“ present). Specialisations in Computer Science and Mathematics, Simulation and Optimisation, and Measurement, Control and Regulation. Relevant courses include Applied Deep Learning in Engineering, Motion Planning, Mobile Working Robot, Applied Machine Learning, and Software Engineering eingebetteter Systeme. My thesis, supervised by Prof. Dr.-Ing. JÃ¶rg KrÃ¼ger and M.Sc. Oliver Krumpek, is on development and evaluation of a system for integrating and calibrating a surface processing tool into the system environment of a cobot.

BSc Mechatronics Engineering, Assiut University (2011â€“2016). Graduated 4th in the mechatronics section. Bachelor thesis: Autonomous Navigation for Flying Robots.

**Experience**

Master's Thesis Researcher, Fraunhofer IPK Berlin (April 2025 â€“ January 2026). Vision-based TCP calibration using CNN (ResNet-18, PyTorch) with sensor fusion of RGB-D data, robot kinematics, and visual odometry under ROS2. Hardware-in-the-loop validation on NVIDIA Jetson Orin NX. Result: 87.5% faster calibration, 76% better accuracy than conventional 40-pose methods.

Mechatronic Systems Developer, TU Berlin (Januaryâ€“December 2025). AI-based image recognition and motor control for pesticide-free agriculture. Real-time deployment on NVIDIA Jetson Orin NX, Orin Nano, and Xavier NX using CUDA and C++. Autonomous system simulation with ROS2 and Gazebo.

Mechatronic Systems Engineer, Siemens AG â€“ Europeans@Siemens Programme (August 2019 â€“ February 2023). Hands-on work across PLC programming, machine vision, robotics, and embedded systems for industrial automation and Industry 4.0. Instrumentation and control at a 4800 MW power plant using SPPA-T3000 DCS. Final project: camera-based sorting system integrating machine vision and a robotic arm.

Projects Engineer, Origin Systems, Cairo (March 2018 â€“ July 2019). Machine-vision automation in the pharmaceutical industry. Commissioned 11 track-and-trace systems at EIPICO and provided technical support for 8 machines at Medical Union Pharmaceutical.

**Technical Skills**

Robotics and simulation: ROS2, Isaac Sim, Isaac Lab, MoveIt2, Gazebo, UR5e, NVIDIA Jetson

AI and deep learning: PyTorch, TensorFlow, ResNet, PPO (RSL-RL), VGGT, Fast3R, SAM3D, YOLO

3D perception: ICP, FPFH, BUFFER-X, Open3D, point cloud registration, RGB-D sensor fusion

Systems and embedded: CUDA, C++, Python, Docker, PLC, DCS, hardware-in-the-loop integration

Industrial: machine vision, camera calibration, LabVIEW, Industry 4.0

**Languages**

Arabic (native), German (C1), English (C1)

**Contact**

ðŸ“§ taha.mousa2023@gmail.com â€” ðŸ“ Berlin, Germany

[LinkedIn](https://linkedin.com/in/taha-mahmoud) Â· [GitHub](https://github.com/tahamousa2023-prog) Â· [Download CV](https://tahamousa2023-prog.github.io/files/CV_Taha_Mohammed.pdf)

Open to Applied Science internships, research engineer roles, PhD positions, and industrial doctorates in robotics, computer vision, machine learning, and reinforcement learning.
