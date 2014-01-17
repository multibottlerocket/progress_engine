local QRange = 600
local autoRange = 550
local interleaveSpell = false
local AttackRange = 1000
local towers = {}
local tTower
local moving = 0
local movingX = 0
local movingZ = 0
local healing = 0
local print = 0
local currentX = 0
local currentZ = 0
local counter = 0
local healTime = 0
local theMinions
local backingFlag = 0
local lockVal = 0

local items =     {1027,3340,3070,1001,3108,1026,3060,3158,1011,1026,3116,3010,1026,3027,1026,3003,1026,3135}
local itemsCost = {400 ,0   ,300 ,325 ,820 ,860 ,720 ,675 ,1000,860 ,1040,1200,860 ,740 ,860 ,1140,860 ,1435}

-- frozen heart
-- 1031,3024,3082,3110,
-- 720 ,630 ,1000,550 ,

-- abyssal
-- 1057,1026,3001,
-- 720 ,860 ,980 ,

-- banner
-- 3108,1026,3060,
-- 820 ,860 ,720 ,

-- health pot
-- 2003,
-- 35  ,

local spellLevels = {_Q,_W,_Q,_E,_Q,_R,_Q,_W,_Q,_W,_R,_W,_W,_E,_E,_R,_E,_E}
local currentLevel = 0
local itemcounter = 1
function OnLoad()
	 myName = GetMyHero().charName
	 theMinions = minionManager(MINION_ALL, 20000, player, MINION_SORT_HEALTH_ASC)
	 -- SendChat("My name is "..myName)
	 if myName ~= "Ryze" then
	 	lockVal = 2
	 else
	 	lockVal = 0
	 end
end


function OnTick()
	if lockVal == 0 then
		lockVal = 1
		DoTick()
		lockVal = 0
	end
end

