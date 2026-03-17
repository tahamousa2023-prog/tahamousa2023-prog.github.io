---
title: "UR5e Multi-View Trajectory Planning for 3D Reconstruction in Isaac Sim"
date: 2026-03-16
permalink: /posts/2026/03/trajectory-planning/
tags:
  - Isaac Sim
  - UR5e
  - ROS2
  - MoveIt2
  - Trajectory Planning
  - 3D Reconstruction
  - TU Berlin
  - Path Matters
  - Python
---

As part of the **Path Matters** project at TU Berlin, this post documents 
the first complete pipeline run: a UR5e robot arm executes a planned 
multi-view camera trajectory in Isaac Sim, captures images from 7 
viewpoints, and saves them for 3D reconstruction. The system runs 
entirely in simulation using ROS2, MoveIt2 and Isaac Sim.

![Trajectory Demo]({{ "/images/trajectory_demo.gif" | relative_url }})

<iframe width="560" height="315" 
src="https://www.youtube.com/embed/vGlQuBhjrPI" 
frameborder="0" allowfullscreen></iframe>

---

## Overview

The core question of our **Path Matters** project is:

> *How do different viewpoint sequences and trajectory strategies 
> affect 3D reconstruction quality, completeness and efficiency?*

This post documents the **first building block** — getting the UR5e 
to autonomously move to planned viewpoints and capture images. 
Everything runs in simulation before transferring to the real robot.

---

## System Architecture

Three components run simultaneously, each in its own terminal:
```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Isaac Sim     │────▶│  ROS2 + MoveIt2 │────▶│ Python Script   │
│  (simulation)   │     │  (motion plan)  │     │ (trajectory)    │
│  Terminal 1     │     │  Terminal 2     │     │  Terminal 3     │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

| Component | Tool | Purpose |
|-----------|------|---------|
| Simulation | NVIDIA Isaac Sim | Physics + robot + camera |
| Motion Planning | ROS2 Humble + MoveIt2 | IK solving + collision checking |
| Trajectory Control | Python (ROS2 node) | Waypoints + image capture |
| Robot | UR5e collaborative arm | 6-DOF manipulation |
| Camera | Simulated Basler RGB-D | Image acquisition |
| Scene | `17_12_robot_plane_graph.usd` | Environment + object |

---

## How to Run — Step by Step

### Terminal 1 — Launch Isaac Sim
```bash
conda deactivate
cd isaacsim/_build/linux-x86_64/release
./isaac-sim.sh
```
→ Open scene: `17_12_robot_plane_graph.usd`  
→ Wait for full load before proceeding

### Terminal 2 — Launch ROS2 + MoveIt2
```bash
conda deactivate
ros2 launch ur_moveit_config ur_moveit.launch.py ur_type:=ur5e
```
→ Wait until you see `MoveIt! running` in the output

### Terminal 3 — Run Trajectory Script
```bash
conda deactivate
python3 /home/AP_PathMatters/path_matters/trajectory/scripts/26_01_ur_move.py
```
→ Robot begins moving through all 7 viewpoints automatically

---

## The Trajectory Script — How It Works

The script is a ROS2 node (`URPhotoCapture`) that:

**1. Connects to MoveIt2 IK service**
```python
self.ik = self.create_client(GetPositionIK, '/compute_ik')
```
Uses MoveIt2's inverse kinematics to convert Cartesian (x,y,z) 
positions into joint angles for the UR5e.

**2. Subscribes to camera topic**
```python
self.camera_sub = self.create_subscription(
    Image, '/camera/image_raw', self.image_callback, 10
)
```
Receives live images from the simulated Basler camera in Isaac Sim.

**3. Uses smooth interpolation between waypoints**
```python
def interpolate_joints(self, start_joints, end_joints, steps=20):
    t = i / steps
    smooth_t = 3*t**2 - 2*t**3  # cubic ease in-out
