local vault = vim.fn.expand("~") .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"

return {
    cmd = {
        "ObsidianOpen",
        "ObsidianNew",
        "ObsidianQuickSwitch",
        "ObsidianFollowLink",
        "ObsidianBacklinks",
        "ObsidianToday",
        "ObsidianYesterday",
        "ObsidianTemplate",
        "ObsidianSearch",
        "ObsidianLink",
        "ObsidianLinkNew",
    },
    -- event = {
    --     "BufReadPre " .. vault .. "/**.md",
    --     "BufReadFile " .. vault .. "/**.md",
    -- },
    -- https://github.com/epwalsh/obsidian.nvim#configuration-options
    opts = {
        dir = vault,
        mappings = {},
        disable_frontmatter = true,
    }
}
