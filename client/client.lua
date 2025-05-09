local config = require("config.config")
local jailed = false
local jailTime = 0
local maxDistance = 8.0

RegisterCommand("jail", function()
    local input = lib.inputDialog('Staff Jail Player', {
        {type = 'number', label = 'Player ID', required = true},
        {type = 'number', label = 'Staff Jail Time (seconds)', required = true},
        {type = 'input', label = 'Reason', required = true},
    })

    if not input then
        lib.notify({ title = 'Cancelled', description = 'Staff Jail canceled.', type = 'inform' })
        return
    end

    local id, time, reason = table.unpack(input)
    TriggerServerEvent('nexusjail:submitJail', id, time, reason)
end)

RegisterNetEvent("nexusjail:jail", function(time, reason)
    jailed = true
    jailTime = time

    SetEntityCoords(PlayerPedId(), config.jailPos.x, config.jailPos.y, config.jailPos.z)
    lib.notify({
        title = 'Jailed',
        description = ('You have been staff jailed for %s seconds.\nReason: %s'):format(time, reason),
        type = 'error'
    })

    CreateThread(function()
        while jailed and jailTime > 0 do
            Wait(1000)
            jailTime -= 1

            local ped = PlayerPedId()
            local dist = #(GetEntityCoords(ped) - config.jailPos)
            if dist > maxDistance then
                lib.notify({
                    title = 'Escape Blocked',
                    description = 'You cannot escape staff jail.',
                    type = 'error'
                })
                SetEntityCoords(ped, config.jailPos.x, config.jailPos.y, config.jailPos.z)
            end
        end

        if jailed then
            TriggerEvent("nexusjail:unjail")
        end
    end)
end)

RegisterNetEvent("nexusjail:unjail", function()
    jailed = false
    jailTime = 0
    SetEntityCoords(PlayerPedId(), config.unjailPos.x, config.unjailPos.y, config.unjailPos.z)
    lib.notify({
        title = 'Released',
        description = 'You have been released from staff jail.',
        type = 'success'
    })
end)

function ShowNotification(msg)
    lib.notify({
        title = 'Staff Jail Notification',
        description = msg,
        type = 'inform'
    })
end
