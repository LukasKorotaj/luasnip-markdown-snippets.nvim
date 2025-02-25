# LuaSnip-Markdown-Snippets

A set of preconfigured snippets for latex math inside of markdown for the snippet engine [LuaSnip](https://github.com/L3MON4D3/LuaSnip).


## Idea
These are snippets for Latex inside of markdown. My use case for this is math inside of Obsidian while writing in Neovim.
This is a fork of evesdroppers [luasnip-latex-snippets](https://github.com/evesdropper/luasnip-latex-snippets.nvim).


## Installation

**Lazy.nvim**
```lua
{
  "LukasKorotaj/luasnip-markdown-snippets.nvim",
  dependencies = { "L3MON4D3/LuaSnip" },
  config = true, -- or custom configuration
}
```

Add these lines to `~/.config/nvim/queries/markdown_inline/highlights.scm`:

```
;;; LaTeX-related captures
(latex_block) @latex_block
(latex_span_delimiter) @latex_delimiter
```

This is so that snippets are only active and usable inside of math blocks in markdown.

Enable autosnippets in your `init.lua` file: 
```lua
config = function()
    local luasnip = require 'luasnip'

    luasnip.setup {
	enable_autosnippets = true,
    }
end,
```
If you are using [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) don't forget to have only one `luasnip.setup`. The second one is hidden in `cmp_luasnip`.

## Full Config Example
```lua
return {
  "LukasKorotaj/luasnip-markdown-snippets.nvim",
  config = function()
    local ls = require("luasnip")
    local t = ls.text_node
    local i = ls.insert_node
    local fmta = require("luasnip.extras.fmt").fmta
    local autosnippet = ls.extend_decorator.apply(ls.snippet, { snippetType = "autosnippet" })
    local lms = require 'luasnip-markdown-snippets'


    require("luasnip-markdown-snippets").setup({
      snippets = {
        markdown = {
          -- Override existing snippet
          autosnippet(
            { trig = "cb", wordTrig = false },
            { t("^4") }, -- original was ^3
            { condition = lms.in_math }
          ),
          
          -- New test snippet
          ls.snippet(
            { trig = "test", name = "testing snippets", dscr = "Test to check if new snippets work" },
            fmta([[
		testing <>, it is <>.
            ]], { i(1), i(0) })
          )
        }
      }
    })
  end
}
```

Check [config.md](./doc/config.md) for details.
## Snippets
See [snippets.md](./doc/snippets.md). 

## Acknowledgements (from evesdropper)
Some similar snippet resources:
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets/)
- [LuaSnip-snippets.nvim](https://github.com/molleweide/LuaSnip-snippets.nvim)
- [luasnip-latex-snippets.nvim](https://github.com/iurimateus/luasnip-latex-snippets.nvim) (Same repo name, different author/snippets)
- [Gilles Castel's LaTeX Snippets](https://github.com/gillescastel/latex-snippets)

Additionally, I would like to thank Max Mehta for bringing up the idea of creating this plugin and the creator of LuaSnip, [L3MON4D3](https://github.com/L3MON4D3), for helping me debug some of the early stages of the plugin. There are also functions scattered throughout the code which are not made by me, so I've posted acknowledgements for those in the comments of the code.
