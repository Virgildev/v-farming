local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    for _, fruit in ipairs(Config.FarmingLocations) do
        for _, target in ipairs(fruit.targets) do
            exports['qb-target']:AddBoxZone(fruit.label, target.coords, target.radius, target.radius, {
                name = fruit.label,
                heading = 0,
                debugPoly = false,
                minZ = target.coords.z - 1.0,
                maxZ = target.coords.z + 1.0,
            }, {
                options = {
                    {
                        type = "client",
                        event = "farming:harvest",
                        icon = "fas fa-hand",
                        label = "Pick " .. fruit.item,
                        location = target,
                        fruit = fruit,
                    },
                },
                distance = 2.0
            })

            local blip = AddBlipForCoord(target.coords.x, target.coords.y, target.coords.z)
            SetBlipSprite(blip, fruit.blipSprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, fruit.blipScale)
            SetBlipColour(blip, fruit.blipColor)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(fruit.label)
            EndTextCommandSetBlipName(blip)

        end
    end
end)

Citizen.CreateThread(function()
    if SellerBlip then
        RemoveBlip(SellerBlip)
    end

    SellerBlip = AddBlipForCoord(Config.SellerBlip.coords.x, Config.SellerBlip.coords.y, Config.SellerBlip.coords.z)
    SetBlipSprite(SellerBlip, Config.SellerBlip.blipSprite)
    SetBlipDisplay(SellerBlip, 4)
    SetBlipScale(SellerBlip, Config.SellerBlip.blipScale)
    SetBlipColour(SellerBlip, Config.SellerBlip.blipColor)
    SetBlipAsShortRange(SellerBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.SellerBlip.label)
    EndTextCommandSetBlipName(SellerBlip)
end)

RegisterNetEvent('farming:harvest')
AddEventHandler('farming:harvest', function(data)
    local target = data.location
    local fruit = data.fruit.item
    local location = nil

    for _, farmLocation in ipairs(Config.FarmingLocations) do
        if farmLocation.item == fruit then
            location = farmLocation
            break
        end
    end

    local animDict = location.targets[1].animDict 
    local animName = location.targets[1].anim

    for _, target in ipairs(location.targets) do
        if target.coords == target.coords then
            animDict = target.animDict
            animName = target.anim
            break
        end
    end

    if Config.Progress == 'qb' then
        QBCore.Functions.Progressbar('fruit_picking', 'Picking ' .. fruit, Config.PickingProgress, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = animDict,
            anim = animName,
            flags = 1,
        }, {}, {},
        function()
            TriggerServerEvent('farming:giveItem', fruit, target.amount)
        end)
    else    
        if lib.progressBar({
            duration = Config.PickingProgress,
            label = 'Picking',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true,
                sprint = true,
            },
            anim = {
                dict = animDict,
                clip = animName
            },
        }) then TriggerServerEvent('farming:giveItem', fruit, target.amount) end
    end
end)

Citizen.CreateThread(function()
    local pedModel = GetHashKey(Config.PedModel)
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(500)
    end

    local ped = CreatePed(4, pedModel, Config.Location.coords.x, Config.Location.coords.y, Config.Location.coords.z, Config.Location.heading, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetModelAsNoLongerNeeded(pedModel)

    exports['qb-target']:AddBoxZone('fruit_sell_ped', Config.Location.coords, 2.0, 2.0, {
        name = 'fruit_sell_ped',
        heading = Config.Location.heading,
        debugPoly = false,
        minZ = 33.0768,
        maxZ = 35.0768
    }, {
        options = {
            {
                type = "client",
                event = "farming:openFruitMenu",
                icon = "fas fa-shopping-basket",
                label = "Sell Fruits"
            },
        },
        distance = 2.0
    })
end)

RegisterNetEvent('farming:openFruitMenu')
AddEventHandler('farming:openFruitMenu', function()
    local fruits = {}
    
    if Config.Menu == 'ox' then
    for fruit, info in pairs(Config.Items) do
        local menuItem = {
            title = info.label,
            description = 'Sell some ' .. info.label .. "'s",
            icon = 'fas fa-hand',
            onSelect = function()
                TriggerEvent('farming:selectFruit', { fruit = fruit })
            end
        }
        table.insert(fruits, menuItem)
    end

    lib.registerContext({
        id = 'farming_fruit_menu_ox',
        title = 'Fruit Salesman',
        options = fruits
    })

    lib.showContext('farming_fruit_menu_ox')

    elseif Config.Menu == 'qb' then
        for fruit, info in pairs(Config.Items) do
            table.insert(fruits, {
                header = info.label,
                txt = 'Sell some ' .. info.label .. "'s",
                icon = 'fas fa-hand',
                params = {
                    event = 'farming:selectFruit',
                    args = {
                        fruit = fruit
                    }
                }
            })
        end
        exports['qb-menu']:openMenu(fruits)
    end
end)

RegisterNetEvent('farming:selectFruit')
AddEventHandler('farming:selectFruit', function(data)
    local fruit = data.fruit

    local dialog
    if Config.Menu == 'qb' then
        dialog = exports['qb-input']:ShowInput({
            header = "Sell " .. Config.Items[fruit].label,
            submitText = "Sell",
            inputs = {
                {
                    text = "Amount to sell",
                    name = "amount",
                    type = "number",
                    isRequired = true,
                }
            },
        })
    elseif Config.Menu == 'ox' then
        dialog = lib.inputDialog("Sell " .. Config.Items[fruit].label, {
            {
                type = "number",
                label = "Amount to sell",
                default = "1", 
            }
        }, { allowCancel = true })
    end

    if dialog then
        local amount
    
        if Config.Menu == 'qb' then
            amount = tonumber(dialog.amount)
        elseif Config.Menu == 'ox' then
            amount = tonumber(dialog[1])
        end

        if amount and amount >= 1 then
            if Config.Menu == 'qb' then
                QBCore.Functions.Progressbar('Selling', 'Selling ' .. fruit, Config.SellProgress, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.SellingAnimDict,
                    anim = Config.SellingAnimName,
                    flags = 1,
                }, {}, {},
                function()
                    TriggerServerEvent('farming:sellFruit', fruit, amount)
                end)
            elseif Config.Menu == 'ox' then
                lib.progressBar({
                    duration = Config.SellProgress,
                    label = 'Selling ' .. fruit,
                    canCancel = false,
                    disable = {
                        car = true,
                        move = true,
                        combat = true,
                        sprint = true,
                    },
                    anim = {
                        dict = Config.SellingAnimDict,
                        clip = Config.SellingAnimName
                    },
                })
                TriggerServerEvent('farming:sellFruit', fruit, amount)
            end
        else
            if Config.Notify == 'qb' then
                QBCore.Functions.Notify('Invalid amount. Please enter a valid number greater than or equal to 1', 'error')
            elseif Config.Notify == 'ox' then
                lib.notify({
                    title = 'Invalid Amount',
                    description = 'Please enter a valid number greater than or equal to 1',
                    type = 'error'
                })
            end
        end
    else
        if Config.Notify == 'qb' then
            QBCore.Functions.Notify('Sale canceled. Please enter a valid amount to sell', 'error')
        elseif Config.Notify == 'ox' then
            lib.notify({
                title = 'Sale canceled',
                description = 'Please enter a valid amount to sell',
                type = 'error'
            })
        end
    end
end)