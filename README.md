# tmux-window-manager

Inspired by the original project: [santoshxshrestha/tmux-session-manager](https://github.com/santoshxshrestha/tmux-session-manager)

A fuzzy terminal popup to manage tmux windows using `fzf`.
![tmux windows manager popup](./assets/window-manager.png)

![tmux window creator popup](./assets/window-creator.png) (Not implemented yet)

Just a simple and fast window manager for tmux — available as a plugin or standalone. It opens a popup using `fzf` where you can:

- View all windows (or excluding your current one)
- Switch to it or kill it with a keybind
- Create new-window and switch to the newly create window

---

## Requirements

- `tmux` 3.2 or higher (for `display-popup`)
- [`fzf`](https://github.com/junegunn/fzf)
- Common UNIX tools (`awk`, `bash`)

---

## Installation

### Via TPM (Tmux Plugin Manager)

1. Add plugin to your `~/.tmux.conf`:

```bash
set -g @plugin 'riodelphino/tmux-window-manager'
```

2. Press `prefix` + `I` to install

### Manual Installation

1. Clone the repository:

```bash
git clone https://github.com/riodelphino/tmux-window-manager ~/.tmux/plugins/tmux-window-manager
```

2. Add to your `~/.tmux.conf`:

```bash
run-shell ~/.tmux/plugins/tmux-window-manager/tmux-window-manager.tmux
```

3. Reload tmux config:

```bash
tmux source-file ~/.tmux.conf
```

## Usage

### Default Key Binding

- **Press `prefix` + `w`** to open the window manager

### Custom Key Binding

Add to your `~/.tmux.conf` to change the default key:

```bash
set -g @window_manager_key 'W'  # Use 'W' instead of 'w'
```

### Include current window

To include current window to the list:

```bash
set -g @window_manager_include_current 1  # 0:Exclude(Default) / 1:Include
```

### Controls

Once opened:

- **Type to search** - Fuzzy find windows by name
- **Enter** - Switch to selected window
- **Ctrl-R** - Refresh the window list
- **Ctrl-D** - Delete the selected window
- **Ctrl-A** - Create new-window and switch-client to newly created window
- **Esc** - Close without switching window

## Customization

### Available Options

```bash
# Key binding (default: 'w')
set -g @window_manager_key 'w'
```

### Manual Customization (Standalone)

Want to change the keybinding? Replace `w` with your preferred key:

```bash
bind W display-popup -E -w 80% -h 60% -T 'tmux-window-manager' '
```

Want a different popup size? Adjust the `-w` and `-h` values:

```bash
bind w display-popup -E -w <width> -h <height> -T 'tmux-window-manager' '
```

## Troubleshooting

**Popup doesn't appear?**

- Make sure you have tmux 3.2+: `tmux -V`
- Check if `display-popup` is available: `tmux list-commands | grep popup`

**fzf not found?**

- Install fzf: `brew install fzf` or `apt install fzf`
- Or follow the [official fzf installation guide](https://github.com/junegunn/fzf#installation)

**No windows to switch to?**

- As default, The manager only shows _other_ windows (not your current one)
- Create more windows: `tmux new-window`

**Key binding conflicts?**

If `prefix + w` conflicts with existing bindings, change it:

```bash
set -g @window_manager_key 'your-preferred-key'
```

## 🤝 Contributing

Found a bug or have a feature idea? Feel free to open an issue or submit a PR!

## TODO

- Replace the images to tmux-window-manager's ones.
- Add options for keybindings in fzf


## License

MIT License - [LICENSE](LICENSE) feel free to use this however you want!

This project is based on:
[santoshxshrestha/tmux-session-manager](https://github.com/santoshxshrestha/tmux-session-manager)

---

**⭐ Star this repo if it made your tmux workflow better!**
