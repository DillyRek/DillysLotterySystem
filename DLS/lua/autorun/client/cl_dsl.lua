surface.CreateFont( "DLSfontclose", {
		font = "Lato Light",
		size = 25,
		weight = 250,
		antialias = true,
		strikeout = false,
		additive = true,
} )
 
surface.CreateFont( "DLSTitleFont", {
	font = "Lato Light",
	size = 30,
	weight = 250,
	antialias = true,
	strikeout = false,
	additive = true,
} )
 
surface.CreateFont( "DLSHeadingFont", {
	font = "Arial",
	size = 25,
	weight = 500,
} )
 
local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount) --Panel blur function
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()
	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(blur)
	for i = 1, 6 do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

local function drawRectOutline( x, y, w, h, color )
	surface.SetDrawColor( color )
	surface.DrawOutlinedRect( x, y, w, h )
end

net.Receive( "DLSOpenTicket", function()

	local num1 = net.ReadFloat()
	local num2 = net.ReadFloat()
	local num3 = net.ReadFloat()
	local answer1 = net.ReadFloat()
	local answer2 = net.ReadFloat()
	local answer3 = net.ReadFloat()
	
	function MainMenu()
		local menu = vgui.Create( "DFrame" )
		menu:SetSize( 250, 200 )
		menu:Center()
		menu:SetDraggable( true )
		menu:MakePopup()
		menu:SetTitle( "" )
		menu:ShowCloseButton( false )
		menu.Paint = function( self, w, h )
			DrawBlur(menu, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 85))
			drawRectOutline( 2, 2, w - 4, h / 3.9, Color( 0, 0, 0, 85 ) )
			draw.RoundedBox(0, 2, 2, w - 4, h / 4, Color(0,0,0,125))
			draw.SimpleText( "Lottery Ticket", "DLSTitleFont", menu:GetWide() / 2, 25, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		

		local frameclose = vgui.Create( "DButton", menu )
		frameclose:SetSize( 35, 35 )
		frameclose:SetPos( menu:GetWide() - 34,10 )
		frameclose:SetText( "X" )
		frameclose:SetFont( "DLSfontclose" )
		frameclose:SetTextColor( Color( 255, 255, 255 ) )
		frameclose.Paint = function()
			
		end
		frameclose.DoClick = function()
			menu:Close()
			menu:Remove()
			gui.EnableScreenClicker( false )			
		end	
		
		local BuyTicketBtn = vgui.Create( "DButton", menu )
		BuyTicketBtn:SetPos( 2,70 )
		BuyTicketBtn:SetSize( menu:GetWide() - 4,20 )
		BuyTicketBtn:SetText( "Buy ticket for "..DarkRP.formatMoney(DLSConfig.PriceForTicket) )
		BuyTicketBtn:SetTextColor( Color( 255, 255, 255 ) )	
		BuyTicketBtn.Paint = function( self, w, h )		
			DrawBlur(BuyTicketBtn, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 125))
		end
		BuyTicketBtn.DoClick = function()
			local money = LocalPlayer():getDarkRPVar("money")
			if money >= DLSConfig.PriceForTicket then
				menu:Close()
				menu:Remove()
				gui.EnableScreenClicker( true )			
				ViewTicket()
				net.Start("DLSRemoveMoney")
				net.SendToServer()	
			else
				chat.AddText(Color(255,0,0), "You do not have enough money!")
			end
		end
	end
	
	function ViewTicket()
		local menu = vgui.Create( "DFrame" )
		menu:SetSize( 250, 200 )
		menu:Center()
		menu:SetDraggable( true )
		menu:MakePopup()
		menu:SetTitle( "" )
		menu:ShowCloseButton( false )
		menu.Paint = function( self, w, h )
			DrawBlur(menu, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 85))
			drawRectOutline( 2, 2, w - 4, h / 3.9, Color( 0, 0, 0, 85 ) )
			draw.RoundedBox(0, 2, 2, w - 4, h / 4, Color(0,0,0,125))
			draw.SimpleText( "Lottery Ticket", "DLSTitleFont", menu:GetWide() / 2, 25, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
		if DLSConfig.DevMode then
			local frameclose = vgui.Create( "DButton", menu )
			frameclose:SetSize( 35, 35 )
			frameclose:SetPos( menu:GetWide() - 34,10 )
			frameclose:SetText( "X" )
			frameclose:SetFont( "DLSfontclose" )
			frameclose:SetTextColor( Color( 255, 255, 255 ) )
			frameclose.Paint = function()
				
			end
			frameclose.DoClick = function()
				menu:Close()
				menu:Remove()
				gui.EnableScreenClicker( false )			
			end	
		end
		
		local Scrach1Btn = vgui.Create( "DButton", menu )
		Scrach1Btn:SetPos( 2,70 )
		Scrach1Btn:SetSize( menu:GetWide() - 4,20 )
		Scrach1Btn:SetText( "First Number" )
		Scrach1Btn:SetTextColor( Color( 255, 255, 255 ) )	
		Scrach1Btn.Paint = function( self, w, h )		
			DrawBlur(Scrach1Btn, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 125))
		end
		Scrach1Btn.DoClick = function()
			chat.AddText(Color(255,0,0), "Click the scrach button!")		
		end
	
		local Scrach2Btn = vgui.Create( "DButton", menu )
		Scrach2Btn:SetPos( 2,95 )
		Scrach2Btn:SetSize( menu:GetWide() - 4,20 )
		Scrach2Btn:SetText( "Seconed Number" )
		Scrach2Btn:SetTextColor( Color( 255, 255, 255 ) )	
		Scrach2Btn.Paint = function( self, w, h )		
			DrawBlur(Scrach2Btn, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 125))
		end	
		Scrach2Btn.DoClick = function()
			chat.AddText(Color(255,0,0), "Click the scrach button!")
		end
		
		local Scrach3Btn = vgui.Create( "DButton", menu )
		Scrach3Btn:SetPos( 2,120 )
		Scrach3Btn:SetSize( menu:GetWide() - 4,20 )
		Scrach3Btn:SetText( "Third Number" )
		Scrach3Btn:SetTextColor( Color( 255, 255, 255 ) )	
		Scrach3Btn.Paint = function( self, w, h )		
			DrawBlur(Scrach3Btn, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 125))
		end	
		Scrach3Btn.DoClick = function()
			chat.AddText(Color(255,0,0), "Click the scrach button!")
		end

		local ScratchBtn = vgui.Create( "DButton", menu )
		ScratchBtn:SetPos( 2,145 )
		ScratchBtn:SetSize( menu:GetWide() - 4,20 )
		ScratchBtn:SetText( "Scrach" )
		ScratchBtn:SetTextColor( Color( 255, 255, 255 ) )	
		ScratchBtn.Paint = function( self, w, h )		
			DrawBlur(ScratchBtn, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 125))
		end			
		ScratchBtn.DoClick = function()
			menu:Close()
			menu:Remove()
			gui.EnableScreenClicker( true )
			FinalTicket()
		end	
	end
	
	function FinalTicket()
		local menu = vgui.Create( "DFrame" )
		menu:SetSize( 250, 200 )
		menu:Center()
		menu:SetDraggable( true )
		menu:MakePopup()
		menu:SetTitle( "" )
		menu:ShowCloseButton( false )
		menu.Paint = function( self, w, h )
			DrawBlur(menu, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 85))
			drawRectOutline( 2, 2, w - 4, h / 3.9, Color( 0, 0, 0, 85 ) )
			draw.RoundedBox(0, 2, 2, w - 4, h / 4, Color(0,0,0,125))
			draw.SimpleText( "Lottery Ticket", "DLSTitleFont", menu:GetWide() / 2, 25, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
		if DLSConfig.DevMode then
			local frameclose = vgui.Create( "DButton", menu )
			frameclose:SetSize( 35, 35 )
			frameclose:SetPos( menu:GetWide() - 34,10 )
			frameclose:SetText( "X" )
			frameclose:SetFont( "DLSfontclose" )
			frameclose:SetTextColor( Color( 255, 255, 255 ) )
			frameclose.Paint = function()
				
			end
			frameclose.DoClick = function()
				menu:Close()
				menu:Remove()
				gui.EnableScreenClicker( false )			
			end	
		end
		
		local Scrach1Btn = vgui.Create( "DButton", menu )
		Scrach1Btn:SetPos( 2,70 )
		Scrach1Btn:SetSize( menu:GetWide() - 4,20 )
		if DLSConfig.DevMode then
			Scrach1Btn:SetText( num1.."/"..answer1 )
		else
			Scrach1Btn:SetText( num1 )
		end
		Scrach1Btn:SetTextColor( Color( 255, 255, 255 ) )	
		Scrach1Btn.Paint = function( self, w, h )		
			DrawBlur(Scrach1Btn, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 125))
		end
		Scrach1Btn.DoClick = function()
		
		end
	
		local Scrach2Btn = vgui.Create( "DButton", menu )
		Scrach2Btn:SetPos( 2,95 )
		Scrach2Btn:SetSize( menu:GetWide() - 4,20 )
		if DLSConfig.DevMode then
			Scrach2Btn:SetText( num2.."/"..answer2 )
		else
			Scrach2Btn:SetText( num2 )		
		end
		Scrach2Btn:SetTextColor( Color( 255, 255, 255 ) )	
		Scrach2Btn.Paint = function( self, w, h )		
			DrawBlur(Scrach2Btn, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 125))
		end	
		Scrach2Btn.DoClick = function()

		end
		
		local Scrach3Btn = vgui.Create( "DButton", menu )
		Scrach3Btn:SetPos( 2,120 )
		Scrach3Btn:SetSize( menu:GetWide() - 4,20 )
		if DLSConfig.DevMode then
			Scrach3Btn:SetText( num3.."/"..answer3 )
		else
			Scrach3Btn:SetText( num3 )
		end
		Scrach3Btn:SetTextColor( Color( 255, 255, 255 ) )	
		Scrach3Btn.Paint = function( self, w, h )		
			DrawBlur(Scrach3Btn, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 125))
		end	
		Scrach3Btn.DoClick = function()
		
		end

		local ScratchBtn = vgui.Create( "DButton", menu )
		ScratchBtn:SetPos( 2,145 )
		ScratchBtn:SetSize( menu:GetWide() - 4,20 )
		ScratchBtn:SetText( "Claim Rewards" )
		ScratchBtn:SetTextColor( Color( 255, 255, 255 ) )	
		ScratchBtn.Paint = function( self, w, h )		
			DrawBlur(ScratchBtn, 2)
			drawRectOutline( 0, 0, w, h, Color( 0, 0, 0, 85 ) )	
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 125))
		end			
		ScratchBtn.DoClick = function()
			menu:Close()
			menu:Remove()
			gui.EnableScreenClicker( false )
			net.Start("DLSRewards")
				net.WriteFloat(num1)
				net.WriteFloat(num2)
				net.WriteFloat(num3)
				net.WriteFloat(answer1)
				net.WriteFloat(answer2)
				net.WriteFloat(answer3)
			net.SendToServer()			
		end		
	end
	
	MainMenu()
	
end )

net.Receive("DLSRewardsText", function()
	local winners = net.ReadFloat() 
	
	if winners == 1 then
		chat.AddText(Color(0,255,0), "You matched one number! You won: "..DarkRP.formatMoney(DLSConfig.RewardMatch1))
	elseif winners == 2 then
		chat.AddText(Color(0,255,0), "You matched two numbers! You won: "..DarkRP.formatMoney(DLSConfig.RewardMatch2))			
	elseif winners == 3 then
		chat.AddText(Color(0,255,0), "You matched all the numbers! You won: "..DarkRP.formatMoney(DLSConfig.RewardMatch3))				
	else
		chat.AddText(Color(255,0,0), "You did not win anything sorry!")
	end	
end)

net.Receive("DLSCoolDownText", function()
	chat.AddText(Color(255,0,0), "You need to wait the cooldown!")
end)