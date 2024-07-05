# v-farming

A farming script for FiveM servers using QBCore/OX.

Preview: [Watch Video](https://streamable.com/o5ap3j)

Dive into the world of farming with our immersive Lua script designed for FiveM servers. Players can cultivate various fruits and items, then sell them for profit. Customize your server's economy and gameplay.

## Key Features:

- **Fruit Picking:**
  - Harvest apples, pears, cherries, and more from designated locations.
- **Selling:**
  - Sell harvested items to NPCs for in-game currency.
- **Customizable Config:**
  - Adjust item prices, picking times, and selling locations.
  - Configure farming spots and integration with menu systems (`ox` or `qb`).

## Config

```
Config = {}

-- ox_target and qb-target works without any changes
-- ox_inventory and qb-inventory works without any changes
Config.Progress = 'ox' -- qb or ox
Config.Notify = 'ox' -- qb or ox
Config.Menu = 'ox' -- qb or ox

-- Define the ped model (default: a_m_m_farmer_01)
Config.PedModel = "a_m_m_farmer_01"

-- Define the ped and target location
Config.Location = {
    coords = vector3(2564.3635, 4680.3677, 33.0768),
    heading = 46.2758
}

-- Blip for the purchaser
Config.SellerBlip = {
    label = 'Fruit Buyer',
    coords = vector3(2564.3635, 4680.3677, 33.0768),
    blipSprite = 1,
    blipColor = 1,
    blipScale = 0.8,
}

-- Animation while selling to the ped
Config.SellingAnimDict = 'missheistdockssetup1ig_12@idle_b'
Config.SellingAnimName = 'talk_gantry_idle_b_worker1'

-- Progress time for selling
Config.SellProgress = 10000

-- Progress time for picking
Config.PickingProgress = 8000

-- Purchaser and their prices
Config.Items = {
    ['apple'] = {label = 'Apple', price = 4},
    ['pear'] = {label = 'Pear', price = 4},
    ['cherry'] = {label = 'Cherry', price = 4},
    ['peach'] = {label = 'Peach', price = 4},
    ['banana'] = {label = 'Banana', price = 4},
    ['strawberry'] = {label = 'Strawberry', price = 4},
    ['blueberry'] = {label = 'Blueberry', price = 4},
    ['grape'] = {label = 'Grape', price = 4},
    ['kiwi'] = {label = 'Kiwi', price = 4},
    ['lemon'] = {label = 'Lemon', price = 4},
    ['mango'] = {label = 'Mango', price = 4},
    ['watermelon'] = {label = 'Watermelon', price = 4},
    ['milk'] = {label = 'Milk', price = 4},
}

Config.FarmingLocations = {
    {
        label = "Apple Farm", -- Label for Blip
        item = "apple", -- Item Given Upon Pick
        blipSprite = 1, -- Blip Sprite (use https://docs.fivem.net/docs/game-references/blips/ to find more)
        blipColor = 1, -- Blip Color (use https://docs.fivem.net/docs/game-references/blips/ to find more)
        blipScale = 0.8, -- Blip Size (use https://docs.fivem.net/docs/game-references/blips/ to find more)
        targets = { -- You can add an unlimited amount of targets for each farm, just use same format
            {
                coords = vec3(2325.658, 4761.7646, 35.3383), -- target location for picking spot
                amount = 1, -- amount given for specific spot
                radius = 3.0, -- target radius (how big target zone is)
                animDict = "missmechanic", -- animiation dict while picking
                anim = "work_base" --animation while picking
            },
            {
                coords = vec3(2327.4397, 4770.812, 35.3807),
                amount = 1,
                radius = 3.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2324.5562, 4746.9751, 35.3255),
                amount = 1,
                radius = 3.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2343.4829, 4755.6084, 34.0372),
                amount = 1,
                radius = 3.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2339.3142, 4767.1074, 34.0771),
                amount = 1,
                radius = 3.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2339.3391, 4741.3511, 35.0943),
                amount = 1,
                radius = 3.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2353.4775, 4760.3389, 34.5284),
                amount = 1,
                radius = 3.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- You can add as many as you wish
        }
    },
    {
        label = "Orange Farm",
        item = "orange",
        blipSprite = 1,
        blipColor = 81,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(347.8063, 6505.1909, 27.9985),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(355.226, 6504.8828, 27.8282),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
    {
        label = "Pear Farm",
        item = "pear",
        blipSprite = 1,
        blipColor = 25,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(2064.2126, 4819.52, 41.452),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2086.0752, 4825.6187, 41.1552),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
}
```

## Video Demonstration
Watch the farming script in action: [Farming Script Video](https://streamable.com/o5ap3j).

## Installation
1. Download the script files.
2. Place them in your server's resource folder (`resources` for FiveM).
3. Add the script to your server.cfg.
4. Customize settings such as item prices, pick times, and NPC locations as needed.

## Requirements:
- `ox_target` or `qb-target`
- `ox_inventory` or `qb-inventory`
- Menu integration (`ox` or `qb`)
