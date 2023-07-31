local bin = string.format("%s/%s", vim.loop.cwd(), "node_modules/.bin/prettier")

return {
    formatCommand = string.format("%s --stdin-filepath ${INPUT}", vim.fn.filereadable(bin) == 0 and "prettier" or bin),
    formatStdin = true,
}
