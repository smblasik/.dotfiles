-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

local function lid_closed()
    for _, path in ipairs({ "/proc/acpi/button/lid/LID0/state", "/proc/acpi/button/lid/LID/state" }) do
        local f = io.open(path, "r")
        if f then
            local state = f:read("*l")
            f:close()
            if state and state:match("closed") then
                return true
            end
        end
    end
    return false
end

hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("noctalia")
    hl.exec_cmd("xhost +SI:localuser:root")
    if lid_closed() then
        hl.monitor({ output = MONITOR1, disabled = true })
        hl.timer(function()
            for _, m in ipairs(hl.get_monitors()) do
                if m.name == MONITOR2 then
                    m:set_workspace{ workspace = 1 }
                end
            end
        end, { timeout = 400, type = "oneshot" })
    end
end)
