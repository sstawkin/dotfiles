-- Essentials 
require("config.lazy")
require("clipboard") -- the only way i found (that is working) to copy into system clipboard

-- Options (custom settings)
vim.opt.colorcolumn = "80"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.autoindent = true
vim.opt.backspace = {'indent', 'eol', 'start'}
vim.opt.fillchars = {eob = " "}

-- adding unnamedplus to clipboard list not working for some reason
vim.cmd [[
  augroup clip
    autocmd!
    autocmd TextYankPost * :lua require("clipboard").handle_yank_post()
  augroup end
]]

-- Themes
require("tokyonight").setup{}
require("gruvbox").setup{}
vim.cmd("colorscheme gruvbox") -- selected theme

-- Web devicons
require'nvim-web-devicons'.setup {
 -- your personal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- set the light or dark variant manually, instead of relying on `background`
 -- (default to nil)
 variant = "light|dark";
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
 -- same as `override` but specifically for operating system
 -- takes effect when `strict` is true
 override_by_operating_system = {
  ["apple"] = {
    icon = "",
    color = "#A2AAAD",
    cterm_color = "248",
    name = "Apple",
  },
 };
}

-- Tree Sitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  highlight = {
    enable = true,
    disable = { "c", "rust" },
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
}

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- LSP config
require'lspconfig'.clangd.setup{}
-- Use a loop to conveniently call 'setup' on multiple servers and 
-- map buffer local keybindings when the language server attaches
local servers = {'clangd'}
for _, lsp in pairs(servers) do
	require('lspconfig')[lsp].setup {
		on_attach = on_attach,
		flags = {
			-- This will be the default in neovim 0.7+
			debounce_text_changes = 150,
		}
	}
end
-- shortcuts
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts)
vim.keymap.set('n', '<leader>lD', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<leader>lS', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<leader>lic', vim.lsp.buf.incoming_calls, opts)
vim.keymap.set('n', '<leader>loc', vim.lsp.buf.outgoing_calls, opts)
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts)

-- Colorizer
require'colorizer'.setup()

-- Nvim Tree
require('nvim-tree').setup()
vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<CR>', {
	noremap = true
})

-- Lualine
require('lualine_config')
