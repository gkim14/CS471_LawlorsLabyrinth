# Lawlor's Labyrinth

A **top-down 2D maze survival game** built with **Godot Engine**, featuring randomly generated levels, a chasing enemy, and a score system that challenges players to see how long they can last.

## Overview

Lawlor's Labyrinth drops you into a shifting maze filled with danger. Each time you enter, a new maze awaits — but so does an enemy that will hunt you down.

Your goal: **Escape as many mazes as you can before getting caught.**

## Features

- **Randomly Generated Mazes**

  Endless replayability. Each level is new and unpredictable.

- **Player-Controlled Character**

  Smooth 2D movement with intuitive top-down controls.

- **Enemy AI**

   A single, relentless enemy that tracks and chase you throughout the maze.

- **Scoring System**

  Your score is based on the number of maze levels you successfully clear before capture.

- **UI Elements**
  - **Start Screen:** Start/quit game and see game instructions.
  - **Pause Menu:** Pause, resume, restart, and exit gameplay.
  - **Game Over Screen:** Displays your score with restart and exit options.

## Run / Build Instructions

### Option 1: Run from Godot

1. **Install dependencies:**
   - [Git](https://git-scm.com/)
   - [Godot Engine](https://godotengine.org/) (v.4.5)

3. **Clone the repository:**
   ```bash
   git clone https://github.com/gkim14/CS471_LawlorsLabyrinth.git
   ```
4. **Open Godot:**
   - Launch **Godot 4.5**.
   - Click **Import**, navigate to the cloned folder, and select `project.godot`.
   - Once imported, click **Run** to start the game.
5. **(Optional):** Modify scripts, scenes, or assets directly to extend functionality.

### Option 2: Play the Pre-Built Executables
If you just want to play the game without running it in Godot:

[**Download the Latest Release**](https://github.com/gkim14/CS471_LawlorsLabyrinth/releases/latest)

**Available Builds:**
- **Windows:** `LawlorsLabyrinth_Windows.zip` - extract and run `Lawlor's Labyrinth.exe`.
- **macOS:** `LawlorsLabyrinth_macOS.dmg` - open, drag the app into Applications, and run `Lawlor's Labyrinth.app`.
  
Note: Your computer may show a warning, preventing you from opening the game. This is caused by the unsigned property of the files.

**To fix (macOS):**
1. **Double-click** the game's `.app`.
   
   That makes macOS remember the app's name.
   
2. Open **System Settings** and go to **Privacy & Security**.
3. Scroll down to the **Security** section.
   
   You will see something like:
   
   *"Lawlor's Labyrinth.app" was blocked to protect your Mac. [Open Anyway]*
   
4. Click **"Open Anyway."**
5. When the warning appears again, choose **"Open Anyway."**

**To fix (Windows):**
1. **Double-click** the game's `.exe`.
2. When the blue **"Windows protected your PC"** window appears:
   - Click **"More info."**
   - Then click **"Run anyway."**

This ensures the game will run normally from now on for both platforms. As a safety note, remember to bypass these warnings only if you **trust the source**.

## Project Structure
```bash
📂 project-root
├── 📁 assets/      # Sprites, audio, and other media
├── 📁 scenes/      # Godot scene (.tscn) files
├── 📁 scripts/     # Game logic in GDScript
├── project.godot   # Godot project configuration
└── README.md
```

## Credits
Developed by:
- Andrew Baluyot
- Michael Baran
- Daniel Kim
- Grace Kim

Built with:
- [Godot Engine](https://godotengine.org/)
- Custom art for menus and sprites
- Custom scripts and maze generation logic
- Sound effects: [Juhani Junkala](https://opengameart.org/content/512-sound-effects-8-bit-style)
- Background music: [Juhani Junkala](https://opengameart.org/content/5-chiptunes-action)
- Start screen music: [Tsorthan Grove](https://opengameart.org/content/doubts) licensed under [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/)
