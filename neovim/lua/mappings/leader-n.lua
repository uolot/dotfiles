local wk = require("which-key")

local env = { DB_LOGS = '0' }

local function neotest()
    return require("neotest")
end

local function jump_prev_failed()
    neotest().jump.prev({ status = "failed" })
end

local function jump_next_failed()
    neotest().jump.next({ status = "failed" })
end

local function run_current_file()
    return neotest().run.run(vim.fn.expand('%'))
end

local function run_all()
    return neotest().run.run({ suite = true })
end

local function show_output()
    return neotest().output.open({ enter = true })
end

local function watch_current_file()
    return neotest().watch.watch(vim.fn.expand('%'))
end

local function vitest_watch_pattern(pattern)
    ---@diagnostic disable-next-line: missing-fields
    return neotest().run.run({ vitestCommand = 'npm run test:watch -- ' .. pattern })
end

wk.add({
    mode = "n",
    { "<Leader>n",   group = "+neotest" },
    -- run tests
    { "<Leader>nt",  neotest().run.run,             desc = "Run nearest test" },
    { "<Leader>ns",  neotest().run.stop,            desc = "Stop nearest test" },
    { "<Leader>n.",  neotest().run.run_last,        desc = "Rerun last test" },
    { "<Leader>nf",  run_current_file,              desc = "Run current file" },
    { "<Leader>nT",  run_all,                       desc = "Run all test" },
    -- attach
    { "<Leader>na",  neotest().run.attach,          desc = "Attach to nearest test" },
    -- watch
    { "<Leader>nww", neotest().watch.watch,         desc = "Start watch mode" },
    { "<Leader>nws", neotest().watch.stop,          desc = "Stop watch mode" },
    { "<Leader>nwf", watch_current_file,            desc = "Start watching current file" },
    { "<Leader>nwt", neotest().watch.toggle,        desc = "Toggle watching position" },
    -- output and summary
    { "<Leader>no",  show_output,                   desc = "Show output" },
    { "<Leader>nP",  neotest().output_panel.toggle, desc = "Toggle output panel" },
    { "<Leader>nL",  neotest().output_panel.clear,  desc = "Clear output panel" },
    { "<Leader>nS",  neotest().summary.toggle,      desc = "Toggle summary" },
    -- jumps
    { "[T",          jump_prev_failed,              desc = "Jump to previous failed test" },
    { "]T",          jump_next_failed,              desc = "Jump to next failed test" },
})

-- add new command :VitestPattern that takes a pattern as an argument and runs the vitest watch command with that pattern
vim.api.nvim_create_user_command("VitestPattern", function(opts)
    local pattern = opts.args
    if pattern == "" then
        print("No pattern provided")
        return
    end
    vitest_watch_pattern(pattern)
end, { nargs = 1, desc = "Run vitest watch with a specific pattern" })
