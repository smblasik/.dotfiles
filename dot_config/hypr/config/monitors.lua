-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = "MONITOR1",
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })

hl.monitor({
    output    = MONITOR1,
    mode      = "preferred",
    position  = "0x0",
    scale     = "1.5",
})

hl.monitor({
    output    = MONITOR2,
    mode      = "preferred",
    position  = "1280x0",
    scale     = "1",
})

hl.bind("switch:on:Lid Switch", function()
    hl.monitor({ output = MONITOR1, disabled = true })
    hl.timer(function()
        for _, m in ipairs(hl.get_monitors()) do
            if m.name == MONITOR2 then
                m:set_workspace{ workspace = 1 }
            end
        end
    end, { timeout = 400, type = "oneshot" })
end, { locked = true })

hl.bind("switch:off:Lid Switch", function()
    hl.monitor({ output = MONITOR1, mode = "preferred", position = "0x0", scale = "1.5", disabled = false })
end, { locked = true })
