#!/bin/bash
# ============================================================
# Taha Mohammed — Website Upgrade Script
# Run from inside: tahamousa2023-prog.github.io/
# ============================================================

echo "Starting website upgrade..."

# ── 1. DELETE EMPTY PLACEHOLDER POSTS ──────────────────────
echo "Removing placeholder posts..."
rm -f _posts/2012-08-14-blog-post-1.md
rm -f _posts/2013-08-14-blog-post-2.md
rm -f _posts/2014-08-14-blog-post-3.md
rm -f _posts/2015-08-14-blog-post-4.md
rm -f _posts/2199-01-01-future-post.md
rm -f _posts/2026-02-20-trajectory-planning.md

# ── 2. DELETE EMPTY PLACEHOLDER PORTFOLIO/TALKS/TEACHING ───
echo "Removing placeholder portfolio and talks..."
rm -f _portfolio/portfolio-1.md
rm -f _portfolio/portfolio-2.html
rm -f _talks/2012-03-01-talk-1.md
rm -f _talks/2013-03-01-tutorial-1.md
rm -f _talks/2014-02-01-talk-2.md
rm -f _talks/2014-03-01-talk-3.md
rm -f _teaching/2014-spring-teaching-1.md
rm -f _teaching/2015-spring-teaching-2.md
rm -f _publications/2009-10-01-paper-title-number-1.md
rm -f _publications/2010-10-01-paper-title-number-2.md
rm -f _publications/2015-10-01-paper-title-number-3.md

# ── 3. UPDATE NAVIGATION ───────────────────────────────────
echo "Updating navigation..."
cat > _data/navigation.yml << 'EOF'
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
EOF

# ── 4. UPDATE ABOUT PAGE ───────────────────────────────────
echo "Updating About page..."
cat > _pages/about.md << 'EOF'
---
permalink: /
title: "About Me"
author_profile: true
redirect_from:
  - /about/
  - /about.html
---

I am a **Mechatronics Engineer and MSc Computational Engineering Science
candidate at TU Berlin** — bridging 7+ years of industrial engineering
with applied research in intelligent robotic systems.

My work sits at the intersection of **3D perception, robot learning,
and real-world deployment** — building systems that transfer from
simulation to physical environments.

Currently completing my Master's thesis at **Fraunhofer IPK Berlin**,
where I developed a vision-based TCP calibration system for collaborative
robots using deep learning — achieving **87.5% reduction in calibration
time** and **76% improvement in accuracy** over conventional methods.

Simultaneously contributing to the **Path Matters** research project
at TU Berlin: an RL-driven pipeline that teaches a UR5e robot to
autonomously discover optimal camera trajectories for 3D reconstruction
using Isaac Sim, VGGT, BUFFER-X, and PPO — with alignment quality
metrics feeding directly into the reward function.

Before academia, I spent **4.5 years at Siemens AG** as part of the
Europeans@Siemens programme — working across PLC programming, machine
vision, robotics, and industrial control systems including a 4800MW
power plant DCS. This industrial foundation is what makes my research
practically grounded.

I am actively seeking a **funded PhD or Industrial Doctorate** in
robotic perception, learning-based control, or sim-to-real transfer.

---

## Education

**MSc Computational Engineering Science** — TU Berlin *(2023 – present)*
Berlin, Germany

Specialisations: Computer Science and Mathematics · Simulation and
Optimisation · Measurement, Control and Regulation

Relevant courses: Applied Deep Learning in Engineering · Applied Machine
Learning in Engineering · Motion Planning · Mobile Working Robot ·
Künstliche Intelligenz: Grundlagen und Anwendungen · Data Science and AI ·
Software Engineering eingebetteter Systeme · Introduction to Data Analytics

**Master Thesis:** Development and evaluation of a vision-based system
for integrating and calibrating a surface processing tool into the
system environment of a cobot — *Fraunhofer IPK Berlin, 2024–2025*

---

**BSc Mechatronics Engineering** — Assiut University *(2011–2016)*
Graduated **4th in class** · Specialisation: Robotics, Measurement
and Control Engineering

Thesis: *Autonomous Navigation for Flying Robots*

---

## Experience

**Master's Thesis Researcher — Fraunhofer IPK** *(Apr 2025 – Jan 2026)*
Vision-based TCP calibration using CNN (ResNet-18, PyTorch) and deep
learning. Sensor fusion: RGB-D data, robot kinematics and visual odometry
with ROS2. Key result: intelligent data selection achieves **87.5% faster**
calibration and **76% higher accuracy** than conventional methods.
Hardware-in-the-Loop validation and real-time deployment on embedded hardware.