function DoTick()
	local time = GetGameTimer()

		
		local action = 0
		if myHero.level > currentLevel then
			currentLevel = currentLevel + 1
			LevelSpell(spellLevels[currentLevel])
		end
		if myHero.dead then
			--buy shit
			moving = 0
			
			-- if itemcounter<20 then
			-- 	for i = 1,6,1 do
			-- 		if myHero:getInventorySlot(_G["ITEM_"..i])==items[itemcounter] then
			-- 			itemcounter = itemcounter + 1
			-- 		end
			-- 	end
			-- 	if myHero.gold >= itemsCost[itemcounter] then
			-- 		BuyItem(items[itemcounter])
					
			-- 	end
			-- end
			return
		end
		if myHero.x< 1100 and myHero.z < 1100 then
		
			if ((myHero.health > myHero.maxHealth * 0.9) and (myHero.mana > myHero.maxMana * 0.9)) then
				backingFlag = 0
				if myHero.level > 10 then
					myHero:MoveTo(13000,13000)
				else
					myHero:MoveTo(6000,6000)
				end
			end
			if itemcounter<20 then
				for i = 1,7,1 do
					if myHero:getInventorySlot(_G["ITEM_"..i])==items[itemcounter] then
						itemcounter = itemcounter + 1
					end
				end
				if myHero.gold >= itemsCost[itemcounter] then
					BuyItem(items[itemcounter])
					sleep(2) -- to prevent double-buying
				end
			end
			return
		end

		--spam banner of command
		bannerSlot = GetInventorySlotItem(3060)
		seraphSlot = GetInventorySlotItem(3040)
		if (bannerSlot ~= nil and myHero:CanUseSpell(bannerSlot) == READY) then
			CastSpell(bannerSlot)
		end

		if moving == 1 then
			if myHero.x - movingX<30 and myHero.x - movingX>-30 and myHero.z -movingZ < 30 and myHero.z -movingZ > -30 then
				moving = 0
			end
			myHero:MoveTo(movingX, movingZ)
			if currentZ == myHero.z and currentX == myHero.x then
				counter = counter + 1
				if counter>30 then
					moving = 0
					myHero:HoldPosition()
					CastSpell(RECALL)
				end
						
			end
			currentZ = myHero.z
			currentX = myHero.x
				
			return
		end

		if healing == 1 then
			if time - healTime > 3.0 then
				healing = 0
			end
			return
		end
			
			
			
			--check min distance hero
			hero_i = -1
			teamCount = 1
			mindist = 9999999
			for i=1, heroManager.iCount do
				local champ = heroManager:getHero(i)
				if ValidTarget(champ, 3000) then
					if GetDistance(champ) < mindist then
						mindist = GetDistance(champ)
						hero_i = i
					end
				end
				if ((champ.team == myHero.team) and (champ ~= myHero) and (GetDistance(champ) < 1000)) then
					teamCount = teamCount + 1
				elseif ((champ.team ~= myHero.team) and (GetDistance(champ) < 1000)) then
					teamCount = teamCount - 1
				end
			end
			
			if teamCount < 0 then
				PrintFloatText(myHero, 10, "outnumbered; flee")
				myHero:HoldPosition()
				farmflag = 0
				run(myHero.x, myHero.z, 10.0)
				return
			end
			
			local farmflag = 1
			
			if ((hero_i~= -1) and (backingFlag == 0)) then
				-- do hero math
				for i=1, heroManager.iCount do
					if i == hero_i then
						enemy = heroManager:getHero(i) 
					
						-- --check enemy health
						-- if enemy.health < enemy.maxHealth * 0.10 then
						-- 	PrintFloatText(myHero, 10, "enemy low enough to all in")
						-- 	farmflag = 0
						-- 	if myHero:CanUseSpell(_Q) == READY then
						-- 		CastSpell(_Q, enemy)
						-- 	end
						-- 	if myHero:CanUseSpell(_Q) ~= READY then
						-- 		myHero:Attack(enemy)
						-- 	end
						-- 	if mindist < AttackRange then
						-- 		if myHero:CanUseSpell(_W) == READY then
						-- 			CastSpell(_W)
						-- 		end
						-- 		if myHero:CanUseSpell(SUMMONER_1) == READY then
						-- 			CastSpell(SUMMONER_1)
						-- 		end
						-- 		return
						-- 	end
						-- end
					
						if ((enemy.health / enemy.maxHealth < myHero.health/myHero.maxHealth + 0.1) and (myHero.level > 3)) then
							PrintFloatText(myHero, 10, "health diff enough to trade")
							farmflag = 0
							if myHero:CanUseSpell(_Q) == READY then
								CastSpell(_Q, enemy)
								interleaveSpell = true
							else
								if ((myHero:CanUseSpell(_W) == READY) and interleaveSpell) then
									CastSpell(_W, enemy)
									interleaveSpell = false
								elseif ((myHero:CanUseSpell(_R) == READY) and interleaveSpell) then
									CastSpell(_R)
									interleaveSpell = false
								elseif ((myHero:CanUseSpell(_E) == READY) and interleaveSpell) then
									CastSpell(_E, enemy)
									interleaveSpell = false
								-- elseif ((enemy.health < enemy.maxHealth * 0.15) and (myHero:CanUseSpell(SUMMONER_1) == READY)) then --TODO: requires AHK change at champ select
								-- 	CastSpell(SUMMONER_1, enemy)
								else 
									myHero:Attack(enemy)
								end
							end
						end
						break
					end
				end
			end
			--[[
					--stay away from turret
			for name, tow in pairs(GetTurrets()) do
				if tow.team ~= myHero.team then
					if GetDistance(tow)<1050 and mindist < 3000 then
						myHero:HoldPosition()
						run(myHero.x, myHero.z,3.0)
						return
					end
				end
			end
			]]
			--stay away from turret
			local tank_minion_dist = 1000
			local tank_flag = 0
			for name, tow in pairs(GetTurrets()) do
				if tow.team ~= myHero.team then
					if GetDistance(tow)<1000 and mindist < 1300 then
						PrintFloatText(myHero, 10, "champ nearby; flee from "..name)
						myHero:HoldPosition()
						farmflag = 0
						run(myHero.x, myHero.z,3.0)
						return
					end
				end
				if tow.team ~= myHero.team then
					if GetDistance(tow) < 1000 then
						theMinions:update()
						for i,minionObject in ipairs(theMinions.objects) do
		           			if minionObject.team ==  player.team then
								if (GetDistance(minionObject) < tank_minion_dist) and (minionObject.x > myHero.x) and (minionObject.z > myHero.z) then
									PrintFloatText(myHero, 10, "found tank minion")
									tank_flag = 1
								end
							end
						end
						if tank_flag == 1 then
							farmflag = 1
							--myHero:attack(tow)
							-- if GetDistance(tow) > autoRange then
							-- 	myHero:MoveTo(tow.x,tow.z)
							-- 	myHero:HoldPosition()
							-- 	return
							-- end
						else
							PrintFloatText(myHero, 10, "flee from "..name)
							myHero:HoldPosition()
							farmflag = 0
							run(myHero.x, myHero.z,3.0)
							return
						end

					end
				end
			end

			if myHero.health < myHero.maxHealth * 0.3 then
				farmflag = 0
			end

			local min_minion_dist = 20000
			local min_minion
			if ((farmflag == 1) and (backingFlag == 0)) then
				PrintFloatText(myHero, 10, "farming")
				theMinions:update()
				for i,minionObject in ipairs(theMinions.objects) do
					if minionObject.team ~=  player.team then
						if ((GetDistance(minionObject) < min_minion_dist) and minionObject.canMove) then --check canMove to avoid trying to attack nid traps
							if ((myHero.maxMana > 1800) or (minionObject.team ~= TEAM_NEUTRAL)) then --farm jungle late game and farm enemy minions always
								min_minion_dist = GetDistance(minionObject)
								min_minion = minionObject
							end
						end
					end
				end
				if min_minion_dist < 20000 then
					if myHero:CanUseSpell(_Q) == READY then
						CastSpell(_Q, min_minion)
						interleaveSpell = true
					elseif myHero.mana > 110 then
						if ((myHero:CanUseSpell(_R) == READY) and interleaveSpell) then
							CastSpell(_R)
							interleaveSpell = false
						elseif ((myHero:CanUseSpell(_E) == READY) and interleaveSpell) then
							CastSpell(_E, min_minion)
							interleaveSpell = false
						elseif ((myHero:CanUseSpell(_W) == READY) and interleaveSpell) then
							CastSpell(_W, min_minion)
							interleaveSpell = false
						end
					end
					myHero:Attack(min_minion)
					PrintFloatText(myHero, 10, "attacking "..min_minion.type)
				end
			end
			
			--check self health
			if ((myHero.health < myHero.maxHealth * 0.3) or (myHero.mana < 100) or (backingFlag == 1)) then
				PrintFloatText(myHero, 10, "less than 30% health, fleeing")
				farmflag = 0
				if mindist < AttackRange then
					myHero:HoldPosition()
					if ((mindist < QRange) and (myHero:CanUseSpell(_W) == READY)) then
						CastSpell(_W, enemy)
					end
					run(myHero.x, myHero.z,15.0)
					if myHero.health < myHero.maxHealth * 0.3 then
						if myHero:CanUseSpell(SUMMONER_1) == READY then
							CastSpell(SUMMONER_1)
						end
						if myHero:CanUseSpell(SUMMONER_2) == READY then --TODO: need to remove this if i add ignite
							CastSpell(SUMMONER_2)
						end
						if (seraphSlot ~= nil and myHero:CanUseSpell(seraphSlot) == READY) then
							CastSpell(seraphSlot)
						end
						if myHero:CanUseSpell(_R) == READY then
							CastSpell(_R)
						end
					end
				end
				local min_minion_dist = 20000
				local min_minion
				theMinions:update()
				for i,minionObject in ipairs(theMinions.objects) do
           			if minionObject.team ~=  player.team then
						if GetDistance(minionObject) < min_minion_dist then
							min_minion_dist = GetDistance(minionObject)
							min_minion = minionObject
						end
					end
				end
				if mindist >= AttackRange and min_minion_dist >= AttackRange then
					backingFlag = 1
					CastSpell(RECALL)
				else
					backingFlag = 1
					myHero:HoldPosition()
					run(myHero.x, myHero.z,10.0)
				end
				return
			end

