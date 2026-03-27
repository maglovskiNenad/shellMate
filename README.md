# shallMate

**shallMate** is a lightweight Bash-based assistant for Linux system administrators, designed to simplify common daily tasks through a modular structure and a simple dialog-driven interface.

The project is focused on making routine administration easier, faster, and more accessible by combining Bash scripting with Zenity-based graphical dialogs.

## Features

- System information overview
- Disk and mount inspection
- User management helpers
- Service status and control
- Simple logging support
- Modular project structure for easier expansion

## Project Goal

The goal of **shallMate** is to provide a practical administration helper for Linux environments without requiring a heavy framework or a complex setup.

It is intended as:

- a learning project for Bash and Linux administration
- a modular sysadmin helper
- a foundation for future expansion into a larger administration toolkit

## Project Structure

```text
shallMate/
├── lib/
│   ├── ui.sh           # Functions for Zenity dialogs and user interaction
│   └── checks.sh       # Validation, dependency checks, sudo/pre-check logic
│
├── modules/
│   ├── system.sh       # System information and service-related actions
│   ├── users.sh        # User and group management
│   └── disk.sh         # Disk usage, block devices, mount-related actions
│
├── logs/
│   └── shallmate.log   # Application log file
│
├── install.sh          # Setup script for preparing shallMate for first use
├── LICENSE
├── README.md
└── shallMate.sh        # Main entry point, GUI flow, and module routing