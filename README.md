# LuaSnip-LaTeX-Snippets

A set of preconfigured snippets for markdown for the snippet engine [LuaSnip](https://github.com/L3MON4D3/LuaSnip).


## Idea
This is a fork of evesdroppers [luasnip-latex-snippets](https://github.com/evesdropper/luasnip-latex-snippets.nvim).


## Installation

Use the package manager of your choice, or don't.

**Lazy.nvim**
```lua
{
    "LukasKorotaj/luasnip-markdown-snippets.nvim",
},
```

**Packer.nvim**
```lua
use {
    "LukasKorotaj/luasnip-markdown-snippets.nvim",
},
```

## Snippets
See [snippets.md](./snippets.md) for the time being.

## Development Plans

The snippets arent integrated into markdown perfectly so I will fix them as I write math in markdown.

## Acknowledgements (from evesdropper)
Some similar snippet resources:
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets/)
- [LuaSnip-snippets.nvim](https://github.com/molleweide/LuaSnip-snippets.nvim)
- [luasnip-latex-snippets.nvim](https://github.com/iurimateus/luasnip-latex-snippets.nvim) (Same repo name, different author/snippets)
- [Gilles Castel's LaTeX Snippets](https://github.com/gillescastel/latex-snippets)

Additionally, I would like to thank Max Mehta for bringing up the idea of creating this plugin and the creator of LuaSnip, [L3MON4D3](https://github.com/L3MON4D3), for helping me debug some of the early stages of the plugin. There are also functions scattered throughout the code which are not made by me, so I've posted acknowledgements for those in the comments of the code.
