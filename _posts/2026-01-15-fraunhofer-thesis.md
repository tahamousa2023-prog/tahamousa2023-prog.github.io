
---
layout: post
title: "Vision-Based TCP Calibration for Collaborative Robots Using Deep Learning"
date: 2025-03-07
categories: [robotics, machine-learning, research]
tags: [ROS2, PyTorch, computer-vision, calibration, UR5e]
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
    --results logs/calibration_results.csv \
    --output figures/
```

---

## 7. Results and Metrics

### Quantitative Results

| Metric | Conventional (40 poses) | This Work (5 poses) | Improvement |
|--------|------------------------|---------------------|-------------|
| **Calibration Time** | 80 minutes | 10 minutes | **87.5% faster** |
| **RMS Accuracy** | 20.43 mm | 11.82 mm | **76% better** |
| **Number of Poses** | 40 | 5 | **87.5% fewer** |
| **Repeatability (σ)** | 3.2 mm | 1.8 mm | **44% more stable** |

### Key Findings
1. **5 intelligently selected poses outperform 40 random poses**
2. **Pose quality matters more than pose quantity**
3. **CNN can predict calibration quality from RGB-D data alone**
4. **System runs in real-time on embedded hardware (Jetson Orin NX)**

### Expected Grade: **1.7 - 2.0** (German grading scale, 1.0 = best)

---

## 8. Visualizations

Generated outputs (saved in `figures/`):
- **`pose_quality_heatmap.png`** - CNN quality scores for 100+ candidate poses
- **`calibration_convergence.png`** - Optimization convergence curve
- **`error_comparison.png`** - RMS error: 5 poses vs. 40 poses
- **`pose_selection_visualization.png`** - Selected vs. rejected poses in 3D space
- **`real_time_demo.mp4`** - Video of calibration system running on UR5e

---

## 9. Challenges and Solutions

### Challenge 1: Real-time Performance on Jetson
**Problem:** CNN inference was too slow (250ms) for closed-loop control (requires <100ms)  
**Solution:** 
- Switched to TensorRT optimized model
- Reduced input resolution from 1920×1080 to 640×480
- Achieved 45ms inference time

### Challenge 2: Sensor Synchronization
**Problem:** RGB-D camera, robot encoders, and visual odometry had different update rates  
**Solution:**
- Implemented time-synchronized ROS2 message filter
- Used `message_filters::TimeSynchronizer` with 50ms tolerance
- Validated timestamp alignment in Hardware-in-the-Loop tests

### Challenge 3: Marker Detection Under Poor Lighting
**Problem:** ArUco detection failed in low-light or high-glare conditions  
**Solution:**
- Added adaptive histogram equalization preprocessing
- Implemented multi-scale detection (3 resolution levels)
- Increased detection robustness from 78% to 96%

### Key Debugging Insight
**The biggest breakthrough:** Realizing that pose *diversity* (spatial distribution) matters more than pose *quantity*. The CNN learned to penalize redundant poses and reward geometrically diverse ones.

---

## 10. Key Takeaway

**Most important contribution:**  
Proving that intelligent data selection outperforms brute-force data collection in robotic calibration. This challenges the conventional "more data = better" paradigm and shows that asking the right question ("which poses matter?") is more valuable than computational power.

**Broader impact:**  
This methodology transfers to other robotics applications requiring calibration, teaching-by-demonstration, or data-efficient learning.

---

## 11. Next Steps

### Immediate Improvements
- [ ] Test on other robot platforms (KUKA, ABB, Fanuc)
- [ ] Extend to multi-robot calibration scenarios
- [ ] Deploy in industrial production line (real-world validation)

### Research Directions
- [ ] Active learning: robot automatically selects next best pose
- [ ] Transfer learning: CNN pretrained on one robot generalizes to others
- [ ] Online recalibration: detect calibration drift and auto-correct

### Publication
- Paper submitted to **IEEE/RSJ IROS 2026** (under review)
- Open-sourcing code after publication acceptance

---

## 12. References and Links

### Academic Papers
1. Tsai, R. Y., & Lenz, R. K. (1989). "A new technique for fully autonomous and efficient 3D robotics hand/eye calibration." *IEEE Transactions on Robotics and Automation*
2. He, K., et al. (2016). "Deep Residual Learning for Image Recognition." *CVPR*
3. Levenberg-Marquardt algorithm: Marquardt, D. W. (1963). *SIAM Journal*

### Software Documentation
- [ROS 2 Humble](https://docs.ros.org/en/humble/)
- [PyTorch Documentation](https://pytorch.org/docs/stable/index.html)
- [Universal Robots API](https://www.universal-robots.com/articles/ur/interface-communication/remote-control-via-tcpip/)
- [Azure Kinect SDK](https://github.com/microsoft/Azure-Kinect-Sensor-SDK)

### GitHub Repositories
- [OpenCV ArUco Module](https://docs.opencv.org/4.x/d5/dae/tutorial_aruco_detection.html)
- [Hand-Eye Calibration Library](https://github.com/IFL-CAMP/easy_handeye)

### Related Work
- PathMaters Project (Fraunhofer IPK) - 3D reconstruction using Isaac Sim
- Bachelor Thesis: "Autonomous Navigation for Flying Robots" - UAV flight controller

---

## Contact

**Taha Mohammed**  
M.Sc. Computational Engineering Science, TU Berlin  
📧 taha.mousa2023@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/taha-mahmoud)  
💻 [GitHub](https://github.com/tahamousa2023-prog)

---

*Last updated: March 7, 2026*
