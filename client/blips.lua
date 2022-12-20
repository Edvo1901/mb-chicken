function displayAliveChickenBlips()
    if (Config.CatchAliveChicken["displayBlip"]) then
		local chicken_farm = AddBlipForCoord(Config.CatchAliveChicken["coords"].x, Config.CatchAliveChicken["coords"].y, Config.CatchAliveChicken["coords"].z)
	    SetBlipSprite(chicken_farm, Config.CatchAliveChicken["blipSprite"])
	    SetBlipDisplay(chicken_farm, 4)
	    SetBlipScale(chicken_farm, Config.CatchAliveChicken["blipScale"])
	    SetBlipColour (chicken_farm, Config.CatchAliveChicken["blipColor"])
	    SetBlipAsShortRange(chicken_farm, true)
	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentString(Config.CatchAliveChicken["label"])
	    EndTextCommandSetBlipName(chicken_farm)
	end
end

function displaySlaughteredChicken()
    for v in pairs(Config.SlaughteredChicken) do
        if (Config.SlaughteredChicken[v]["displayBlip"]) then
            local chicken_slaughter = AddBlipForCoord(Config.SlaughteredChicken[v]["coords"].x, Config.SlaughteredChicken[v]["coords"].y, Config.SlaughteredChicken[v]["coords"].z)
            SetBlipSprite(chicken_slaughter, Config.SlaughteredChicken[v]["blipSprite"])
            SetBlipDisplay(chicken_slaughter, 4)
            SetBlipScale(chicken_slaughter, Config.SlaughteredChicken[v]["blipScale"])
            SetBlipColour (chicken_slaughter, Config.SlaughteredChicken[v]["blipColor"])
            SetBlipAsShortRange(chicken_slaughter, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.SlaughteredChicken[v]["label"])
            EndTextCommandSetBlipName(chicken_slaughter)
        end
    end
end

function displaySellingBlips()
    if (Config.Selling["displayBlip"]) then
		local sell = AddBlipForCoord(Config.Selling["coords"].x, Config.Selling["coords"].y, Config.Selling["coords"].z)
	    SetBlipSprite(sell, Config.Selling["blipSprite"])
	    SetBlipDisplay(sell, 4)
	    SetBlipScale(sell, Config.Selling["blipScale"])
	    SetBlipColour (sell, Config.Selling["blipColor"])
	    SetBlipAsShortRange(sell, true)
	    BeginTextCommandSetBlipName("STRING")
	    AddTextComponentString(Config.Selling["label"])
	    EndTextCommandSetBlipName(sell)
	end
end