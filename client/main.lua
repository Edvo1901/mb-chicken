local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local QBCore = exports['qb-core']:GetCoreObject()

----------------------------------------------
--******************************************--
--            Global variable              	--
--******************************************--
----------------------------------------------
local isLoggedIn = true
local spawnChicken = false
local prop
local chickenPackage = false
local box_object, chicken_object, alive_chicken_object, knife_object
local isWorking = false
local chicken = {}
local getCaught = 0


----------------------------------------------
--******************************************--
--            Functions              		--
--******************************************--
----------------------------------------------
function StartCatching()
	local ped = PlayerPedId()
	local chickenModel = Config.SpawnChicken["model"]

	getCaught = 0

	for v in pairs(chicken) do
		DeleteEntity(chicken[v])
	end

	DoScreenFadeOut(500)
	Citizen.Wait(500)
	SetEntityCoordsNoOffset(ped, Config.CatchAliveChicken["spawnCoords"].x, Config.CatchAliveChicken["spawnCoords"].y, Config.CatchAliveChicken["spawnCoords"].z, 0, 0, 1)
	RequestModel(GetHashKey(chickenModel))

	while not HasModelLoaded(GetHashKey(chickenModel)) do
		Citizen.Wait(100)
	end

	for k, v in pairs(Config.SpawnChicken["quantity"]) do
		chicken[k] = CreatePed(26, chickenModel, v["coords"].x, v["coords"].y, v["coords"].z, v["coords"].h, true, false)
		TaskReactAndFleePed(chicken[k], ped)
	end

	Citizen.Wait(500)
	DoScreenFadeIn(500)
	spawnChicken = true
end