```
Cubic easing prevents jerky motion — important for 
blur-free image capture.

**4. Captures and saves images at each position**
```python
filename = f"{timestamp}_{safe_name}.ppm"
```
Images saved as `.ppm` files with timestamp and position name.

---

## Viewpoint Design

The 7 viewpoints are arranged around the target object 
located at approximately (0.3, 0.0, 0.2) in the world frame:

| # | Name | X | Y | Z | Purpose |
|---|------|---|---|---|---------|
| 1 | Top View | 0.30 | 0.00 | 0.60 | Top-down coverage |
| 2 | Front | 0.15 | 0.00 | 0.30 | Front face |
| 3 | Right | 0.30 | 0.20 | 0.30 | Right side |
| 4 | Back | 0.50 | 0.00 | 0.30 | Back face |
| 5 | Left | 0.30 | -0.20 | 0.30 | Left side |
| 6 | Front-Angled | 0.20 | 0.00 | 0.45 | 45° front angle |
| 7 | Right-Angled | 0.30 | 0.15 | 0.45 | 45° right angle |

All positions use `rx=π, ry=0, rz=0` — camera pointing downward 
toward the object.

![Viewpoint positions diagram]({{ "/images/viewpoints_diagram.png" | relative_url }})

---

## Inverse Kinematics — Key Design Decision

A critical insight from debugging: the IK solver requires 
the **`"world"` frame**, not `"base_link"` or other frames.
```python
pose.header.frame_id = "world"  # confirmed working via diagnostic
```

This was discovered through systematic diagnostic testing — using 
any other frame caused IK failures across all positions.

**IK parameters:**
```python
req.ik_request.group_name    = "ur_manipulator"
req.ik_request.ik_link_name  = "tool0"
req.ik_request.timeout.sec   = 5
req.ik_request.avoid_collisions = False  # disabled for testing
```

---

## Image Capture Pipeline
```
Camera topic: /camera/image_raw
      ↓
ROS2 Image message (rgb8 or bgr8 encoding)
      ↓
Convert to numpy array
      ↓
Save as .ppm file with timestamp
      ↓
/path_matters/trajectory/captures/captured_photos_TIMESTAMP/
```

**Output files example:**
```
20260316_141523_Top_View.ppm
20260316_141534_Front.ppm
20260316_141545_Right.ppm
20260316_141556_Back.ppm
20260316_141607_Left.ppm
20260316_141618_Front-Angled.ppm
20260316_141629_Right-Angled.ppm
```

---

## Results

### Captured Images — 4 Viewpoints

![Top View]({{ "/images/frame_1_top_view.png" | relative_url }})
*Top View — camera looking down at object*

![Front]({{ "/images/frame_2_front.png" | relative_url }})
*Front View — camera facing object directly*

![Right]({{ "/images/frame_3_right.png" | relative_url }})
*Right Side — camera at 90° angle*

![Back]({{ "/images/frame_4_back.png" | relative_url }})
*Back View — camera from behind object*

| Metric | Value |
|--------|-------|
| **Viewpoints planned** | 7 |
| **Images captured** | [ fill in after run ] |
| **Image resolution** | [ fill in ] |
| **Image format** | .ppm (RGB8) |
| **Save location** | `/path_matters/trajectory/captures/` |

---

## Challenges & Solutions

**Challenge 1 — IK frame mismatch**  
Initial attempts used `base_link` frame → all IK calls failed.  
→ **Solution:** systematic diagnostic confirmed `world` frame is correct.

**Challenge 2 — Jerky robot motion**  
Direct joint jumps caused unrealistic motion and camera blur.  
→ **Solution:** cubic ease in-out interpolation over 30-40 steps.

**Challenge 3 — Camera timing**  
Moving too fast meant camera image hadn't updated before capture.  
→ **Solution:** `time.sleep(0.8)` after reaching each position before capture.

**Challenge 4 — Shared PC resources**  
VGGT Gradio demo running in background consumed 5GB+ GPU memory.  
→ **Solution:** coordinate with teammates to free GPU before Isaac Sim runs.

---

## Full Pipeline — What Comes Next
```
✅ Step 1: Trajectory + Image Capture   ← THIS POST
🔄 Step 2: 2D→3D Reconstruction (VGGT / Fast3R)
🔄 Step 3: Preprocessing (remove background)
🔄 Step 4: BUFFER-X Initial Alignment
🔄 Step 5: ICP Refinement
🔄 Step 6: Fitness/RMSE → RL Reward Signal
🔄 Step 7: PPO Training to optimize trajectory
```

---

## Full Script
```python
#!/usr/bin/env python3
"""
UR5e Photo Capture
Path Matters Project — TU Berlin
Uses 'world' frame for IK (confirmed via diagnostic)
"""

