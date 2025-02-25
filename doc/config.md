# Customizing Snippets

## Configuration

### Basic Setup

```lua
require("luasnip-markdown-snippets").setup({
  snippets = {
    -- Add/override snippets here
  },
  priority = 1001 -- default override priority (optional)
})
```

### Key Concepts

1. **Snippet Structure**:
   - Organized by filetype (e.g., `markdown`, `tex`)
   - Uses standard LuaSnip components:
     ```lua
     local ls = require("luasnip")
     local t = ls.text_node
     local i = ls.insert_node
     local fmta = require("luasnip.extras.fmt").fmta
     ```

2. **Override Behavior**:
   - Snippets with duplicate triggers override defaults
   - Default priority: `1001` (higher than built-in snippets' 1000)

---

## Creating Custom Snippets

### 1. Overriding Existing Snippets

```lua
snippets = {
  markdown = {
    -- Override 'sr' trigger from ^2 to ^3
    ls.extend_decorator.apply(ls.snippet, { snippetType = "autosnippet" })(
      { trig = "sr", wordTrig = false },
      { t("^3") },
      { condition = require("luasnip-markdown-snippets").in_math }
    ),
  }
}
```

### 2. Creating New Snippets

```lua
local autosnippet = ls.extend_decorator.apply(ls.snippet, { snippetType = "autosnippet" })

snippets = {
  markdown = {
    -- Regular snippet
    ls.snippet(
      { trig = "vec", name = "Vector", dscr = "Vector notation" },
      fmta("\\vec{<>}<>", { i(1), i(0) })
    ),
    
    -- Autosnippet
    autosnippet(
      { trig = "iff", wordTrig = false },
      { t("\\iff") },
      { condition = require("luasnip-markdown-snippets").in_math }
    )
  }
}
```
---

## Important Notes
1. **Math Context**:
   - Use built-in conditions for math mode detection:
   ```lua
   { condition = require("luasnip-markdown-snippets").in_math }
   ```
2. **Snippet Types**:
   - Use `autosnippet` for automatically triggered snippets
   - Use regular `snippet` for manual trigger

---

## Troubleshooting
- **Snippets not overriding**:
  1. Check priority value
  2. Verify filetype matches
  3. Ensure exact trigger match