function CatchingChicken()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local startCatching = true

	chicken = {}
	getCaught = 0

	DoScreenFadeOut(500)
	Citizen.Wait(500)
	SetEntityCoordsNoOffset(ped, Config.CatchAliveChicken["coords"].x + 2, Config.CatchAliveChicken["coords"].y + 2, Config.CatchAliveChicken["coords"].z, 0, 0, 1)
	DoScreenFadeIn(500)

	prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)

	while startCatching do
		Citizen.Wait(250)
		local coords = GetEntityCoords(ped)
		local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 3.000, 0, 70)
		local vCoords = GetEntityCoords(veh)
		local dist = #(coords - vCoords)
		LoadDict('anim@heists@box_carry@')

		if not IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3 ) and startCatching then
			TaskPlayAnim(ped, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end

		if veh and (dist < 3.0) then
			startCatching = false

			MBNotify(Lang:t("notify.title"), Lang:t("success.put_alive_chicken_in_trunk"), "success")
			LoadDict('anim@heists@narcotics@trash')
			TaskPlayAnim(ped, 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			Citizen.Wait(300)
			ClearPedTasks(ped)
			DeleteEntity(prop)
			TriggerServerEvent("mb-chicken:server:AddAliveChicken")
		end
	end
end

function chickenGotCaught(pass)
	LoadDict('move_jump')
	TaskPlayAnim(PlayerPedId(), 'move_jump', 'dive_start_run', 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
	Citizen.Wait(600)
	SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
	Citizen.Wait(1000)
	local chance = math.random(1,100)
	if chance <= Config.SpawnChicken["catching_chance"] then
		getCaught = getCaught + 1
		MBNotify(Lang:t("notify.title"), Lang:t("success.catch_success"), "success")
		DeleteEntity(chicken[pass])
	else
		MBNotify(Lang:t("notify.title"), Lang:t("error.catch_failed"), "error")
	end
end

function processAliveChicken(position)
	local Player = PlayerPedId()

	if Player then
		local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
		LoadDict(dict)
		FreezeEntityPosition(Player,true)
		TaskPlayAnim(Player, dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		local PedCoords = GetEntityCoords(Player)
		knife_object = CreateObject(GetHashKey('prop_knife'), PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
		AttachEntityToEntity(knife_object, Player, GetPedBoneIndex(Player, 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)

		if Player then
			QBCore.Functions.Progressbar("cutting_chicken", Lang:t("process.cutting"), Config.SlaughteredChicken[position]["processing_time"], false, true, {disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
				disableInventory = true,
			}, {}, {}, {}, function()
			TriggerServerEvent("mb-chicken:server:SlaughteredChicken", position)
			end, function()

			end)
			SetEntityHeading(Player, Config.SlaughteredChicken[position]["heading"])
			alive_chicken_object = CreateObject(GetHashKey(Config.SlaughteredChicken[position]["prop"]["model"]), Config.SlaughteredChicken[position]["prop"]["coords"].x, Config.SlaughteredChicken[position]["prop"]["coords"].y, Config.SlaughteredChicken[position]["prop"]["coords"].z, true, true, true)
			SetEntityRotation(alive_chicken_object, 90.0, 0.0, Config.SlaughteredChicken[position]["prop"]["heading"], 1, true)
			Citizen.Wait(Config.SlaughteredChicken[position]["processing_time"])
		end

		FreezeEntityPosition(Player,false)
		DeleteEntity(alive_chicken_object)
		DeleteEntity(knife_object)
		ClearPedTasks(Player)
	end
end

function packChicken(position)
	local Player = PlayerPedId()
	local PedCoords = GetEntityCoords(Player)

	if Player then
		QBCore.Functions.Progressbar("packing_chicken", Lang:t("process.packing"), Config.PackagedChicken[position]["processing_time"], false, true, {disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
				disableInventory = true,
			}, {}, {}, {}, function()
				TriggerServerEvent("mb-chicken:server:PackagedChicken", position)
				MBNotify(Lang:t("notify.title"), Lang:t("success.keep_going_or_sell"), "info")
			end, function()

			end)
		SetEntityHeading(Player, Config.PackagedChicken[position]["heading"])
		chicken_object = CreateObject(GetHashKey('prop_cs_steak'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
		AttachEntityToEntity(chicken_object, Player, GetPedBoneIndex(Player, 0x49D9), 0.15, 0.0, 0.01, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

		box_object = CreateObject(GetHashKey('prop_cs_clothes_box'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
		AttachEntityToEntity(box_object, Player, GetPedBoneIndex(Player, 57005), 0.13, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 2, true)

		isWorking = true
		LoadDict("anim@heists@ornate_bank@grab_cash_heels")
		TaskPlayAnim(Player, "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
		FreezeEntityPosition(Player, true)
		Citizen.Wait(Config.PackagedChicken[position]["processing_time"])

		ClearPedTasks(Player)
		DeleteEntity(chicken_object)
		DeleteEntity(box_object)
	end
end

function StopPacking()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	FreezeEntityPosition(ped, false)
	chickenPackage = true
	prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z+0.2,  true,  true, true)
	AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
	isWorking = false

	while chickenPackage do
		Citizen.Wait(250)

		local coords = GetEntityCoords(ped)
		local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 3.000, 0, 70)
		local vCoords = GetEntityCoords(veh)
		local dist = #(coords - vCoords)

		LoadDict('anim@heists@box_carry@')

		if not IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 3 ) and chickenPackage == true then
			TaskPlayAnim(ped, 'anim@heists@box_carry@', "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
		end

		if veh and (dist < 3.0) then
			chickenPackage = false
			MBNotify(Lang:t("notify.title"), Lang:t("success.put_chicken_on_car"), 'success') --success
			LoadDict('anim@heists@narcotics@trash')
			TaskPlayAnim(ped, 'anim@heists@narcotics@trash', "throw_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
			Citizen.Wait(1000)
			ClearPedTasks(ped)
			DeleteEntity(prop)
		end
	end
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

function SellingChicken()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.9, -0.98))
	----
	if ped then
		QBCore.Functions.Progressbar("selling_chicken", Lang:t("process.selling"), Config.Selling["processing_time"], false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
			disableInventory = true,
		}, {}, {}, {}, function() end, function()

		end)
		prop = CreateObject(GetHashKey('hei_prop_heist_box'), x, y, z,  true,  true, true)
		SetEntityHeading(prop, GetEntityHeading(ped))
		LoadDict('amb@medic@standing@tendtodead@idle_a')
		TaskPlayAnim(ped, 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
		Citizen.Wait(5000)
		LoadDict('amb@medic@standing@tendtodead@exit')
		TaskPlayAnim(ped, 'amb@medic@standing@tendtodead@exit', 'exit', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
		ClearPedTasks(ped)
		DeleteEntity(prop)
		TriggerServerEvent("mb-chicken:server:SellingMoney")
	end
end

----------------------------------------------
--******************************************--
--            Citizen Thread              	--
--******************************************--
----------------------------------------------

-- Load data
Citizen.CreateThread(function()
	while QBCore.Functions.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	-- Display blips
	displayAliveChickenBlips()
	displaySlaughteredChicken()
	displaySellingBlips()

	PlayerData = QBCore.Functions.GetPlayerData()
end)

Citizen.CreateThread(function()
    while (isLoggedIn) do
		Citizen.Wait(1)

		-- Catching chicken
		local plyCoords = GetEntityCoords(PlayerPedId())
		local startCoords = Config.CatchAliveChicken["coords"]
		local distance = #(plyCoords - startCoords)
		if distance <= 10.0 then
			DrawMarker(27, Config.CatchAliveChicken["coords"].x, Config.CatchAliveChicken["coords"].y, Config.CatchAliveChicken["coords"].z-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
			if distance <= 2.5 then
				QBCore.Functions.DrawText3D(Config.CatchAliveChicken["coords"].x, Config.CatchAliveChicken["coords"].y, Config.CatchAliveChicken["coords"].z, Lang:t("action.get_started"))
				if distance <= 0.5 then
					if IsControlJustPressed(0, Keys['E']) then
						StartCatching()
					end
				end
			end
		end

		-- Processing chicken
		for farm in pairs(Config.SlaughteredChicken) do
			local processCoords = Config.SlaughteredChicken[farm]["coords"]
			local dist = #(plyCoords - processCoords)
			if dist <= 10.0 then
				DrawMarker(27, Config.SlaughteredChicken[farm]["coords"].x, Config.SlaughteredChicken[farm]["coords"].y, Config.SlaughteredChicken[farm]["coords"].z-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
				if dist < 2.5 then
					QBCore.Functions.DrawText3D(Config.SlaughteredChicken[farm]["coords"].x, Config.SlaughteredChicken[farm]["coords"].y, Config.SlaughteredChicken[farm]["coords"].z, Lang:t("action.cut_alive_chicken"))
					if dist < 1 then
						if IsControlJustPressed(0, Keys['E']) then -- "E"
							local hasItem = QBCore.Functions.HasItem('alive_chicken')
							if hasItem then
								processAliveChicken(farm)
								Citizen.Wait(100)
							else
								MBNotify(Lang:t("notify.title"), Lang:t("error.no_alive_chicken"), "error")
							end
						end
					end
				end
			end
		end

		-- Packing chicken
		for spot in pairs(Config.PackagedChicken) do
			local packCoords = Config.PackagedChicken[spot]["coords"]
			local dist = #(plyCoords - packCoords)

			if dist <= 10.0 then
				DrawMarker(27, Config.PackagedChicken[spot]["coords"].x, Config.PackagedChicken[spot]["coords"].y, Config.PackagedChicken[spot]["coords"].z-0.97, 0, 0, 0, 0, 0, 0, 0.90, 0.90, 0.90, 255, 255, 255, 200, 0, 0, 0, 0)
				if dist < 2.5 and not isWorking then
					QBCore.Functions.DrawText3D(Config.PackagedChicken[spot]["coords"].x, Config.PackagedChicken[spot]["coords"].y, Config.PackagedChicken[spot]["coords"].z, Lang:t("action.pack_chicken"))
					if dist < 1 then
						if IsControlJustPressed(0, Keys['E']) then -- "E"
							local hasItem = QBCore.Functions.HasItem('slaughtered_chicken')
							if hasItem then
								packChicken(spot)
								Citizen.Wait(100)
							else
								MBNotify(Lang:t("notify.title"), Lang:t("error.no_slaughtered_chicken"), "error")
							end
						end
					end
				elseif dist < 2.5 and isWorking then
					QBCore.Functions.DrawText3D(Config.PackagedChicken[spot]["coords"].x, Config.PackagedChicken[spot]["coords"].y, Config.PackagedChicken[spot]["coords"].z+0.5, Lang:t("action.stop_packing"))
					QBCore.Functions.DrawText3D(Config.PackagedChicken[spot]["coords"].x, Config.PackagedChicken[spot]["coords"].y, Config.PackagedChicken[spot]["coords"].z, Lang:t("action.keep_packing"))
					if dist < 1 then
						if IsControlJustPressed(0, Keys['E']) then -- "E"
							local hasItem = QBCore.Functions.HasItem("slaughtered_chicken")
							if hasItem then
								packChicken(spot)
								Citizen.Wait(100)
							else
								MBNotify(Lang:t("notify.title"), Lang:t("error.no_slaughtered_chicken"), "error")
							end
						elseif IsControlJustPressed(0, Keys['G']) then
							StopPacking()
						end
					end
				end
			end
		end

		-- Selling
		local sellCoords = Config.Selling["coords"]
		local sellDist = #(plyCoords - sellCoords)
		if sellDist < 10.0 then
			DrawMarker(27, Config.Selling["coords"].x, Config.Selling["coords"].y, Config.Selling["coords"].z-0.96, 0, 0, 0, 0, 0, 0, 2.20, 2.20, 2.20, 255, 255, 255, 200, 0, 0, 0, 0)
			if sellDist <= 2.5 then
				QBCore.Functions.DrawText3D(Config.Selling["coords"].x, Config.Selling["coords"].y, Config.Selling["coords"].z, Lang:t("action.sell_packing"))
				if sellDist <= 0.5 then
					if IsControlJustPressed(0, Keys['E']) then
						local hasItem = QBCore.Functions.HasItem("packagedchicken")
						if hasItem then
							SellingChicken()
							Citizen.Wait(100)
						else
							MBNotify(Lang:t("notify.title"), Lang:t("error.no_packaged_chicken"), "error")
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
	    Citizen.Wait(5)
		local plyCoords = GetEntityCoords(PlayerPedId(), false)
		if spawnChicken then
			for k, v in pairs(chicken) do
				local chickenCoords = GetEntityCoords(v)
				local dist = #(plyCoords - chickenCoords)
				if dist < 1 then
					QBCore.Functions.DrawText3D(chickenCoords.x, chickenCoords.y, chickenCoords.z+0.5, Lang:t("action.catching"))
					if IsControlJustPressed(0, Keys['E']) then
						chickenGotCaught(k)
					end
				end
			end

			if getCaught == #(Config.SpawnChicken["quantity"]) then
				MBNotify(Lang:t("notify.title"), Lang:t("action.bring_close_to_vehicle"), "info")
				spawnChicken = false
				ClearPedTasks(PlayerPedId())
				for v in pairs(chicken) do
					DeleteEntity(v)
				end
				CatchingChicken()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

----------------------------------------------
--******************************************--
--            Register Event              	--
--******************************************--
----------------------------------------------
--On player load
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        PlayerData = QBCore.Functions.GetPlayerData()
    end)
	isLoggedIn = true
end)