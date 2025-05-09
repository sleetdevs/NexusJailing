
local config = require("config.config")

RegisterNetEvent('nexusjail:submitJail', function(targetId, time, reason)
    local staff = source

    if not IsPlayerAceAllowed(staff, "NexusJailing.Staff") then
        TriggerClientEvent('ox_lib:notify', staff, {
            title = 'No Permission',
            description = 'You do not have access to this command.',
            type = 'error'
        })
        return
    end

    if not targetId or not time or not reason then
        TriggerClientEvent('ox_lib:notify', staff, {
            title = 'Error',
            description = 'Missing arguments.',
            type = 'error'
        })
        return
    end

    TriggerClientEvent("nexusjail:jail", targetId, time, reason)

    sendToDiscord("Jail Log", ("**%s** staff jailed **%s** for **%s** seconds\nReason: %s"):format(
        GetPlayerName(staff), GetPlayerName(targetId), time, reason
    ))

    TriggerClientEvent('ox_lib:notify', staff, {
        title = 'Success',
        description = 'Player has been staff jailed.',
        type = 'success'
    })
end)

RegisterCommand("unjail", function(src, args)
    local staff = src
    if not IsPlayerAceAllowed(staff, "NexusJailing.Staff") then
        TriggerClientEvent('ox_lib:notify', staff, {
            title = 'No Permission',
            description = 'You do not have permission to unjail.',
            type = 'error'
        })
        return
    end

    local targetId = tonumber(args[1])
    if not targetId then
        TriggerClientEvent('ox_lib:notify', staff, {
            title = 'Error',
            description = 'Usage: /unjail [player ID]',
            type = 'error'
        })
        return
    end

    TriggerClientEvent("nexusjail:unjail", targetId)
    sendToDiscord("Unjail Log", ("**%s** unjailed **%s**"):format(GetPlayerName(staff), GetPlayerName(targetId)))

    TriggerClientEvent('ox_lib:notify', staff, {
        title = 'Success',
        description = 'Player has been unjailed.',
        type = 'success'
    })
end)

function sendToDiscord(title, msg)
    local webhookURL = config.webhookURL  -- Use webhook URL from config.lua
    PerformHttpRequest(webhookURL, function() end, "POST", json.encode({
        username = "NexusJailing",
        embeds = {{
            title = title,
            description = msg,
            color = 16711680,  -- Red color for errors
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),  -- Timestamp
        }}
    }), { ["Content-Type"] = "application/json" })
end
