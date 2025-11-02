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

### **Code Actions**
- **[nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)**
  Displays a lightbulb icon in the gutter when code actions are available, making it easier to apply quick fixes or refactors.

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
