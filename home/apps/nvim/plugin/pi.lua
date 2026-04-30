require("pi").setup({
  provider = "openrouter",
  model = "openrouter/free",
  max_context_lines = 300,
  max_context_bytes = 24000,
  selection_context_lines = 40,
  log_path = "/tmp/pi-nvim.log",
  skills = true,
  extensions = true,
  tools = true,
})
