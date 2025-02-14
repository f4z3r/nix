require("kulala").setup({
  curl_path = "curl",
  display_mode = "split",
  q_to_close_float = true,
  split_direction = "vertical",
  default_view = "headers_body",
  default_env = "dev",
  debug = false,
  contenttypes = {
    ["application/json"] = {
      ft = "json",
      formatter = { "jq", "." },
      pathresolver = require("kulala.parser.jsonpath").parse,
    },
    ["application/xml"] = {
      ft = "xml",
      formatter = { "xmllint", "--format", "-" },
      pathresolver = { "xmllint", "--xpath", "{{path}}", "-" },
    },
    ["text/html"] = {
      ft = "html",
      formatter = { "xmllint", "--format", "--html", "-" },
      pathresolver = {},
    },
  },

  -- can be used to show loading, done and error icons in inlay hints
  -- possible values: "on_request", "above_request", "below_request", or nil to disable
  -- If "above_request" or "below_request" is used, the icons will be shown above or below the request line
  -- Make sure to have a line above or below the request line to show the icons
  show_icons = "above_request",
  icons = {
    inlay = {
      loading = "",
      done = "",
      error = "",
    },
  },

  winbar = false,
  vscode_rest_client_environmentvars = false,
  disable_script_print_output = false,
  environment_scope = "b",
  certificates = {},
  urlencode = "always",
  show_variable_info_text = false,
})
