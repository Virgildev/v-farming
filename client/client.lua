local QBCore = exports['qb-core']:GetCoreObject()

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

Citizen.CreateThread(function()
    for _, farm in ipairs(Config.FarmingLocations) do
        for _, target in ipairs(farm.targets) do
            exports.ox_target:addBoxZone({
                coords = target.coords,
                size = target.size,
                rotation = target.rotation,
                debug = false,
                options = {
                    {
                        name = farm.label,
                        icon = "fas fa-hand",
                        label = "Pick " .. farm.item,
                        onSelect = function()
                            TriggerEvent("farming:harvest", { target = target, farm = farm })
                        end
                    }
                }
            })

            local blip = AddBlipForCoord(target.coords.x, target.coords.y, target.coords.z)
            SetBlipSprite(blip, farm.blipSprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, farm.blipScale)
            SetBlipColour(blip, farm.blipColor)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(farm.label)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

RegisterNetEvent('farming:harvest')
AddEventHandler('farming:harvest', function(data)
    local target = data.target
    local fruit = data.farm.item
    local location = nil

    for _, farmLocation in ipairs(Config.FarmingLocations) do
        if farmLocation.item == fruit then
            location = farmLocation
            break
        end
    end

    if not location then
        print('No location found for fruit:', fruit)
        return
    end
    
    local animDict = location.targets[1].animDict 
    local animName = location.targets[1].anim

    for _, locTarget in ipairs(location.targets) do
        if locTarget.coords.x == target.coords.x and locTarget.coords.y == target.coords.y and locTarget.coords.z == target.coords.z then
            animDict = locTarget.animDict
            animName = locTarget.anim
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
            TriggerServerEvent('farming:giveItem', fruit, target.amount, target.coords, target.size, target.rotation)
        end)
    else    
        if lib.progressCircle({
            duration = Config.PickingProgress,
            label = 'Picking',
            useWhileDead = false,
            canCancel = true,
            position = 'bottom',
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
        }) then TriggerServerEvent('farming:giveItem', fruit, target.amount, target.coords, target.size, target.rotation) end
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

    exports.ox_target:addLocalEntity(ped, {
        {
            type = "client",
            event = "farming:openFruitMenu",
            icon = "fas fa-shopping-basket",
            label = "Sell Fruits"
        }
    })
end)

RegisterNetEvent('farming:openFruitMenu')
AddEventHandler('farming:openFruitMenu', function()
    local function filterFruits(query)
        local filteredFruits = {}
        for fruit, info in pairs(Config.ItemsFarming) do
            if info.label and string.find(string.lower(info.label), string.lower(query)) then
                local menuItem = {
                    title = info.label,
                    description = 'Sell some ' .. info.label .. "'s",
                    icon = 'fas fa-hand',
                    onSelect = function()
                        TriggerEvent('farming:selectFruit', { fruit = fruit })
                    end
                }
                table.insert(filteredFruits, menuItem)
            end
        end
        return filteredFruits
    end

    local function createMenu(searchQuery)
        local options = {}

        table.insert(options, {
            title = 'Search',
            description = 'Search for a fruit',
            icon = 'fas fa-search',
            onSelect = function()
                local input = lib.inputDialog('Search Fruits', {
                    { type = 'input', label = 'Enter fruit name' }
                })

                if input and input[1] then
                    createMenu(input[1])
                end
            end
        })

        local filteredFruits = filterFruits(searchQuery or '')
        for _, menuItem in ipairs(filteredFruits) do
            table.insert(options, menuItem)
        end

        lib.registerContext({
            id = 'farming_fruit_menu_ox',
            title = 'Fruit Salesman',
            options = options
        })

        lib.showContext('farming_fruit_menu_ox')
    end

    createMenu()
end)

RegisterNetEvent('farming:selectFruit')
AddEventHandler('farming:selectFruit', function(data)
    local fruit = data.fruit

    local dialog
    if Config.Menu == 'qb' then
        dialog = exports['qb-input']:ShowInput({
            header = "Sell " .. Config.ItemsFarming[fruit].label,
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
        dialog = lib.inputDialog("Sell " .. Config.ItemsFarming[fruit].label, {
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
                lib.progressCircle({
                    duration = Config.SellProgress,
                    label = 'Selling ' .. fruit,
                    canCancel = false,
                    position = 'bottom',
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