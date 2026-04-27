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
