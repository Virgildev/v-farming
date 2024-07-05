local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('farming:giveItem')
AddEventHandler('farming:giveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, amount)
    if Config.Notify == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, 'You picked a ' .. item, 'success')
    else 
        local data = {
            title = 'You picked a ' .. item,
            type = 'success',
            duration = 9000,
            position = 'top-right'
        }
        TriggerClientEvent('ox_lib:notify', src, data)
    end
end)

RegisterServerEvent('farming:sellFruit')
AddEventHandler('farming:sellFruit', function(fruit, amount)
    print('server reached')
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(fruit)

    if item then
        if item.amount >= amount then
            local price = Config.Items[fruit].price
            local total = amount * price

            Player.Functions.RemoveItem(fruit, amount)
            Player.Functions.AddMoney('cash', total)

            local sellMsg = 'Sold ' .. amount .. ' ' .. fruit .. ' for $' .. total

            if Config.Notify == 'qb' then
                TriggerClientEvent('QBCore:Notify', src, sellMsg, 'success')
            else
                local data = {
                    title = 'Sold ' .. amount .. ' ' .. fruit,
                    description = 'for $' .. total,
                    type = 'success',
                    duration = 9000,
                    position = 'top-right'
                }
                TriggerClientEvent('ox_lib:notify', src, data)
            end
        else
            local errMsg = 'You don\'t have enough ' .. fruit .. 's'

            if Config.Notify == 'qb' then
                TriggerClientEvent('QBCore:Notify', src, errMsg, 'error')
            else
                local data = {
                    title = errMsg,
                    type = 'error',
                    duration = 3000,
                    position = 'top-right'
                }
                TriggerClientEvent('ox_lib:notify', src, data)
            end
        end
    else
        local errMsg = 'You don\'t have any ' .. fruit .. 's'

        if Config.Notify == 'qb' then
            TriggerClientEvent('QBCore:Notify', src, errMsg, 'error')
        else
            local data = {
                title = errMsg,
                type = 'error',
                duration = 3000,
                position = 'top-right'
            }
            TriggerClientEvent('ox_lib:notify', src, data)
        end
    end
end)
