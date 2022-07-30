require('gitsigns').setup {
  signs = {
    add = {
      hl = 'GitSignsAdd',
      linehl = 'GitSignsAddLn',
      numhl = 'GitSignsAddNr',
      text = '+',
    },
    change = {
      hl = 'GitSignsChange',
      linehl = 'GitSignsChangeLn',
      numhl = 'GitSignsChangeNr',
      text = '~',
    },
    delete = {
      hl = 'GitSignsDelete',
      linehl = 'GitSignsDeleteLn',
      numhl = 'GitSignsDeleteNr',
      text = '-',
    },
    topdelete = {
      hl = 'GitSignsDelete',
      text = '‾',
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    changedelete = {
      hl = 'GitSignsChange',
      linehl = 'GitSignsChangeLn',
      numhl = 'GitSignsChangeNr',
      text = '_',
    },
  },
  numhl = true,
}
