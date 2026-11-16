# init_dir

Pick a directory once, and every new terminal opens there instead of in `~`.

## Install

```bash
bash init_dir/installer.sh
source ~/.bashrc   # or just open a new terminal
```

The installer copies `init_dir.sh` to `~/.bash_init_dir` and adds a line to `~/.bashrc` that loads it. Re-running it updates the copy without duplicating the `.bashrc` line.

## Commands

| Command | What it does |
|---|---|
| `siti <dir>` | Set `<dir>` as the initial directory |
| `sitc` | Set the current directory as the initial directory |
| `sith` | Set your home directory as the initial directory (the default behavior) |

```bash
cd ~/projects/my-app
sitc                  # new terminals now open in ~/projects/my-app
siti ~/Documents      # ...or pick one explicitly
```

The choice is saved in `~/.saved_init_dir`, so it persists across sessions. The directory is also exported as `$INIT_DIR`.

## How it behaves

On startup the shell jumps to the saved directory **only if it started in `~`**. If you opened the terminal somewhere on purpose (e.g. "Open Git Bash here", VS Code), that location wins.

## Uninstall

```bash
uninstall_init_dir
```

This removes the `.bashrc` lines, deletes `~/.bash_init_dir` and `~/.saved_init_dir`, and unloads the commands from the current shell.
