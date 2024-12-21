--ChatGPT. (2024, December 20). Fixing the "Create IsPlayerInRectangularZone and IsPlayerNearTarget methods to ensure player is within zone" error in Lua scripting for FiveM. OpenAI. https://www.openai.com/chatgpt
--It was being a bitch to me, figured I'd pull out my boy ChatGPT
local function IsPlayerInRectangularZone(playerCoords, targetCoords, size, rotation)
    rotation = rotation or 0
    local rad = math.rad(rotation)
    local halfWidth = size.x / 2
    local halfHeight = size.y / 2
    local tx = playerCoords.x - targetCoords.x
    local ty = playerCoords.y - targetCoords.y
    local rotatedX = tx * math.cos(rad) + ty * math.sin(rad)
    local rotatedY = -tx * math.sin(rad) + ty * math.cos(rad)
    local isInside = math.abs(rotatedX) <= halfWidth and math.abs(rotatedY) <= halfHeight
    
    return isInside
end

local function IsPlayerNearTarget(src, targetCoords, targetSize, targetRotation)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))

    targetRotation = targetRotation or 0
    return IsPlayerInRectangularZone(playerCoords, targetCoords, targetSize, targetRotation)
end

RegisterServerEvent('farming:giveItem')
AddEventHandler('farming:giveItem', function(item, amount, targetCoords, targetSize, targetRotation)
    local src = source

    if type(targetCoords) == 'table' and targetCoords.x and targetCoords.y and targetCoords.z then
        targetCoords = vector3(targetCoords.x, targetCoords.y, targetCoords.z)
    elseif type(targetCoords) ~= 'vector3' then
        print('Error: targetCoords is not a valid vector3. Type:', type(targetCoords), 'Value:', targetCoords)
        return
    end

    targetSize = targetSize or vec3(120.0, 120.0, 15.0)

    print('Checking if player is within target area...')
    local isNear = IsPlayerNearTarget(src, targetCoords, targetSize, targetRotation)
    print('Is Player Near Target:', isNear)

    if isNear then
        local success = exports.ox_inventory:AddItem(src, item, amount)
        
        if success then
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
        else
            print('Failed to add item to player inventory.')
        end
    else
        if Config.DropPlayerOnExploitCheck then
            DropPlayer(src, 'Sniffed that shit from miles...')
        end
    end
end)

RegisterServerEvent('farming:sellFruit')
AddEventHandler('farming:sellFruit', function(fruit, amount, targetCoords)
    local src = source
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)

    local distance = #(playerCoords - Config.Location.coords)
    if distance > 15.0 then
        local errMsg = 'You must be within 7 meters of the location to sell fruit.'
        if Config.Notify == 'qb' then
            TriggerClientEvent('QBCore:Notify', src, errMsg, 'error')
            if Config.DropPlayerOnExploitCheck then
                DropPlayer(src, 'Sniffed that shit from miles...')
            end
        else
            local data = {
                title = errMsg,
                type = 'error',
                duration = 3000,
                position = 'top-right'
            }
            TriggerClientEvent('ox_lib:notify', src, data)
            if Config.DropPlayerOnExploitCheck then
                DropPlayer(src, 'Sniffed that shit from miles...')
            end
        end
        return
    end

    local item = exports.ox_inventory:GetItem(src, fruit)

    if item and item.count >= amount then
        local price = Config.ItemsFarming[fruit].price
        local total = amount * price

        local success = exports.ox_inventory:RemoveItem(src, fruit, amount)

        if success then
            local addMoneySuccess = exports.ox_inventory:AddItem(src, 'cash', total)
            if addMoneySuccess and Config.useMyResturantWarehouseScript then
                MySQL.Async.fetchAll('SELECT * FROM warehouse_stock WHERE ingredient = @ingredient', {
                    ['@ingredient'] = fruit
                }, function(stockResults)
                    if #stockResults > 0 then
                        MySQL.Async.execute('UPDATE warehouse_stock SET quantity = quantity + @quantity WHERE ingredient = @ingredient', {
                            ['@quantity'] = amount,
                            ['@ingredient'] = fruit
                        })
                    else
                        MySQL.Async.execute('INSERT INTO warehouse_stock (ingredient, quantity) VALUES (@ingredient, @quantity)', {
                            ['@ingredient'] = fruit,
                            ['@quantity'] = amount
                        })
                    end
                end)

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
                print('Failed to add money to player.')
            end
        else
            print('Failed to remove item from player inventory.')
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
end)