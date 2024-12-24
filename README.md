# 🎨 ColorSwitch

A challenging SpriteKit game built in Swift where players rotate a color wheel to match falling balls. Simple yet addictive gameplay designed for mobile platforms.

## 📜 Features

- **Dynamic Gameplay**: Rotate the color switch to match the ball's color
- **Scoring System**: Track high scores and recent scores
- **Animations**: Smooth scaling and transitions
- **Game Over**: Auto-saves scores with seamless menu transition
- **Menu Screen**: Game logo, high score display, and play button

## 🎮 How to Play

1. Tap to rotate the ColorSwitch
2. Match falling ball's color with current segment
3. Score points for correct matches
4. Game ends on color mismatch

## 🛠️ Technologies Used

- **Language**: Swift
- **Framework**: SpriteKit
- **Graphics**: Custom assets and animations
- **Storage**: UserDefaults for score persistence

## 🧩 Code Structure

### Core Files

1. **GameScene.swift**
   - Core gameplay logic and ball spawning
   - Physics and touch interactions
   - Score management and game-over handling

2. **MenuScene.swift**
   - Main menu UI and score display
   - Game scene navigation

3. **GameViewController.swift**
   - SpriteKit setup and configuration
   - Initial scene management

4. **settings.swift**
   - Physics categories for collisions
   - Z-position constants for layering

## 🚀 Getting Started

### Prerequisites

- Xcode 14+ recommended

### Installation

1. Clone the repository:
```bash
git clone https://github.com/anup810/ColorSwitch.git
```

2. Open in Xcode:
```bash
open ColorSwitch.xcodeproj
```

3. Build and run on simulator or device

## 📂 Project Structure

```
ColorSwitch/
├── GameScene.swift
├── MenuScene.swift
├── GameViewController.swift
├── settings.swift
├── Assets.xcassets
├── Sounds
└── Info.plist
```

## 🎨 Visual Design

- **Color Switch**: Circular switch with red, yellow, green, and blue segments
- **Balls**: Color-matching falling balls
- **Menu**: Clean interface with logo and score display

## 🏆 Score Tracking

- Stores high score and recent score via UserDefaults
- Persists across game sessions