**Mechatronic Systems Developer — TU Berlin** *(Jan 2025 – Dec 2025)*
AI-based image recognition and motor control for pesticide-free agriculture.
Real-time deployment on NVIDIA Jetson Orin NX, Orin Nano and Xavier NX
using CUDA, C++ and Python. Autonomous system simulation with ROS2 and Gazebo.

**Mechatronics Engineer — Siemens AG** *(Aug 2019 – Feb 2023)*
Europeans@Siemens Programme. PLC programming, machine vision, robotics,
and industrial control systems. Operated instrumentation at a 4800MW power
plant using SPPA-T3000 DCS. Final project: camera-based sorting system
integrating machine vision and a robotic arm.

**Projects Engineer — Origin Systems, Cairo** *(Mar 2018 – Jul 2019)*
Machine-vision automation in the pharmaceutical industry. Commissioned
11 track-and-trace systems. Technical support for 8 machines at MUP.

---

## Technical Skills

**Robotics and Simulation**
ROS2 · Isaac Sim · Isaac Lab · MoveIt2 · Gazebo · UR5e · NVIDIA Jetson

**AI and Deep Learning**
PyTorch · TensorFlow · ResNet · PPO · VGGT · SAM3D · Fast3R

**3D Perception**
BUFFER-X · ICP · Open3D · Point Cloud Registration · RGB-D · Sensor Fusion

**Systems and Embedded**
CUDA · C++ · Python · Docker · PLC · DCS · Hardware-in-the-Loop

**Industrial**
Machine Vision · Camera Calibration · LabVIEW · Industry 4.0

---

## Languages

Arabic (Native) · German (C1) · English (C1)

---

## Contact

📧 taha.mousa2023@gmail.com · 📍 Berlin, Germany

