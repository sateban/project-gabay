# Project GABAY (Geo-aware Assistive Blind Aid)

Project GABAY is an IoT-based assistive technology designed for visually impaired individuals.  
It combines navigation support with real-time health and safety monitoring, providing caregivers and family members with instant alerts and live updates through a companion mobile application.

---

## 🛠️ Tech Stack
- **ESP32** for processing sensor data and communication  
- **Ultrasonic Sensor** for obstacle detection  
- **MPU6050** for fall detection (angle/acceleration sensing)  
- **Pulse Sensor** for heart rate monitoring  
- **GPS Module** for real-time location tracking  
- **Dart & Flutter** for the cross-platform mobile application (user and caregiver app)  

---

## ✨ Key Features

### For the User (Visually Impaired Individual)
- Bluetooth pairing with the smart cane  
- Feedback on connection status  
- Low battery notifications  
- Optional voice commands/responses  

### For the Caregiver / Family
- Live GPS location tracking  
- Heart rate monitoring  
- Fall detection alerts  
- Emergency SOS alerts with location  
- History logs: fall incidents, heart rate spikes, route logs  

---

## ⚙️ How It Works

### 1. Navigation Assistance
- Ultrasonic sensors detect obstacles.  
- Pulse sensor measures heart rate continuously.  

### 2. Fall Detection
- MPU6050 detects sudden changes in angle/acceleration.  
- Lack of motion after a detected fall triggers emergency mode.  

### 3. Health & Safety Alerts
- ESP32 monitors thresholds for heart rate or fall detection.  
- If triggered, GPS coordinates are fetched and alerts are sent via Bluetooth/Wi-Fi to the mobile app.  
