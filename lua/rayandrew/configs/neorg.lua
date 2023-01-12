local neorg_status, neorg = pcall(require, "neorg")

if neorg_status then
  neorg.setup({
    ["core.defaults"] = {},
    ["core.fs"] = {},
    ["core.norg.concealer"] = {},
    ["core.export.markdown"] = {},
    ["core.norg.completion"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          work = "~/Notes/work",
          home = "~/Notes/home",
        },
      },
    },
  })
end
