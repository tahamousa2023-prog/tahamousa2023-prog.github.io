---
title: "Space Rover Navigation — BEARS Team, TU Berlin"
excerpt: "ROS2 navigation stack integration for a Mars analogue rover: IMU sensor fusion, LiDAR ROI filtering, and Docker Compose deployment on NVIDIA Jetson Orin for IRC 2026."
collection: portfolio
date: 2026-05-26
---

This is my contribution to the BEARS (Berlin Engineering and Aerospace Robotics Society) rover team at TU Berlin, competing in the International Rover Challenge (IRC) 2026 in Udupi, India. I joined as navigation subsystem engineer, responsible for sensor integration and the ROS2-based navigation stack running on the rover's NVIDIA Jetson Orin.

**The context**

The IRC is a Mars analogue competition where a rover must autonomously navigate 500 metres to deliver a payload (RADO mission), collect geological samples, and manipulate instruments on a simulated instrument panel (IDMO mission). The navigation stack needs to work reliably on uneven terrain, without GPS, using only on-board perception. Getting sensor fusion right is what separates a rover that completes the mission from one that drifts off course.

**The stack**

The rover runs ROS2 Humble on a Jetson Orin, with every component deployed as a Docker Compose service: ZED 2i camera (`app_zed2i`), Ouster LiDAR (`app_lidar_ouster_ros`), IMU (`app_microstrain`), and RTABmap SLAM with Nav2 for autonomous navigation. All services share a host network and CycloneDDS, so topics flow transparently between containers without additional bridging.

**IMU integration — MicroStrain 3DM-CV7-AHRS**

The chosen IMU is a tactical-grade MicroStrain 3DM-CV7-AHRS: a 9-DOF sensor with an internal AHRS extended Kalman filter, publishing orientation, angular velocity, and linear acceleration at 500 Hz. Tactical-grade matters here — a cheap hobby IMU drifts visibly over the 500-metre RADO mission, while the CV7 holds heading with 0.5° accuracy in Vertical Gyro mode and full accuracy in Full Navigation mode once the magnetometer is calibrated.

Getting the driver working required resolving six undocumented configuration conflicts specific to the AHRS variant (which lacks GPS and PPS support present in higher-tier models). The key parameters were `pps_source: 0`, `filter_declination_source: 1` (manual, with Berlin's 0.23 rad declination), and `tf_mode: 0`. Once resolved, the driver published at 500.03 Hz with a timing standard deviation of 0.00022 seconds — essentially perfect.

I packaged this as `app_microstrain`, a Docker Compose service following the team's existing pattern: a `Dockerfile` that installs the driver via apt, a `postcreatecommand.sh` that builds the workspace on container start, and a launch file that brings up the driver node and a static transform publisher for `chassis_link → imu_link`. The merge request was reviewed and merged by the navigation lead with the comment "good work, looks good."

To verify the sensor in real time, I wrote a Python live visualiser that reads the ROS2 logger's CSV output and renders a 3D rotating box tracking the sensor's actual orientation alongside live plots for all nine sensor axes. This made it possible to physically move the sensor and immediately confirm the quaternion was correctly tracking motion before deploying to the rover.

**LiDAR ROI — removing the robotic arm**

The Ouster LiDAR has a 360° field of view and is mounted on top of the rover. The rover's robotic arm — used in the IDMO instrument manipulation task — is mounted at the rear and extends upward into the scan volume. Without filtering, RTABmap and Nav2 treat the arm as a permanent obstacle, corrupting the costmap and preventing navigation.

Two hardware-level filters in the Ouster driver's `driver_params.yaml` solved this cleanly. A minimum range of 1.5 metres removes the rover body itself, which is within 1–1.5 metres of the sensor in all directions. An azimuth window from 220° to 140° (measuring the sector to exclude rather than include) removes the rear 80° sector where the arm sits. Both parameters are applied at the driver level before any data reaches ROS2, so downstream nodes see a clean pointcloud from the start. The fix was verified in Foxglove Studio by comparing the `nearir_image` strip before and after — the arm disappears as a bright column in the 2D unwrapped scan.

**What this connects to**

The core challenge in mobile robot navigation is reliable state estimation under uncertainty. IMU sensor fusion, LiDAR filtering, and the EKF that fuses them into a single odometry estimate are the same problems that appear in warehouse AMRs, autonomous vehicles, and planetary rovers. The specific configuration — ROS2, Docker, Jetson, CycloneDDS — is also what you find in industrial robotics deployments. Competition robotics provides a forcing function that lab work does not: the hardware has to work, outdoors, on a deadline, in conditions you did not test for.

**Stack**

ROS2 Humble · Docker Compose · NVIDIA Jetson Orin · MicroStrain 3DM-CV7-AHRS · Ouster LiDAR · ZED 2i · RTABmap · Nav2 · CycloneDDS · Foxglove Studio · GitLab CI · Python · C++
