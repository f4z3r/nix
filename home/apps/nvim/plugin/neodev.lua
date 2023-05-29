require("neodev").setup({
  library = { plugins = { "neotest" }, types = true },
  override = function(root_dir, library)
    if require("neodev.util").has_file(root_dir, "/home/f4z3r/opt/system/nix") then
      library.enabled = true
      library.plugins = true
    end
  end,
})
