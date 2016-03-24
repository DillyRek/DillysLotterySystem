util.AddNetworkString("LMMLOpenTicket")
util.AddNetworkString("LMMLRemoveMoney")
util.AddNetworkString("LMMLRewards")
util.AddNetworkString("LMMLRewardsText")
util.AddNetworkString("LMMLCoolDownText")

function LMMLPutUserOnCoolDown(ply)
	ply:SetNWBool("LMMLCoolDown", true)
	timer.Create("LMMLCoolDownFor"..ply:SteamID64(), LMMLConfig.CoolDown, 1, function()
		ply:SetNWBool("LMMLCoolDown", false)
	end	)
end

function LMMLCheckCoolDown(ply)
	return ply:GetNWBool("LMMLCoolDown", false)
end

function SendLotteryTicket(ply)
	local num1 = math.random(1, 3)
	local num2 = math.random(1, 3)
	local num3 = math.random(1, 3)

	local answer1 = math.random(1, 3)
	local answer2 = math.random(1, 3)
	local answer3 = math.random(1, 3)
	
	net.Start("LMMLOpenTicket")
		net.WriteFloat(num1)
		net.WriteFloat(num2)
		net.WriteFloat(num3)
		net.WriteFloat(answer1)
		net.WriteFloat(answer2)
		net.WriteFloat(answer3)
	net.Send(ply)
	
	net.Receive("LMMLRemoveMoney", function( len, theply )
		if theply ~= ply then
			if LMMLConfig.AutoBanExploiters then
				RunConsoleCommand("ulx", "banid", ply:SteamID(), "0", "Attempting to use exploits on the lottery addon")
			end
			return
		else
			if theply:getDarkRPVar("money") > LMMLConfig.PriceForTicket then
				theply:addMoney(-LMMLConfig.PriceForTicket)
			else
				theply:ChatPrint("You do not have enough money!")
			end
		end
	end)
	
	net.Receive("LMMLRewards", function( len, ply )
		
		local winners = 0
		local clnum1, clnum2, clnum3 = net.ReadFloat(), net.ReadFloat(), net.ReadFloat()
		local clans1, clans2, clans3 = net.ReadFloat(), net.ReadFloat(), net.ReadFloat()
		
		if ( clnum1 ~= num1 or clnum2 ~= num2 or clnum3 ~= num3 or clans1 ~= answer1 or clans2 ~= answer2 or clans3 ~= answer3 ) then
			if LMMLConfig.AutoBanExploiters then
				RunConsoleCommand("ulx", "banid", ply:SteamID(), "0", "Attempting to use exploits on the lottery addon")
			end
			return
		end 

		if clnum1 == answer1 then winners = winners + 1 end
		if clnum2 == answer2 then winners = winners + 1 end
		if clnum3 == answer3 then winners = winners + 1 end
		
		if winners == 1 then
			ply:addpoints(LMMLConfig.RewardMatch1)
		elseif winners == 2 then
			ply:addpoints(LMMLConfig.RewardMatch2)
		elseif winners == 3 then
			ply:addpoints(LMMLConfig.RewardMatch3)
		end			
		
		net.Start("LMMLRewardsText")
			net.WriteFloat(winners)
		net.Send(ply)
		
		LMMLPutUserOnCoolDown(ply)
		
	end )
	
end

function LMMLOpenMenu(ply, text)
	local text = string.lower(text)
	if ( string.sub( string.lower(text), 0, 7) == "!lottery" ) then
		if not LMMLCheckCoolDown(ply) then
			SendLotteryTicket(ply)
		else
			net.Start("LMMLCoolDownText")
			net.Send(ply)
		end
		return ''
	end
end 
hook.Add("PlayerSay", "LMMLOpenMenu", LMMLOpenMenu)