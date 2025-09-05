return {
  {
    "LazyVim/LazyVim",
    lazy = false,
    priority = 10000,
    init = function()
      -- If the module isn't available yet, provide a stub so require() succeeds later.
      if not package.loaded["catppuccin.groups.integrations.bufferline"] then
        package.preload["catppuccin.groups.integrations.bufferline"] = function()
          return {
            get = function()
              return {}
            end,
          }
        end
      else
        -- If it is available but lacks .get, add a no-op to avoid nil errors.
        local ok, mod = pcall(require, "catppuccin.groups.integrations.bufferline")
        if ok and type(mod.get) ~= "function" then
          mod.get = function()
            return {}
          end
        end
      end
    end,
  },
}
