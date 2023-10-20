return {
  { 'quarto-dev/quarto-nvim',
    dependencies = {
      { 'hrsh7th/nvim-cmp' },
      { 'neovim/nvim-lspconfig' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'jmbuhr/otter.nvim',
        config = function()
          require 'otter'.setup {
            lsp = {
              hover = {
                border = require 'misc.style'.border
              }
            }
          }
        end,
      },
      { 'quarto-dev/quarto-vim',
        ft = 'quarto',
        dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
        -- note: needs additional vim highlighting enabled
        -- for markdown in treesitter.lua
      },
    },
    config = function()

      -- conceal can be tricky because both
      -- the treesitter highlighting and the
      -- regex vim syntax files can define conceals
      --
      -- conceallevel
      -- 0		Text is shown normally
      -- 1		Each block of concealed text is replaced with one
      -- 		character.  If the syntax item does not have a custom
      -- 		replacement character defined (see |:syn-cchar|) the
      -- 		character defined in 'listchars' is used.
      -- 		It is highlighted with the "Conceal" highlight group.
      -- 2		Concealed text is completely hidden unless it has a
      -- 		custom replacement character defined (see
      -- 		|:syn-cchar|).
      -- 3		Concealed text is completely hidden.
      vim.opt.conceallevel = 1

      -- disable conceal in markdown/quarto
      vim.g['pandoc#syntax#conceal#use'] = false

      -- embeds are already handled by treesitter injectons
      vim.g['pandoc#syntax#codeblocks#embeds#use'] = false

      vim.g['pandoc#syntax#conceal#blacklist'] = { 'codeblock_delim', 'codeblock_start' }

      -- but allow some types of conceal in math reagions:
      -- a=accents/ligatures d=delimiters m=math symbols
      -- g=Greek  s=superscripts/subscripts
      vim.g['tex_conceal'] = 'gm'

      require 'quarto'.setup {
        lspFeatures = {
          enabled = true,
          languages = { 'r', 'python', 'bash' },
          chunks = 'all', -- 'curly' or 'all'
          diagnostics = {
            enabled = true,
            triggers = { "BufWrite" }
          },
          completion = {
            enabled = true
          }
        }
      }
    end
  },
  -- send code from python/r/qmd docuemts to the terminal
  -- thanks to tmux can be used for any repl
  -- like ipython, R, bash
    {
    'jpalardy/vim-slime',
    init = function()
      vim.b['quarto_is_' .. 'python' .. '_chunk'] = false
      Quarto_is_in_python_chunk = function()
        require 'otter.tools.functions'.is_otter_language_context('python')
      end

      vim.cmd [[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
      call v:lua.Quarto_is_in_python_chunk()
      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
      return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
      else
      return a:text
      end
      endfunction
      ]]

      local function mark_terminal()
        vim.g.slime_last_channel = vim.b.terminal_job_id
        vim.print(vim.g.slime_last_channel)
      end

      local function set_terminal()
        vim.b.slime_config = { jobid = vim.g.slime_last_channel }
      end

      vim.b.slime_cell_delimiter = "# %%"

      -- slime, neovvim terminal
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1

      -- -- slime, tmux
      -- vim.g.slime_target = 'tmux'
      -- vim.g.slime_bracketed_paste = 1
      -- vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }

      local function toggle_slime_tmux_nvim()
        if vim.g.slime_target == 'tmux' then
          pcall(function()
            vim.b.slime_config = nil
            vim.g.slime_default_config = nil
          end
          )
          -- slime, neovvim terminal
          vim.g.slime_target = "neovim"
          vim.g.slime_bracketed_paste = 0
          vim.g.slime_python_ipython = 1
        elseif vim.g.slime_target == 'neovim' then
          pcall(function()
            vim.b.slime_config = nil
            vim.g.slime_default_config = nil
          end
          )
          -- -- slime, tmux
          vim.g.slime_target = 'tmux'
          vim.g.slime_bracketed_paste = 1
          vim.g.slime_default_config = { socket_name = "default", target_pane = ".2" }
        end
      end

      require 'which-key'.register({
        ['<leader>cm'] = { mark_terminal, 'mark terminal' },
        ['<leader>cs'] = { set_terminal, 'set terminal' },
        ['<leader>ct'] = { toggle_slime_tmux_nvim, 'toggle tmux/nvim terminal' },
      })
    end
  },
  -- paste an image to markdown from the clipboard
  -- :PasteImg,
  --'ekickx/clipboard-image.nvim',

  -- display images in the terminal!
--  { 'edluffy/hologram.nvim',
 --   config = function()
      -- require'hologram'.setup{
      --   auto_display = true
      -- }
  --  end
--  },
  --Added the jalvesaq packages as I prefer the keybindings here
  {
    'jalvesaq/Nvim-R'
  },
--  {
--   'jalvesaq/R-Vim-runtime'
--},
}
