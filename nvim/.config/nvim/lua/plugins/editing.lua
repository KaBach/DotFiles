-- Don't know what this does?!
return {
  {
		"LunarVim/bigfile.nvim",
		init = function()
			-- default config
			require("bigfile").setup({
				filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
				pattern = { "*" }, -- autocmd pattern
				features = { -- features to disable
					"indent_blankline",
					"illuminate",
					"lsp",
					"treesitter",
					"syntax",
					"matchparen",
					"vimopts",
					"filetype",
				},
			})
		end,
	},
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },
  -- commenting with e.g. `gcc` or `gcip`
  -- respects TS, so it works in quarto documents
  { 'numToStr/Comment.nvim',
    version = nil,
    branch = 'master',
    config = function()
    require('Comment').setup {}
  end
  },
  { "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true
  }
}
