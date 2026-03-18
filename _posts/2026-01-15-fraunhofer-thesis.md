---
layout: post
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

# Vision-Based TCP Calibration for Collaborative Robots Using Deep Learning

**Institution:** Fraunhofer Institute for Production Systems and Design Technology (IPK), TU Berlin  
**Duration:** 2024-2025  
**Grade:** 1.7-2.0 (expected)

---

## 1. Project Overview

**One-sentence summary:** An intelligent vision-based calibration system that reduces industrial robot TCP calibration time by 87.5% while improving accuracy by 76% through deep learning-driven pose selection.

---

## 2. Problem Statement

**The Challenge:**  
Traditional robot Tool Center Point (TCP) calibration requires 40+ calibration poses and takes ~80 minutes to complete. This is:
- Time-consuming in production environments
- Requires significant operator expertise
- Computationally expensive
- Not optimized for data efficiency

**What was missing:**  
No existing work systematically analyzed *which* calibration poses actually contribute to accuracy. The assumption was "more data = better calibration."

---

## 3. Methods and Tools Used

### Hardware
- **Robot:** Universal Robots UR5e collaborative robot arm
- **Camera:** Azure Kinect RGB-D camera (depth + color)
- **Compute:** NVIDIA Jetson Orin NX (embedded deployment)
- **Calibration target:** ArUco marker board

### Software Stack
- **ROS 2** (Humble) - sensor integration, robot control
- **PyTorch 2.0** - deep learning framework
- **ResNet-18** - CNN architecture for pose quality prediction
- **OpenCV 4.5** - image processing, ArUco detection
- **NumPy / SciPy** - numerical computation
- **Docker** - containerized deployment
- **Python 3.10** - primary development language

### Algorithms
- **Kinematic calibration:** Hand-eye calibration (Tsai-Lenz method)
- **Optimization:** Levenberg-Marquardt for pose refinement
- **State estimation:** RGB-D + kinematics + visual odometry fusion
- **Pose selection:** CNN-based quality scoring

---

## 4. System Architecture

### Hardware Setup
```
Azure Kinect RGB-D Camera
         ↓ (USB 3.0)
NVIDIA Jetson Orin NX
         ↓ (Ethernet)
    UR5e Robot Arm
         ↓
   ArUco Marker Board
```

### Software Pipeline
```
1. RGB-D Image Acquisition (ROS 2 node)
2. ArUco Marker Detection (OpenCV)
3. Pose Estimation (PnP algorithm)
4. CNN Quality Scoring (PyTorch)
5. Intelligent Pose Selection (top-5 poses)
6. Kinematic Calibration (hand-eye solver)
7. TCP Parameter Output
```

### ROS 2 Architecture
- **`camera_driver`** - Azure Kinect interface
- **`pose_estimator`** - ArUco detection + PnP
- **`calibration_node`** - CNN inference + optimization
- **`robot_controller`** - UR5e motion control

---

## 5. What I Implemented

### Core Modules (Python)
```
thesis_ws/
├── src/
│   ├── camera_driver/
│   │   └── kinect_node.py          # Azure Kinect ROS2 driver
│   ├── pose_estimation/
│   │   ├── aruco_detector.py       # Marker detection
│   │   └── pose_solver.py          # PnP pose estimation
│   ├── calibration/
│   │   ├── cnn_model.py            # ResNet-18 implementation
│   │   ├── pose_selector.py        # Intelligent pose selection
│   │   ├── hand_eye_calib.py       # Tsai-Lenz calibration
│   │   └── optimizer.py            # Levenberg-Marquardt
│   ├── robot_control/
│   │   └── ur5e_controller.py      # Robot motion planning
│   └── evaluation/
│       ├── metrics.py              # RMS error, repeatability
│       └── visualization.py        # Result plotting
├── config/
│   ├── camera_params.yaml
│   ├── robot_params.yaml
│   └── cnn_config.yaml
└── launch/
    └── calibration_system.launch.py
```

### Key Contributions
- **CNN training pipeline** for pose quality prediction
- **Hardware-in-the-Loop validation** framework
- **Real-time sensor fusion** (RGB-D + kinematics + odometry)
- **Automated calibration workflow** (zero human intervention)

---

## 6. How to Run It

### Installation
```bash
# Clone repository
git clone https://github.com/your-username/tcp-calibration.git
cd tcp-calibration

# Install dependencies
pip install -r requirements.txt

# Build ROS2 workspace
cd thesis_ws
colcon build --symlink-install
source install/setup.bash
```

### Run Calibration
```bash
# Terminal 1: Launch camera driver
ros2 launch camera_driver kinect.launch.py

# Terminal 2: Launch robot controller
ros2 launch robot_control ur5e_bringup.launch.py

# Terminal 3: Run calibration system
ros2 launch calibration calibration_system.launch.py \
    --poses 5 \
    --model weights/resnet18_best.pth
```

### Evaluate Results
```bash
# Run evaluation metrics
python3 evaluation/metrics.py \
    --data logs/calibration_results.csv \
    --ground-truth data/ground_truth.yaml

# Generate plots
python3 evaluation/visualization.py \
    --results logs/calibration_results.
