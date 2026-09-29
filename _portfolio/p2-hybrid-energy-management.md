---
title: "Hybrid Powertrain Energy Management: Cost-Function Torque Split in MATLAB/Simulink"
excerpt: "Operating strategy for a P2 parallel hybrid, decided every 10 ms: engine/e-machine torque split, gear, clutch and engine on/off. Charge-neutral fuel savings of 9.1 % (WLTC) and 7.5 % (RDE), validated on a Nordschleife lap and an unseen stress profile."
collection: portfolio
date: 2026-09-30
header:
  teaser: pea_fuel_savings.png
---

Course project "Projekt elektrifizierter Antriebsstrang" at TU Berlin (summer semester 2026), Chair of Integrated Modelling of Energy-Efficient Vehicle Powertrains, supervised by Prof. Dr.-Ing. Clemens Biet. Team of four.

The task: give a P2 parallel hybrid (combustion engine and electric machine on one shaft, separable by a clutch) its brain. Every 10 ms the strategy decides how the driver's torque request is split between engine and e-machine, which gear to use, whether the clutch is closed and whether the engine runs at all. Goals: minimum fuel and CO₂, Euro 6d-TEMP emission limits, a charge-neutral battery, and a real-time capable controller.

<div style="display:flex;flex-wrap:wrap;gap:12px;margin:1.2em 0 1.6em 0;">
  <div style="flex:1 1 150px;border:1px solid rgba(128,128,128,.35);border-radius:8px;padding:12px 14px;">
    <div style="font-size:1.9em;font-weight:700;line-height:1.1;">−9.1 %</div>
    <div style="font-size:.85em;opacity:.8;">fuel vs. engine-only, WLTC, charge-neutral</div>
  </div>
  <div style="flex:1 1 150px;border:1px solid rgba(128,128,128,.35);border-radius:8px;padding:12px 14px;">
    <div style="font-size:1.9em;font-weight:700;line-height:1.1;">−7.5 %</div>
    <div style="font-size:.85em;opacity:.8;">fuel vs. engine-only, RDE real-driving cycle</div>
  </div>
  <div style="flex:1 1 150px;border:1px solid rgba(128,128,128,.35);border-radius:8px;padding:12px 14px;">
    <div style="font-size:1.9em;font-weight:700;line-height:1.1;">150</div>
    <div style="font-size:.85em;opacity:.8;">torque-split candidates evaluated every 10 ms</div>
  </div>
  <div style="flex:1 1 150px;border:1px solid rgba(128,128,128,.35);border-radius:8px;padding:12px 14px;">
    <div style="font-size:1.9em;font-weight:700;line-height:1.1;">25×</div>
    <div style="font-size:.85em;opacity:.8;">faster than real time (full model)</div>
  </div>
</div>

**How the strategy decides**

A fixed priority chain handles the special states first: standstill and creeping, catalyst heating after a cold start, and regenerative braking. In normal driving, a cost function takes over. For each candidate engine torque it adds up the cost of the engine operating point (specific fuel consumption, fuel flow, NOx), the cost of using the battery (a state-of-charge window, catalyst temperature, speed- and acceleration-dependent terms) and a penalty for switching the engine on or off. The cheapest candidate wins. Weights were calibrated with an automated random search over more than 50 full-cycle simulations, keeping only runs that met the emission limits and the charge balance.

After the final presentation we reworked the strategy based on the supervisor's feedback: a global engine arbiter now owns the engine on/off decision and enforces minimum on and off times, a torque-rate penalty smooths the engine torque, and the fixed battery target became a usable SOC window. The plot below is one of our diagnostic views: what the cost function requested, what the arbiter allowed, and how the torque was actually split over the full WLTC.

<img src="{{ "/images/pea_strategy_wltc.png" | relative_url }}" width="100%" alt="WLTC strategy diagnostics: engine request vs. arbiter decision, battery SOC, and engine/e-machine torque split">

**Results that hold up**

Hybrid fuel savings are easy to overstate: a strategy can look efficient simply by draining the battery. We therefore compared only charge-neutral runs (battery ends where it started, within 0.1 percentage points), and we quantified how strongly consumption depends on the battery balance, about 0.22 L/100 km per percentage point of SOC, so that every result could be corrected to a fair basis. While doing this we also found that our first engine-only reference still contained hybrid functions; after fixing it, the reference became stricter and the savings more honest.

<img src="{{ "/images/pea_fuel_savings.png" | relative_url }}" width="100%" alt="Fuel consumption of the hybrid strategy vs. engine-only reference for WLTC and RDE">

**Nordschleife: my evaluation chapter**

The strategy also had to drive a full lap of the Nürburgring Nordschleife as fast as possible, starting with a full battery and never exceeding the speed profile at any point. I evaluated this profile. The final model holds the speed limit over the entire lap (worst case 0.36 km/h below the limit), and uses the battery down to the bottom of its window, cutting fuel use to 1.1 kg for the lap. The interesting engineering insight: an efficiency-tuned strategy spends the battery to replace engine power, not to add boost. For minimum lap time you need a dedicated track mode, which our performance mode demonstrated at 456 s against a theoretical optimum of 438 s.

<img src="{{ "/images/pea_nordschleife.png" | relative_url }}" width="100%" alt="Nordschleife lap: speed vs. limit over distance, battery SOC and fuel consumption over time">

**Robustness on an unseen profile**

After the model freeze we received a stress profile nobody had tuned for: creeping, a 39° downhill section, acceleration to 233 km/h, a sinusoidal speed demand on a 10° climb, and a stop on a slope, starting with a nearly empty battery. The strategy kept the battery from running flat and still saved fuel, but the test also exposed oscillations between driver controller and strategy and a roll-back on the slope. Those findings drove the arbiter and smoothing changes above, and they point to the next step: a driver controller with integral action.

**Sensitivity to vehicle mass**

Every additional 100 kg cost about 0.12 L/100 km in the WLTC, and NOx reached the Euro 6d limit at roughly 10 % above the reference mass. Mass directly eats into the efficiency margin of the powertrain strategy.

<img src="{{ "/images/pea_mass_sensitivity.png" | relative_url }}" width="100%" alt="Fuel consumption and NOx over vehicle mass with Euro 6d limit">

**Why this matters for electric vehicles**

The core problem is the same one every electrified powertrain solves in real time: split the torque request between two machines so that energy use is minimal while every constraint holds. In a dual-motor electric vehicle the choice is front versus rear motor instead of engine versus e-machine; the cost-function thinking, the battery window, regenerative braking, smooth torque transitions and a controller that runs deterministically in a fixed time step carry over directly. So does the validation mindset: standard cycles, real-driving data, a race track and an unseen stress profile, each checked against hard limits instead of a single headline number. With the e-mobility industry in Berlin-Brandenburg ramping up vehicle and battery production, I see my profile exactly at this interface: vehicle-level energy management on one side, and production automation, machine vision and robotics from my years at Siemens and Fraunhofer IPK on the other.

**My role**

Coordination and final editing of the team report, the Nordschleife evaluation, and contributions to strategy development and the diagnostic visualisation.

**Team**

Jasper Aaron Brenner, Lan Qiu, Taha Mohammed, Ziad Abouhalawa. Supervisor: Prof. Dr.-Ing. Clemens Biet, TU Berlin.

**Stack**

MATLAB · Simulink · MATLAB Function blocks · Simulink Data Inspector · cost-function optimisation · automated parameter search · WLTC / RDE drive cycles · Euro 6d-TEMP emission evaluation · LaTeX
