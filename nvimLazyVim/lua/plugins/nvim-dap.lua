-- ~/.config/nvim/lua/plugins/dap.lua
return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        -- Configuración para el adaptador PHP
        "williamboman/mason.nvim",
        opts = function()
          local dap = require("dap")
          local mason_registry = require("mason-registry")
          local php_debug = mason_registry.get_package("php-debug-adapter")

          if not php_debug:is_installed() then
            php_debug:install()
          end

          local path = php_debug:get_install_path()
          dap.adapters.php = {
            type = "executable",
            command = "node",
            args = { path .. "/extension/out/phpDebug.js" },
          }

          dap.configurations.php = {
            {
              type = "php",
              request = "launch",
              name = "Listen for Xdebug",
              port = 9003,
              pathMappings = {
                ["/var/www/html"] = "${workspaceFolder}",
              },
            },
          }
        end,
      },

      {
        -- Plugin para depuración en Go
        "leoluz/nvim-dap-go",
        opts = {},
        ft = "go",
      },
    },
  },
}
