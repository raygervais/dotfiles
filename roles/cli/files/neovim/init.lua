use("onsails/lspkind-nvim")local indent = 4

-- Neovim Config
vim.opt.guicursor = ''
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.tabstop = indent
vim.opt.softtabstop = indent
vim.opt.shiftwidth = indent
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME')..'/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.cmdheight = 1

vim.opt.updatetime = 50
vim.opt.shortmess:append('c')
vim.opt.colorcolumn = '120'

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
	youtube = "[Suck it YT]",
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `vsnip` user.
			-- vim.fn["vsnip#anonymous"](args.body)

			-- For `luasnip` user.
			require("luasnip").lsp_expand(args.body)

			-- For `ultisnips` user.
			-- vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
	}),

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if entry.source.name == "cmp_tabnine" then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. " " .. menu
				end
				vim_item.kind = ""
			end
			vim_item.menu = menu
			return vim_item
		end,
	},

	sources = {
		-- tabnine completion? yayaya

		{ name = "cmp_tabnine" },

		{ name = "nvim_lsp" },

		-- For vsnip user.
		-- { name = 'vsnip' },

		-- For luasnip user.
		{ name = "luasnip" },

		-- For ultisnips user.
		-- { name = 'ultisnips' },

		{ name = "buffer" },

		{ name = "youtube" },
	},
})

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
})

-- Lsp
local function config(_config)
	return vim.tbl_deep_extend("force", {
	capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			nnoremap("<leader>gd", function() vim.lsp.buf.definition() end)
			--nnoremap("K", function() vim.lsp.buf.hover() end)
			--nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
			--nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
			--nnoremap("[d", function() vim.diagnostic.goto_next() end)
			--nnoremap("]d", function() vim.diagnostic.goto_prev() end)
			nnoremap("<leader>ca", function() vim.lsp.buf.code_action() end)
			nnoremap("<leader>cr", function() vim.lsp.buf.references() end)
			inoremap("<leader>h", function() vim.lsp.buf.signature_help() end)
		end,
	}, _config or {})
end

require("lspconfig").gopls.setup(config({
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			staticcheck = true,
		},
	},
}))

-- who even uses this?
require("lspconfig").rust_analyzer.setup(config({
	cmd = { "rustup", "run", "nightly", "rust-analyzer" },
}))

-- Treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = "all",
    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

vim.g.mapleader = ' '

-- Keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--- Telescope

---- Find Files
map('n', '<leader>ff', ':Telescope find_files<cr>')
---- Grep String
map('n', '<leader>fg', ':Telescope grep_string<cr>')
---- Buffers
map('n', '<leader>fb', ':Telescope buffers<cr>')



-- Packer
return require('packer').startup(function()
    use('wbthomason/packer.nvim')

    -- Lsp
    use('neovim/nvim-lspconfig')
    use("onsails/lspkind-nvim")

    -- Telescope
    use('nvim-lua/plenary.nvim')
    use('nvim-lua/popup.nvim')
    use('nvim-telescope/telescope.nvim')
    use('nvim-treesitter/nvim-treesitter', {
        run = ':TSUpdate'
    })

    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use("tzachar/cmp-tabnine", { run = "./install.sh" })

end)
