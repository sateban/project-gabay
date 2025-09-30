# Project GABAY (Geo-aware Assistive Blind Aid with Yaw-sensing)

Project GABAY is an IoT-based assistive technology designed for visually impaired individuals.  
It combines navigation support with real-time health and safety monitoring, providing caregivers and family members with instant alerts and live updates through a companion mobile application.

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

### 4. Manual SOS
- A physical SOS button sends an immediate alert with location to the app.  
