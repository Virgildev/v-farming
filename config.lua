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
    {
        label = "Cherry Farm",
        item = "cherry",
        blipSprite = 1,
        blipColor = 6,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(2316.8899, 5008.7749, 42.1238),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2316.6121, 5023.4224, 42.9045),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
    {
        label = "Peach Farm",
        item = "peach",
        blipSprite = 1,
        blipColor = 41,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(263.954, 6506.2642, 30.1377),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(273.3794, 6507.5273, 29.8491),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
    {
        label = "Banana Farm",
        item = "banana",
        blipSprite = 1,
        blipColor = 5,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(2016.1273, 4800.5098, 41.3909),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2003.7551, 4787.0229, 41.2767),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
    {
        label = "Strawberry Farm",
        item = "strawberry",
        blipSprite = 1,
        blipColor = 69,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(2094.4412, 4918.4678, 39.0438),
                amount = 1,
                radius = 1.0,
                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer"
            },
            {
                coords = vec3(2093.3669, 4916.8594, 39.0883),
                amount = 1,
                radius = 1.0,
                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer"
            },
            -- Add more targets as needed
        }
    },
    {
        label = "Blueberry Farm",
        item = "blueberry",
        blipSprite = 1,
        blipColor = 38,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(2002.3296, 4818.6514, 41.9856),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2001.4473, 4819.5435, 42.2422),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
    {
        label = "Grape Farm",
        item = "grape",
        blipSprite = 1,
        blipColor = 27,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(1941.713, 5084.269, 40.7254),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(1936.7863, 5088.4775, 41.0482),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
    {
        label = "Kiwi Farm",
        item = "kiwi",
        blipSprite = 1,
        blipColor = 24,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(1877.366, 4850.063, 44.3105),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(1878.5507, 4848.8071, 44.3344),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
    {
        label = "Lemon Farm",
        item = "lemon",
        blipSprite = 1,
        blipColor = 46,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(1815.9979, 5015.1519, 55.611),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(1814.9727, 5014.3198, 55.3196),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
    {
        label = "Mango Farm",
        item = "mango",
        blipSprite = 1,
        blipColor = 66,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(2389.4907, 5004.5469, 45.2739),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2377.6086, 5004.125, 44.0965),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
    {
        label = "Watermelon Farm",
        item = "watermelon",
        blipSprite = 1,
        blipColor = 59,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(2341.4661, 5107.9175, 45.7731),
                amount = 1,
                radius = 1.0,
                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer"
            },
            {
                coords = vec3(2340.4465, 5106.0469, 45.5998),
                amount = 1,
                radius = 1.0,
                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer"
            },
            -- Add more targets as needed
        }
    },
    { -- unsure why i added this
        label = "Milk Farm",
        item = "milk",
        blipSprite = 1,
        blipColor = 37,
        blipScale = 0.8,
        targets = {
            {
                coords = vec3(2389.283, 5025.3223, 45.0286),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            {
                coords = vec3(2392.1479, 5022.3193, 45.0452),
                amount = 1,
                radius = 1.0,
                animDict = "missmechanic",
                anim = "work_base"
            },
            -- Add more targets as needed
        }
    },
}