[LinkedIn](https://linkedin.com/in/taha-mahmoud) ·
[GitHub](https://github.com/tahamousa2023-prog) ·
[Download CV](/files/CV_Taha_Mohammed.pdf)

**Open to:** PhD positions · Industrial Doctorate · Research Engineer roles · Collaboration
EOF

# ── 5. CREATE RESEARCH INTERESTS PAGE ─────────────────────
echo "Creating Research Interests page..."
mkdir -p _pages
cat > _pages/research.md << 'EOF'
---
permalink: /research/
title: "Research Interests"
author_profile: true
---

## Research Vision

I am interested in building robotic systems that perceive, reason,
and act reliably in unstructured real-world environments — combining
classical engineering rigour with modern learning-based methods.

---

## Core Research Areas

**3D Perception and Scene Reconstruction**

How can robots build accurate 3D models of their environment from
limited observations? My current work explores multi-view reconstruction
(VGGT, Fast3R), point cloud registration (BUFFER-X, ICP), and how
reconstruction quality can drive robot behaviour. We achieved 81.7%
fitness and 2.87 cm RMSE on real industrial objects using a zero-shot
pipeline — no domain-specific retraining.

**Learning-Based Robot Control**

How can robots learn optimal policies without hand-crafted rules?
I work on PPO-based trajectory optimisation in Isaac Lab, using
alignment quality metrics as reward signals — connecting perception
directly to decision-making. The core research question: which camera
viewpoints give the best 3D reconstruction with the fewest captures?

**Sim-to-Real Transfer**

How can simulation-trained policies transfer to physical hardware?
My experience with Isaac Sim, ROS2, MoveIt2, and the UR5e gives me
a practical understanding of the sim-to-real gap in manipulation tasks.

**Data-Efficient Robot Calibration**

How can we reduce the data requirements for robot calibration without
sacrificing accuracy? My Fraunhofer thesis demonstrated that intelligent
pose selection using CNNs outperforms brute-force data collection —
5 poses beat 40 random poses, 87.5% faster, 76% more accurate.

---

## Open Research Questions I Care About

- Can reconstruction quality replace hand-crafted reward functions in RL?
- How many viewpoints does a robot actually need for reliable 3D reconstruction?
- How do we efficiently transfer Isaac Lab policies to real UR5e arms?
- Can BUFFER-X-style zero-shot registration generalise to grasping pipelines?
- What is the minimum data needed for reliable robot calibration?

---

## Current Projects

**Path Matters — TU Berlin (WiSe 25/26)**
RL-driven camera trajectory optimisation for robotic 3D reconstruction.
Isaac Sim · UR5e · ROS2 · VGGT · BUFFER-X · ICP · PPO

**Vision-Based TCP Calibration — Fraunhofer IPK (2024–2025)**
CNN-based intelligent pose selection for robot calibration.
ResNet-18 · PyTorch · ROS2 · Azure Kinect · NVIDIA Jetson Orin NX

---

## Looking For

I am actively seeking a **funded PhD position** or **Industrial Doctorate**
with a focus on one or more of the above areas — ideally in Berlin or
Germany, with strong industry connection.

If your research group works on intelligent robotic systems,
perception-action loops, or learning for manipulation:

📧 [taha.mousa2023@gmail.com](mailto:taha.mousa2023@gmail.com) ·
[LinkedIn](https://linkedin.com/in/taha-mahmoud)
EOF

# ── 6. CREATE PHD COLLABORATION PAGE ──────────────────────
echo "Creating PhD Collaboration page..."
cat > _pages/phd.md << 'EOF'
---
permalink: /phd/
title: "PhD and Collaboration"
author_profile: true
---

## Open to PhD Collaboration

I am actively seeking a **funded PhD position or Industrial Doctorate**
starting in 2026 — in Berlin, Germany, or remote with strong
industry connection.

---

## What I Bring

**Research capability**
- Working end-to-end robotics pipeline: Isaac Sim → VGGT → BUFFER-X → ICP → PPO RL
- Demonstrated research impact: 87.5% faster calibration, 76% more accurate
- Experience with full research cycle: problem definition, implementation, evaluation, documentation

**Industrial depth**
- 4.5 years Siemens AG — PLC, machine vision, robotics, power plant DCS
- 1 year Fraunhofer IPK — applied research, real hardware, real results
- Strong understanding of what works in practice vs. what works in papers

**Technical stack**
- ROS2 · Isaac Sim · Isaac Lab · PyTorch · CUDA · Open3D · BUFFER-X
- UR5e · NVIDIA Jetson · Azure Kinect · Basler Camera
- Python · C++ · Docker · Git · Linux

**Soft skills**
- C1 German and English — fully integrated in German research culture
- Cross-functional team experience (Siemens international programme)
- Strong technical writing and documentation (this website, thesis, reports)

---

## Target Research Areas

- 3D perception and reconstruction for robotics
- Reinforcement learning for robot manipulation and trajectory planning
- Sim-to-real transfer for manipulation
- Data-efficient robot learning and calibration
- Vision-language-action models for industrial systems

---

## Target Institutions

- TU Berlin (Robotics and Biology Lab, Control Systems Group, MAR)
- TU Munich (Robotics, AI, Computer Vision)
- Fraunhofer IPA / IPK Berlin
- NVIDIA Research — Isaac / Robotics team
- Bosch Research / Siemens Research
- German Aerospace Center (DLR)

---

## Timeline

Available from **February 2026** — after Master's thesis submission.

---

## Contact

If you are a professor, research group leader, or industrial R&D manager
looking for a motivated PhD candidate with real engineering depth and
genuine research curiosity:

📧 [taha.mousa2023@gmail.com](mailto:taha.mousa2023@gmail.com)
🔗 [LinkedIn](https://linkedin.com/in/taha-mahmoud)
📄 [Download CV](/files/CV_Taha_Mohammed.pdf)

I respond within 24 hours.
EOF

# ── 7. UPDATE CONFIG ───────────────────────────────────────
echo "Updating _config.yml..."
python3 - << 'PYEOF'
with open('_config.yml', 'r') as f:
    content = f.read()

# Fix language
content = content.replace('locale                   : "en-US"', 'locale                   : "en-GB"')

# Fix LinkedIn
content = content.replace('linkedin         : "taha-mohammed-berlin"', 'linkedin         : "taha-mahmoud"')
content = content.replace('linkedin         : "YOUR_LINKEDIN_HERE"', 'linkedin         : "taha-mahmoud"')

with open('_config.yml', 'w') as f:
    f.write(content)

print("_config.yml updated.")
PYEOF

# ── 8. COMMIT AND PUSH ────────────────────────────────────
echo ""
echo "All files updated. Committing and pushing..."
git add .
git commit -m "Full website upgrade: About, Research, PhD pages, navigation, cleanup"
git push

echo ""
echo "============================================"
echo "Done! Your website will update in 2-3 min."
echo "Visit: https://tahamousa2023-prog.github.io"
echo "============================================"
