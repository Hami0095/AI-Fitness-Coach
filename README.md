# AI Fitness Coach

<p align="center">
  <img src="Screenshots/Screenshot 2025-07-25 at 12.36.55 PM.png" alt="Onboarding Screen" width="150"/>
  <img src="Screenshots/screenshot 2025-07-25 at 12.37.46 PM.png" alt="Home Dashboard" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.38.11 PM.png" alt="Workout Plan" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.38.28 PM.png" alt="Exercise Detail" width="150"/>
</p>

<p align="center">
  <img src="Screenshots/Screenshot 2025-07-25 at 12.38.43 PM.png" alt="Add Exercise Page" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.38.57 PM.png" alt="Coach Chat" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.39.12 PM.png" alt="Body Scan" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.39.23 PM.png" alt="Pose Detection" width="150"/>
</p>

<p align="center">
  <img src="Screenshots/Screenshot 2025-07-25 at 12.39.38 PM.png" alt="Rep Counter" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.39.56 PM.png" alt="Form Feedback" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.40.08 PM.png" alt="Analytics Overview" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.40.20 PM.png" alt="Muscle Recovery" width="150"/>
</p>

<p align="center">
  <img src="Screenshots/Screenshot 2025-07-25 at 12.40.35 PM.png" alt="Fitness Test Card" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.40.46 PM.png" alt="Subscription Payment" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.41.02 PM.png" alt="Profile Screen" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.41.18 PM.png" alt="Settings" width="150"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.41.32 PM.png" alt="Notifications" width="150"/>
</p>

---

## 📖 Project Overview

**AI Fitness Coach** is a Flutter-based, Zing App–inspired fitness companion, enhanced with cutting-edge AI and computer-vision features:

* **Real-time Pose Detection**
  Leveraging ML Kit’s MediaPipe model to track body landmarks for squats & push-ups.

* **Rep Counting & Form Feedback**
  Angle-based classification automatically identifies reps and displays form cues (“Go deeper”, “Nice push-up!”, etc.).

* **AI Workout & Nutrition Plans**
  Gemini/OpenAI integration for personalized exercise routines and diet recommendations in any language.

* **Subscription & Payments**
  Stripe-powered in-app purchases for premium content and AI-guided challenges.

* **Comprehensive Analytics**
  Body-fat %, muscle recovery, workout streaks, and progress charts stored in Firestore.

* **Coach Chatbot**
  24/7 multilingual AI assistant for tips, motivation, and Q\&A.

---
## INFRA-Structure

* **State Management:** Riverpod
* **Navigation:** GoRouter
* **Backend:**

  * Firebase Auth (Email, Google, Facebook)
  * Firestore (workouts, metrics)
  * Storage (body scan images)
  * Cloud Functions (Python CV hooks)
* **AI & CV:**

  * On-device ML Kit pose detection
  * Python FastAPI server (MediaPipe + TensorFlow Lite) for advanced analytics

---

## 🚀 Getting Started

### Prerequisites

* Flutter 3.x & Dart
* Android Studio / Xcode or a Real Device
* Firebase project credentials
* Stripe API keys
* Python 3.9+ (for optional CV server)

### Installation

1. **Clone the Repo**

   ```bash
   git clone https://github.com/YourUsername/AI-Fitness-Coach.git
   cd AI-Fitness-Coach
   ```

2. **Fetch Dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**

   * Place `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in their respective folders.
   * Enable Auth providers, Firestore, and Storage in your Firebase console.

4. **Run the App**

   ```bash
   flutter run
   ```

5. **(Optional) Start CV Server**

   ```bash
   cd cv_server
   pip install -r requirements.txt
   uvicorn app:app --reload
   ```

---

## 📂 Screenshots Gallery

All app screens captured below:

<p align="center">
  <img src="Screenshots/Screenshot 2025-07-25 at 12.36.55 PM.png" width="120"/>
  <img src="Screenshots/screenshot 2025-07-25 at 12.37.46 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.38.11 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.38.28 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.38.43 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.38.57 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.39.12 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.39.23 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.39.38 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.39.56 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.40.08 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.40.20 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.40.35 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.40.46 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.41.02 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.41.18 PM.png" width="120"/>
  <img src="Screenshots/Screenshot 2025-07-25 at 12.41.32 PM.png" width="120"/>
</p>

---

## 📜 License

MIT © \AbdurRehman
