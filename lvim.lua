-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "codemonkey"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>Telescope grep_string<CR>", "Search In Project" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  [";"] = { ":FloatermNew --wintype=normal --height=8<CR>", "Terminal" },
  n = { ":FloatermNew node<CR>", "Node" },
  f = { ":FloatermNew python<CR>", "Python" },
  t = { ":FloatermToggle<CR>", "Toogle" },
}
lvim.builtin.which_key.mappings["T"] = {
  name = "+Telescope",
  p = { "<cmd>Telescope projects<CR>", "Projects" },
  f = { "<cmd>Telescope grep_string<CR>", "Search In Project" },
  g = { "<cmd>Telescope live_grep<CR>", "Grep" }
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.width = 55

-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "json",
  "haskell",
  "markdown",
}

lvim.builtin.treesitter.highlight.enabled = true

-- Additional Plugins
lvim.plugins = {
  { "folke/trouble.nvim",           cmd = "TroubleToggle" },
  {
    "ur4ltz/surround.nvim",
    config = function()
      require "surround".setup { mappings_style = "surround" }
    end
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  { "lunarvim/colorschemes" },
  { "bluz71/vim-moonfly-colors" },
  { "rafi/awesome-vim-colorschemes" },
  { "bignimbus/pop-punk.vim" },
  { "voldikss/vim-floaterm" },
  { "justinmk/vim-sneak" },
  { "plasticboy/vim-markdown" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  { "github/copilot.vim" }
}

vim.filetype.add({
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0 then
    return npairs.esc("<cr>")
  else
    return npairs.autopairs_cr()
  end
end

remap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', { expr = true, noremap = true })
remap('n', 'H', ':bprev<CR>', { noremap = true })
remap('n', 'L', ':bnext<CR>', { noremap = true })
remap('n', '<C-t>', ':ToggleTerm<CR>', { noremap = true })

npairs.setup {}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