end

--running function
function run(x, z, d)

	local difx = 0
	local difz = 0
	local loc = 0
	loc =	(x/100) * (x/100) + (z/100) * (z/100)

		difx = x/math.sqrt(loc)*d
		difz = z/math.sqrt(loc)*d

	--PrintChat("difx"..difx)
	--PrintChat("difz"..difz)
	movingX = myHero.x - difx
	movingZ = myHero.z - difz
	myHero:MoveTo(movingX, movingZ)
	moving = 1
	counter = 0
	currentX = x
	currentZ = z
	return
end

function OnDraw()
  if not myHero.dead then -- Again we check if Yi is not dead.
    DrawCircle(myHero.x, myHero.y, myHero.z, QRange, 0xFF80FF00) -- A circle to show his Q range.
  end
end

function OnWndMsg(msg,wParam) -- This function is needed so that you can interact with the men
	if msg == KEY_DOWN and wParam == 0x70 then
		myHero:MoveTo(10000,10000)
	end
	if msg == KEY_DOWN and wParam == 0x72 then
		myHero:MoveTo(100,100)
	end
	if msg == KEY_DOWN and wParam == 0x71 then
		print = 0
	end
	if msg == KEY_DOWN and wParam == 0x73 then
		print = 1
	end
end

function sleep(n) -- n = 1 is almost instant; n = 2 is about a second
  if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
end