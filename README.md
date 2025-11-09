## Additional Plugins for C#/.NET Development

This fork extends the default [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with the following plugins to enhance **C#/.NET development**:

---

### **Debugging**
- **[nvim-dap](https://github.com/mfussenegger/nvim-dap)**
  Debugging support for .NET applications. Configure breakpoints, step through code, and inspect variables directly in Neovim.

---

### **Testing**
- **[neotest](https://github.com/nvim-neotest/neotest)**
  A framework for running tests in Neovim.
  - **[neotest-dotnet](https://github.com/Issafalcon/neotest-dotnet)**
    Adapter for running .NET tests (xUnit, NUnit, MSTest).

---

### **C# Language Server**
- **[roslyn.nvim](https://github.com/seblyng/roslyn.nvim)**
  Official Roslyn-based language server for C#. Provides IntelliSense, code navigation, and refactoring.
  - **Configuration**: Customize via the `opts` table in `init.lua`.
  - **Mason Registry**: Uses a custom registry (`Crashdummyy/mason-registry`) for Roslyn installation.

---

### **File Explorer**
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)**
  Modern, fast file explorer with git integration and a clean UI.
  - **Note**: Loads immediately (`lazy = false`).

---

### **Setup Notes**
- Ensure **.NET SDK** and **Roslyn** are installed.
- Use `:Mason` to install the Roslyn LSP and other tools.

---

## 💻 GUI & Terminal — installation and padding tips

If you don't like the black/empty bars and rendering you get when launching Neovim from a terminal on Windows, using a GUI frontend or adjusting your terminal padding will help.

- Use a GUI frontend (recommended) or tune your terminal's padding.

  - GUI frontends (examples): Neovide, Goneovim, Nvui, and others — they provide GPU rendering, better font handling and usually expose options for padding and transparency. Check the GUI's docs for installation and GUI-specific options.

  - In your `init.lua` set a GUI font that GUI frontends will typically honor. Example (adjust to a patched Nerd Font you have installed):

```lua
-- GUI preferences (generic)
vim.o.guifont = "FiraCode Nerd Font Mono:h14" -- choose a patched Nerd Font you have
-- Note: Some GUI frontends expose additional options (padding/transparency).
-- Check the documentation for the GUI you install (e.g. neovide, goneovim) for their specific variables.
```

- If you prefer staying inside Windows Terminal or another terminal emulator, set the profile's padding to 0 to remove the black bars around Neovim. In Windows Terminal settings (open Settings → Profiles → [your profile] → Appearance) set "Padding" to `0, 0, 0, 0` (top,right,bottom,left) or the equivalent UI fields.

If you prefer staying inside Windows Terminal or another terminal emulator, here are explicit steps you can follow to make Neovim look clean and remove the "black bars" around the editor.

### Terminal configuration (Windows Terminal)

1. Open Windows Terminal → Settings (or press Ctrl+,).
2. Select the profile you use (e.g. "Windows PowerShell", "Command Prompt", or your custom profile). If you want the same settings for all profiles, use the global Defaults.
3. Appearance tab:
   - Padding: set to `0, 0, 0, 0` (Top, Right, Bottom, Left) to remove the inner margins that create the black bars.
   - Show scrollbar: toggle **off** to hide the scrollbar for a cleaner editor area.
   - Font face: pick a patched Nerd Font (for icon support) — e.g. "FiraCode Nerd Font", "JetBrainsMono Nerd Font", etc.
   - Use acrylic / Transparency: toggle and adjust the opacity slider if you want a translucent background.
4. Startup tab (optional): set Launch mode to "Maximized" if you prefer the terminal to open maximized.

After saving, restart the terminal and open Neovim to verify the changes.

### Advanced: edit settings.json (if you prefer the JSON)
From the Settings UI you can open the JSON file. Below is a simple example showing the keys you may change (your schema or key names may vary between Terminal versions; open the JSON through the UI to confirm):

```json
// example snippet inside the profile object
{
  "padding": "0, 0, 0, 0",
  "showScrollbar": false,
  "fontFace": "FiraCode Nerd Font",
  "useAcrylic": true,
  "acrylicOpacity": 0.85
}
```

Notes:
- Setting padding to zero removes the inner visible margins; you may keep a small value if you prefer minimal breathing room.
- Hiding the scrollbar prevents the vertical bar on the right from visually breaking the editor area.
- Use a patched Nerd Font to ensure icons from plugins like `neo-tree` and `lualine` render correctly.
- If you want a frameless or titlebar-less window, that's a GUI feature — Terminal emulators generally keep the native titlebar; consider a GUI frontend (Neovide/Goneovim/Nvui) for frameless windows.

These terminal changes will make UI elements (file explorer, statusline, floating windows) look much cleaner when using Neovim.

---

# 🧠 Neovim Keybinding Cheat Sheet

A compact reference for common Neovim modes, navigation, editing, indentation, visual mode operations, and useful miscellaneous commands. Use this as a quick lookup while working in this configuration.

## 🏁 Modes
| Mode | Enter | Exit |
|------|--------|------|
| **Normal** | `<Esc>` or `Ctrl+[` | — |
| **Insert** | `i` / `I` / `a` / `A` / `o` / `O` | `<Esc>` |
| **Visual** | `v` (character), `V` (line), `Ctrl+v` (block) | `<Esc>` |
| **Command-line** | `:` | `<Esc>` |
| **Replace** | `R` | `<Esc>` |

---

## 🧭 Navigation
| Action | Keybinding |
|--------|-------------|
| Move left / down / up / right | `h`, `j`, `k`, `l` |
| Start / End of line | `0`, `$` |
| Start / End of file | `gg`, `G` |
| Next / Previous word | `w`, `b` |
| Half-page up / down | `Ctrl+u`, `Ctrl+d` |
| Search | `/pattern`, `?pattern` |
| Next / Prev match | `n`, `N` |

---

## ✍️ Editing
| Action | Keybinding |
|--------|-------------|
| Insert before / after cursor | `i`, `a` |
| Open new line below / above | `o`, `O` |
| Delete character | `x` |
| Delete word / line | `dw`, `dd` |
| Change word / line | `cw`, `cc` |
| Yank (copy) word / line | `yw`, `yy` |
| Paste after / before | `p`, `P` |
| Undo / Redo | `u`, `Ctrl+r` |
| Replace single char | `r<char>` |

---

## 📄 Indentation
| Action | Keybinding |
|--------|-------------|
| **Indent line right** | `>>` |
| **Indent line left** | `<<` |
| **Indent multiple lines** | `>` or `<` in **Visual mode** |
| **Auto-indent** | `=` in **Visual mode** or `==` for current line |
| **Indent with specific width** | `:set shiftwidth=4` |
| **Convert tabs/spaces** | `:retab` |

---

## 📑 Visual Mode
| Action | Keybinding |
|--------|-------------| 
| Select text | `v` / `V` / `Ctrl+v` |
| Indent selection right | `>` |
| Indent selection left | `<` |
| Copy / Cut / Paste | `y`, `d`, `p` |

---

## ⚙️ Misc
| Action | Keybinding |
|--------|-------------|
| Save file | `:w` |
| Quit | `:q` |
| Save and quit | `:wq` or `ZZ` |
| Quit without saving | `:q!` |
| Open new split | `:split` or `:vsplit` |
| Navigate splits | `Ctrl+w h/j/k/l` |
| Toggle line numbers | `:set nu!` |

---

## 🔧 Quick plugin keybindings (suggested)
Common mappings you may want to add to your config for C#/.NET workflow:
- Debug (nvim-dap): `<F5>` start/continue, `<F9>` toggle breakpoint, `<F10>` step over, `<F11>` step into
- Tests (neotest): `<leader>t` run nearest test, `<leader>T` run all tests
- Explorer (neo-tree): `<leader>e` toggle file explorer

Add or adapt mappings in your Neovim init or plugin setup to match your preferences.
