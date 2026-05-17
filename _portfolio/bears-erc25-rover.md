---
title: "Bears ERC25 Rover — Science Payload"
excerpt: "Embedded firmware for the TU Berlin rover science subsystem: pH sensing, mass measurement, and real-time telemetry for the European Rover Challenge 2025."
collection: portfolio
date: 2026-05-01
---

TU Berlin competes in the European Rover Challenge with the Bears rover — a semi-autonomous ground vehicle designed to navigate a Mars-analog terrain, operate a robotic arm, and collect soil science data. I lead the science payload subsystem.

## What the science payload does

At each dig site, the rover needs to measure soil pH and the mass of collected samples (regolith, rock, and drill core) and stream that data to the ground station. The system runs on an Arduino Uno and sends a structured JSON line over USB serial every 500 ms.

```json
{
  "scale_regolith": 125.40,
  "scale_rock":     87.20,
  "scale_drill":    312.80,
  "ph":             6.60,
  "ph_temp":        25.0,
  "ph_voltage":     1.577,
  "status":         "OK"
}
```

## Hardware

- Arduino Uno (ATmega328P)
- DFRobot Gravity Analog pH Sensor V2
- 3x HX711 24-bit ADC with load cells

## Signal processing

Raw load cell readings are noisy due to mechanical vibration from the rover chassis. A Median Absolute Deviation (MAD) filter runs over a rolling window of 20 samples: only readings within 3x MAD of the median are averaged. This removes spike outliers without the lag a simple moving average introduces.

The pH ADC output is smoothed with an 8-sample circular moving average before conversion. pH conversion uses two-point linear calibration stored in EEPROM (pH 4.0 and pH 7.0 buffer solutions). I found and corrected a slope formula error in the original DFRobot library causing systematic offset at pH values away from neutral.

## What I built

- Full firmware rewrite: clean architecture, named constants, EEPROM safety checks
- MAD outlier filter for load cell data
- Voltage smoothing for pH ADC
- Two-point pH calibration via serial commands (ENTERPH / CALPH / EXITPH)
- Real-time Python dashboard (pyserial + matplotlib) for ground station monitoring
- Fix to DFRobot_PH library slope calculation

## Repository

[github.com/tahamousa2023-prog/bears-erc25-rover](https://github.com/tahamousa2023-prog/bears-erc25-rover)

**Stack:** C++, Arduino, PlatformIO, Python, HX711, DFRobot pH V2
