---
title: "Vision-Based TCP Calibration for Collaborative Robots Using Deep Learning"
date: 2025-03-07
permalink: /posts/2025/03/master-thesis-tcp-calibration/
tags:
  - ROS2
  - PyTorch
  - Computer Vision
  - Calibration
  - UR5e
  - Fraunhofer IPK
  - Deep Learning
  - TU Berlin
---

An intelligent vision-based calibration system developed at **Fraunhofer IPK** 
and **TU Berlin** that reduces industrial robot TCP calibration time by 87.5% 
while improving accuracy by 76% through deep learning-driven pose selection.

---
<img src="{{ "/images/Fig2.png" | relative_url }}" width="50%">
## 1. Project Overview

<img src="{{ "/images/Fig1.png" | relative_url }}" width="50%">

**One-sentence summary:** An intelligent vision-based calibration system that 
reduces industrial robot TCP calibration time by 87.5% while improving accuracy 
by 76% through deep learning-driven pose selection.



**Institution:** Fraunhofer Institute for Production Systems and Design Technology (IPK), TU Berlin

**Duration:** 2024-2025

---

## 2. Problem Statement

Traditional robot Tool Center Point (TCP) calibration requires 40+ calibration 
poses and takes ~80 minutes to complete. This is time-consuming in production 
environments, requires significant operator expertise, and is not optimized for 
data efficiency.

No existing work systematically analyzed which calibration poses actually 
contribute to accuracy. The assumption was "more data = better calibration."

---

## 3. Methods and Tools Used

### Hardware

| Component | Detail |
|-----------|--------|
| Robot | Universal Robots UR5e collaborative arm |
| Camera | Azure Kinect RGB-D (depth + color) |
| Compute | NVIDIA Jetson Orin NX (embedded deployment) |
| Target | ArUco marker board |

### Software Stack

| Tool | Purpose |
|------|---------|
| ROS2 Humble | Sensor integration, robot control |
| PyTorch 2.0 | Deep learning framework |
| ResNet-18 | CNN architecture for pose quality prediction |
| OpenCV 4.5 | Image processing, ArUco detection |
| NumPy / SciPy | Numerical computation |
| Docker | Containerized deployment |
| Python 3.10 | Primary development language |

### Algorithms
- Kinematic calibration: Hand-eye calibration (Tsai-Lenz method)
- Optimization: Levenberg-Marquardt for pose refinement
- State estimation: RGB-D + kinematics + visual odometry fusion
- Pose selection: CNN-based quality scoring

---

## 4. System Architecture

### Hardware Setup

    Azure Kinect RGB-D Camera
             ↓ (USB 3.0)
    NVIDIA Jetson Orin NX
             ↓ (Ethernet)
         UR5e Robot Arm
             ↓
       ArUco Marker Board

### Software Pipeline

    1. RGB-D Image Acquisition (ROS2 node)
    2. ArUco Marker Detection (OpenCV)
    3. Pose Estimation (PnP algorithm)
    4. CNN Quality Scoring (PyTorch)
    5. Intelligent Pose Selection (top-5 poses)
    6. Kinematic Calibration (hand-eye solver)
    7. TCP Parameter Output

---

## 5. What I Implemented

### Core Modules

    thesis_ws/
    ├── src/
    │   ├── camera_driver/
    │   │   └── kinect_node.py
    │   ├── pose_estimation/
    │   │   ├── aruco_detector.py
    │   │   └── pose_solver.py
    │   ├── calibration/
    │   │   ├── cnn_model.py
    │   │   ├── pose_selector.py
    │   │   ├── hand_eye_calib.py
    │   │   └── optimizer.py
    │   ├── robot_control/
    │   │   └── ur5e_controller.py
    │   └── evaluation/
    │       ├── metrics.py
    │       └── visualization.py

### Key Contributions
- CNN training pipeline for pose quality prediction
- Hardware-in-the-Loop validation framework
- Real-time sensor fusion (RGB-D + kinematics + odometry)
- Automated calibration workflow with zero human intervention

---

## 6. How to Run

### Terminal 1 — Launch camera driver

    ros2 launch camera_driver kinect.launch.py

### Terminal 2 — Launch robot controller

    ros2 launch robot_control ur5e_bringup.launch.py

### Terminal 3 — Run calibration system

    ros2 launch calibration calibration_system.launch.py \
        --poses 5 \
        --model weights/resnet18_best.pth

### Evaluate results

    python3 evaluation/metrics.py \
        --data logs/calibration_results.csv \
        --ground-truth data/ground_truth.yaml

---

## 7. Results and Metrics

| Metric | Conventional (40 poses) | This Work (5 poses) | Improvement |
|--------|------------------------|---------------------|-------------|
| **Calibration Time** | 80 minutes | 10 minutes | **87.5% faster** |
| **RMS Accuracy** | 20.43 mm | 11.82 mm | **76% better** |
| **Number of Poses** | 40 | 5 | **87.5% fewer** |
| **Repeatability** | 3.2 mm | 1.8 mm | **44% more stable** |

### Key Findings
- 5 intelligently selected poses outperform 40 random poses
- Pose quality matters more than pose quantity
- CNN can predict calibration quality from RGB-D data alone
- System runs in real-time on embedded hardware (Jetson Orin NX)

---

## 8. Challenges and Solutions

**Challenge 1 — Real-time performance on Jetson**
CNN inference was 250ms — too slow for closed-loop control requiring under 100ms.
Solution: TensorRT optimized model + reduced input resolution → 45ms inference time.

**Challenge 2 — Sensor synchronization**
RGB-D camera, robot encoders, and visual odometry had different update rates.
Solution: ROS2 time-synchronized message filter with 50ms tolerance.

**Challenge 3 — Marker detection under poor lighting**
ArUco detection failed in low-light or high-glare conditions.
Solution: Adaptive histogram equalization + multi-scale detection → robustness 
improved from 78% to 96%.

**Key insight:** Pose diversity (spatial distribution) matters more than pose 
quantity. The CNN learned to penalize redundant poses and reward geometrically 
diverse ones.

---

## 9. Key Takeaway

Proving that intelligent data selection outperforms brute-force data collection 
in robotic calibration. This challenges the conventional "more data = better" 
paradigm and shows that asking the right question — which poses matter? — is 
more valuable than raw computational power.

This methodology transfers to other robotics applications requiring calibration, 
teaching-by-demonstration, or data-efficient learning.

---

## 10. Next Steps

- Test on other robot platforms (KUKA, ABB, Fanuc)
- Active learning: robot automatically selects next best pose
- Transfer learning: CNN pretrained on one robot generalizes to others
- Online recalibration: detect calibration drift and auto-correct
- Paper submitted to IEEE/RSJ IROS 2026 (under review)

---

## Resources

- [ROS2 Humble Documentation](https://docs.ros.org/en/humble/)
- [PyTorch Documentation](https://pytorch.org/docs/stable/index.html)
- [Universal Robots API](https://www.universal-robots.com/articles/ur/interface-communication/remote-control-via-tcpip/)
- [Azure Kinect SDK](https://github.com/microsoft/Azure-Kinect-Sensor-SDK)
- [OpenCV ArUco Module](https://docs.opencv.org/4.x/d5/dae/tutorial_aruco_detection.html)
- [Hand-Eye Calibration Library](https://github.com/IFL-CAMP/easy_handeye)