import rclpy
from rclpy.node import Node
import time, math
import numpy as np
from moveit_msgs.srv import GetPositionIK
from geometry_msgs.msg import PoseStamped
from sensor_msgs.msg import JointState, Image
import os
from datetime import datetime


class URPhotoCapture(Node):
    def __init__(self, save_dir="captured_images"):
        super().__init__('ur_photo_capture')
        
        self.latest_image = None
        self.save_dir = save_dir
        os.makedirs(self.save_dir, exist_ok=True)
        self.get_logger().info(
            f"✓ Images will be saved to: {os.path.abspath(self.save_dir)}"
        )
        
        # Camera subscriber
        self.camera_sub = self.create_subscription(
            Image, '/camera/image_raw', self.image_callback, 10
        )
        
        # MoveIt2 IK service
        self.ik = self.create_client(GetPositionIK, '/compute_ik')
        
        # Joint command publisher
        self.pub = self.create_publisher(JointState, '/joint_command', 10)
        
        self.current_joints = None
        self.joints = [
            'shoulder_pan_joint', 'shoulder_lift_joint', 'elbow_joint',
            'wrist_1_joint', 'wrist_2_joint', 'wrist_3_joint'
        ]
        
        self.joint_sub = self.create_subscription(
            JointState, '/joint_states', self.joint_callback, 10
        )
        
        self.get_logger().info("Waiting for MoveIt IK service...")
        if not self.ik.wait_for_service(timeout_sec=10):
            raise RuntimeError("MoveIt not started")
        self.get_logger().info("✓ MoveIt IK service ready!")
    
    def image_callback(self, msg):
        self.latest_image = msg
    
    def capture_photo(self, position_name):
        if self.latest_image is None:
            self.get_logger().warn("⚠ No camera image")
            return False
        
        msg = self.latest_image
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        safe_name = position_name.replace(' ', '_').replace('/', '-')
        filename = f"{timestamp}_{safe_name}.ppm"
        filepath = os.path.join(self.save_dir, filename)
        
        try:
            img_array = np.frombuffer(msg.data, dtype=np.uint8)
            img_array = img_array.reshape((msg.height, msg.width, 3))
            if msg.encoding == 'bgr8':
                img_array = img_array[:, :, ::-1]
            
            with open(filepath, 'wb') as f:
                f.write(f"P6\n{msg.width} {msg.height}\n255\n".encode())
                f.write(img_array.tobytes())
            
            self.get_logger().info(f"  📷 SAVED: {filename}")
            return True
        except Exception as e:
            self.get_logger().error(f"  ✗ Save failed: {e}")
            return False
    
    def joint_callback(self, msg):
        if len(msg.position) >= 6:
            self.current_joints = list(msg.position[:6])
    
    @staticmethod
    def euler_to_quat(rx, ry, rz):
        cy, sy = math.cos(rz*0.5), math.sin(rz*0.5)
        cp, sp = math.cos(ry*0.5), math.sin(ry*0.5)
        cr, sr = math.cos(rx*0.5), math.sin(rx*0.5)
        return (
            sr*cp*cy - cr*sp*sy,
            cr*sp*cy + sr*cp*sy,
            cr*cp*sy - sr*sp*cy,
            cr*cp*cy + sr*sp*sy
        )
    
    def compute_ik(self, x, y, z, rx=math.pi, ry=0.0, rz=0.0):
        pose = PoseStamped()
        pose.header.frame_id = "world"  # critical — confirmed working
        pose.header.stamp = self.get_clock().now().to_msg()
        pose.pose.position.x = float(x)
        pose.pose.position.y = float(y)
        pose.pose.position.z = float(z)
        qx, qy, qz, qw = self.euler_to_quat(rx, ry, rz)
        pose.pose.orientation.x = qx
        pose.pose.orientation.y = qy
        pose.pose.orientation.z = qz
        pose.pose.orientation.w = qw
        
        req = GetPositionIK.Request()
        req.ik_request.group_name = "ur_manipulator"
        req.ik_request.ik_link_name = "tool0"
        req.ik_request.pose_stamped = pose
        req.ik_request.timeout.sec = 5
        req.ik_request.avoid_collisions = False
        
        if self.current_joints:
            req.ik_request.robot_state.joint_state.name = self.joints
            req.ik_request.robot_state.joint_state.position = self.current_joints
        
        future = self.ik.call_async(req)
        rclpy.spin_until_future_complete(self, future, timeout_sec=6)
        
        try:
            response = future.result()
            if response.error_code.val == 1:
                return list(response.solution.joint_state.position[:6])
            return None
        except Exception as e:
            self.get_logger().error(f"IK error: {e}")
            return None
    
    def interpolate_joints(self, start_joints, end_joints, steps=20):
        trajectory = []
        for i in range(steps + 1):
            t = i / steps
            smooth_t = 3*t**2 - 2*t**3  # cubic ease in-out
            trajectory.append([
                s + smooth_t * (e - s)
                for s, e in zip(start_joints, end_joints)
            ])
        return trajectory
    
    def execute_trajectory(self, trajectory, duration_per_step=0.05):
        for joints in trajectory:
            msg = JointState()
            msg.header.stamp = self.get_clock().now().to_msg()
            msg.name = self.joints
            msg.position = joints
            self.pub.publish(msg)
            time.sleep(duration_per_step)
    
    def move_smooth(self, x, y, z, rx=math.pi, ry=0.0, rz=0.0, steps=30):
        self.get_logger().info(f"→ Moving to ({x:.3f}, {y:.3f}, {z:.3f})")
        target_joints = self.compute_ik(x, y, z, rx, ry, rz)
        if target_joints is None:
            self.get_logger().error("✗ IK failed")
            return False
        if self.current_joints is None:
            msg = JointState()
            msg.header.stamp = self.get_clock().now().to_msg()
            msg.name = self.joints
            msg.position = target_joints
            self.pub.publish(msg)
            time.sleep(2)
            self.current_joints = target_joints
        else:
            trajectory = self.interpolate_joints(
                self.current_joints, target_joints, steps
            )
            self.execute_trajectory(trajectory)
            self.current_joints = target_joints
        return True


