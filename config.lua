Config = {}

Config.Notify = "qb-core" --Which type of notify you want to use? Choose one of the following: "okokNotify", "qb-core", "roda-notify"

-- Step one: catching chicken detail
Config.CatchAliveChicken = {
    ["label"] = "Chicken farm", --name of blips
    ["coords"] = vector3(2388.725, 5044.985, 46.304), -- where should this spot be?
    ["spawnCoords"] = vector3(2385.963, 5047.333, 46.400), -- where should player spawn?
    ["amount_alive_chicken_to_give"] = 4, -- amount of chicken to give player
    ["displayBlip"] = true, -- should blips be displayed?
    ["blipColor"] = 46, -- color of blips
    ["blipScale"] = 0.8, -- scale of blips
    ["blipSprite"] = 126, -- sprite of blips
}

-- Step one (additional): spawn chicken detail
Config.SpawnChicken = {
    ["model"] = "a_c_hen", -- model of chicken (don't change)
    ["catching_chance"] = 70, -- catching chance success (70 = 70%, 100 = 100%)
    ["quantity"] = { -- where and how many chicken should spawn?
        [1] = {
            ["coords"] = vector4(2370.262, 5052.913, 46.437, 276.351),
        },
        [2] = {
            ["coords"] = vector4(2372.040, 5059.604, 46.444, 223.595),
        },
        [3] = {
            ["coords"] = vector4(2379.192, 5062.992, 46.444, 195.477),
        },
        [4] = {
            ["coords"] = vector4(2386.4, 5049.39, 46.47, 71.13),
        },
    }
}

-- Step two: slaughtered chicken detail
Config.SlaughteredChicken = {
    [1] = {
        ["label"] = "Chicken processing", -- name of blips
        ["coords"] = vector3(-96.007, 6206.92, 31.02), -- where should this spot be?
        ["heading"] = 311.0, -- heading of object (don't change)
        ["amount_alive_chicken_to_remove"] = 1, -- amount of alive chicken to remove from player at a time
        ["amount_slaughtered_chicken_to_give"] = 1, -- amount of slaughtered chicken to give player at a time
        ["processing_time"] = 7000, -- how long should processing take?
        ["displayBlip"] = true, -- should blips be displayed?
        ["blipColor"] = 46, -- color of blips
        ["blipScale"] = 0.8, -- scale of blips
        ["blipSprite"] = 273, -- sprite of blips
        ["prop"] = { -- object detail
            ["model"] = "prop_int_cf_chick_01", -- model of object (don't change)
            ["coords"] = vector3(-94.87, 6207.008, 30.08), -- where should object be?
            ["heading"] = 45.0, -- heading of object (don't change)
        },
    },
    [2] = {
        ["label"] = "Chicken processing",
        ["coords"] = vector3(-100.64, 6202.30, 31.02),
        ["heading"] = 220.0,
        ["amount_alive_chicken_to_remove"] = 1,
        ["amount_slaughtered_chicken_to_give"] = 1,
        ["processing_time"] = 7000,
        ["displayBlip"] = false,
        ["blipColor"] = 46,
        ["blipScale"] = 0.8,
        ["blipSprite"] = 273,
        ["prop"] = {
            ["model"] = "prop_int_cf_chick_01",
            ["coords"] = vector3(-100.39, 6201.56, 29.99),
            ["heading"] = -45.0,
        },
    }
}

-- Step three: packaged chicken detail
Config.PackagedChicken = {
    [1] = {
        ["label"] = "Chicken packing", -- name of blips
        ["coords"] = vector3(-106.44, 6204.29, 31.02), -- where should this spot be?
        ["heading"] = 40.0, -- heading of object (don't change)
        ["amount_slaughtered_chicken_to_remove"] = 1, -- amount of slaughtered chicken to remove from player at a time
        ["amount_packaged_chicken_to_give"] = 1, -- amount of packaged chicken to give player at a time
        ["processing_time"] = 7000, -- how long should processing take?
        ["displayBlip"] = true, -- should blips be displayed?
        ["blipColor"] = 46, -- color of blips
        ["blipScale"] = 0.8, -- scale of blips
        ["blipSprite"] = 273, -- sprite of blips
    },
    [2] = {
        ["label"] = "Chicken packing",
        ["coords"] = vector3(-104.20, 6206.45, 31.02),
        ["heading"] = 40.0,
        ["amount_slaughtered_chicken_to_remove"] = 1,
        ["amount_packaged_chicken_to_give"] = 1,
        ["processing_time"] = 7000,
        ["displayBlip"] = false,
        ["blipColor"] = 46,
        ["blipScale"] = 0.8,
        ["blipSprite"] = 273,
    }
}

Config.Selling = {
    ["label"] = "Selling chicken", -- name of blips
    ["coords"] = vector3(-1177.17, -890.68, 13.79), -- where should this spot be?
    ["money_type"] = "cash", -- type of money that should be given (cash, bank)
    ["price"] = 100, -- price of a chicken
    ["processing_time"] = 5000, -- how long should processing take?
    ["displayBlip"] = true, -- should blips be displayed?
    ["blipColor"] = 46, -- color of blips
    ["blipScale"] = 0.8, -- scale of blips
    ["blipSprite"] = 478, -- sprite of blips
}
