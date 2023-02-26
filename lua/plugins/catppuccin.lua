require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    nvimtree = false,
  },
})

vim.cmd("colorscheme catppuccin")

local function remove_italic(hl)
  vim.api.nvim_set_hl(0, hl, vim.tbl_extend("force", vim.api.nvim_get_hl_by_name(hl, {}), { italic = false }))
end

for _, hl in pairs({
  "@conditional",
  "@namespace",
  "@parameter",
  "@tag.attribute",
  "@tag.attribute.tsx",
  "@text.emphasis",
}) do
  remove_italic(hl)
end
