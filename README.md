# shellMate
CLI tool for Linux system administrators to simplify daily tasks like user management, service control, and system monitoring.


        ├─ shallMate/
        │   ├─ lib/            # funkcije za zenty prozore
        │   │   ├─ui.sh          
        │   │   └─ checks.sh   # validacije + prechescks ( sudo,dependencies)
        │   ├─ modules/
        │   │   ├─ system.sh   # system info, services
        │   │   ├─ users.sh    # add /del user,gruops
        │   │   └─ disk.sh     # df,sblk,mount
        │   └─ logs/
        │       └─ shallmate.log
        ├─ LICENSE
        ├─ README.md
        └─ shallmate.sh         # glavni entrypoint (GUI + routing)
