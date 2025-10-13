# Lawlor's Labyrinth

A **top-down 2D maze survival game** built with **Godot Engine**, featuring randomly generated levels, a chasing enemy, and a score system that challenges players to see how long they can last.

## Overview

**Lawlor's Labyrinth** drops you into a shifting maze filled with danger. Each time you enter, a new maze awaits - but so does an enemy that will never stop hunting you.

Your goal: **Escape as many mazes as you can before getting caught.**

## Features

- **Randomly Generated Mazes**

  Endless replayability - each level is new and unpredictable.

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

1. Install dependencies:
  - [Godot Engine](https://godotengine.org/)
  - [Git](https://git-scm.com/)

2. **Clone the repository:**
   ```bash
   git clone https://github.com/gkim14/CS471_LawlorsLabyrinth.git
   ```
3. **Open Godot:**
   - Launch **Godot 4.5**.
   - Click **Import**, navigate to the cloned folder, and select `project.godot`.
   - Once imported, click **Run** to start the game.
4. **(Optional):** Modify scripts, scenes, or assets directly to extend functionality.

### Option 2: Play the Pre-Built Executables
If you just want to play the game without running it in Godot:
- Windows: [Download]()
- macOS: [Download]()
  
Note: Unzip and run the executable inside. No installation required.

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