def main():
    rclpy.init()
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    save_dir = (
        f"/home/AP_PathMatters/path_matters/trajectory/"
        f"captures/captured_photos_{timestamp}"
    )
    ur = URPhotoCapture(save_dir=save_dir)
    
    HOME = {'x': 0.3, 'y': 0.0, 'z': 0.5, 'rx': math.pi, 'ry': 0.0, 'rz': 0.0}
    
    positions = [
        {'name': 'Top_View',      'x': 0.30, 'y':  0.00, 'z': 0.60},
        {'name': 'Front',         'x': 0.15, 'y':  0.00, 'z': 0.30},
        {'name': 'Right',         'x': 0.30, 'y':  0.20, 'z': 0.30},
        {'name': 'Back',          'x': 0.50, 'y':  0.00, 'z': 0.30},
        {'name': 'Left',          'x': 0.30, 'y': -0.20, 'z': 0.30},
        {'name': 'Front_Angled',  'x': 0.20, 'y':  0.00, 'z': 0.45},
        {'name': 'Right_Angled',  'x': 0.30, 'y':  0.15, 'z': 0.45},
    ]
    
    try:
        ur.move_smooth(HOME['x'], HOME['y'], HOME['z'])
        photo_count = 0
        
        for i, pos in enumerate(positions, 1):
            print(f"\n📸 Position {i}/{len(positions)}: {pos['name']}")
            success = ur.move_smooth(pos['x'], pos['y'], pos['z'], steps=40)
            if success:
                time.sleep(0.8)
                if ur.capture_photo(pos['name']):
                    photo_count += 1
        
        ur.move_smooth(HOME['x'], HOME['y'], HOME['z'])
        print(f"\n✅ Done! {photo_count}/{len(positions)} photos saved to {save_dir}")
    
    except KeyboardInterrupt:
        print("\n⚠ Interrupted")
    finally:
        rclpy.shutdown()


if __name__ == '__main__':
    main()
```

---

## Resources

- [Path Matters Project Overview](/portfolio/path-matters/)
- [BUFFER-X Integration Post](/posts/2026/03/bufferx-registration/)
- [UR5e ROS2 Driver](https://github.com/UniversalRobots/Universal_Robots_ROS2_Driver)
- [MoveIt2 Documentation](https://moveit.picknik.ai/)
- [NVIDIA Isaac Sim](https://developer.nvidia.com/isaac-sim)
