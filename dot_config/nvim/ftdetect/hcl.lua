vim.api.nvim_clear_autocmds({
  event = { 'BufRead', 'BufNewFile' },
  pattern = '*.tf',
  group = 'filetypedetect',
})

vim.filetype.add({
  extension = {
    hcl = 'hcl',
    tf = 'terraform',
    tfvars = 'terraform',
    tfstate = 'json',
  },
  pattern = {
    ['.*%.tfstate%.backup'] = 'json',
  },
  filename = {
    ['.terraformrc'] = 'hcl',
    ['.terraform.rc'] = 'hcl',
  },
})
