local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("mb-chicken:server:AddAliveChicken", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player then
		Player.Functions.AddItem('alive_chicken', Config.CatchAliveChicken["amount_alive_chicken_to_give"])
		TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['alive_chicken'], "add")
	end
end)

RegisterNetEvent('mb-chicken:server:SlaughteredChicken', function(position)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)

	xPlayer.Functions.RemoveItem('alive_chicken', Config.SlaughteredChicken[position]["amount_alive_chicken_to_remove"])
	TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['alive_chicken'], "remove")
	xPlayer.Functions.AddItem('slaughtered_chicken', Config.SlaughteredChicken[position]["amount_slaughtered_chicken_to_give"])
	TriggerClientEvent("inventory:client:ItemBox", src , QBCore.Shared.Items['slaughtered_chicken'], "add")
end)

RegisterNetEvent('mb-chicken:server:PackagedChicken', function(position)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)

	xPlayer.Functions.RemoveItem('slaughtered_chicken', Config.PackagedChicken[position]["amount_slaughtered_chicken_to_remove"])
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['slaughtered_chicken'], "remove")
	xPlayer.Functions.AddItem('packagedchicken', Config.PackagedChicken[position]["amount_packaged_chicken_to_give"])
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['packagedchicken'], "add")
end)

RegisterNetEvent('mb-chicken:server:SellingMoney', function()
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local price = 0
	if xPlayer then
		local sellItem = xPlayer.Functions.GetItemByName("packagedchicken")
		local amountItem = sellItem.amount

		price = Config.Selling["price"] * amountItem
		if price > 0 then
			xPlayer.Functions.RemoveItem("packagedchicken", amountItem)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['packagedchicken'], "remove")
			xPlayer.Functions.AddMoney(Config.Selling["money_type"], price, "sold-chicken")
			MBNotify(Lang:t("notify.title"), Lang:t("success.sold_chicken", {price = price}), "success", source)
		end
	end
end)