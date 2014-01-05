local QRange = 625
local AttackRange = 1000
local towers = {}
local tTower
local moving = 0
local movingX = 0
local movingZ = 0
local healing = 0
local print = 0
local potioning = 0
local potionTime = 0
local currentX = 0
local currentZ = 0
local counter = 0
local healTime = 0
local boughtflag = 0
local theMinions
local items =     {1001,2003,2003,1051,2003,3093,1036,2003,1053,3009,1037,1011,3086,3046,3022,3087,3153,3083}
local itemsCost = {325 ,35  ,35  ,400 ,35  ,400 ,400 ,35  ,400 ,675 ,875 ,1000,1175,1625,1425,1700,2400,2830}
--3096
local spellLevels = {_Q,_W,_Q,_W,_E,_R,_Q,_Q,_Q,_W,_R,_W,_W,_E,_E,_R,_E,_E}
local currentLevel = 0
local itemcounter = 1
function OnLoad()
	 myName = GetMyHero().name
	 theMinions = minionManager(MINION_ALL, 2000, player, MINION_SORT_HEALTH_ASC)
	 --SendChat("My name is "..myName)
	 
end
function OnTick()
	local time = GetGameTimer()

		
		local action = 0
		if myHero.level > currentLevel then
			currentLevel = currentLevel + 1
			LevelSpell(spellLevels[currentLevel])
		end
		if myHero.dead then
			--buy shit
			moving = 0
			
			if itemcounter<19 and boughtflag == 0 then
				for i = 1,6,1 do
					if myHero:getInventorySlot(_G["ITEM_"..i])==items[itemcounter] then
						itemcounter = itemcounter + 1
					end
				end
				if myHero.gold > itemsCost[itemcounter] then
					BuyItem(items[itemcounter])
					boughtflag = 1
					
				end
			end
			return
		end
		if myHero.x< 1100 and myHero.z < 1100 then
		
			if myHero.health > myHero.maxHealth * 0.9 then
				myHero:MoveTo(7000,7000)
				boughtflag = 0
			end
			if itemcounter<19  and boughtflag == 0 then
				for i = 1,6,1 do
					if myHero:getInventorySlot(_G["ITEM_"..i])==items[itemcounter] then
						itemcounter = itemcounter + 1
					end
				end
				if myHero.gold > itemsCost[itemcounter] then
					BuyItem(items[itemcounter])
					boughtflag = 1
				end
			end
			return
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
			if time - healTime > 2.0 then
				healing = 0
			end
			return
		end
			
			local mindistTow = 99999
			for name, tow in pairs(GetTurrets()) do
				if tow.team ~= myHero.team then
					if GetDistance(tow)<mindistTow then
						mindistTow = GetDistance(tow)
					end
				end
			end
			
			--check min distance hero
			hero_i = -1
			mindist = 9999999
			local Nenemies = 0
			local tflag = 1
			for i=1, heroManager.iCount do
				local enemy = heroManager:getHero(i)
				if ValidTarget(enemy, 3000) then
					if GetDistance(enemy) < mindist then
						mindist = GetDistance(enemy)
						hero_i = i
						if enemy.health > myHero.health and mindist<AttackRange then
							Nenemies = Nenemies + 1
						end
					end
				end
			end
			
			if Nenemies > 1 then
				myHero:HoldPosition()
				run(myHero.x, myHero.z,7.0)
				return
			end
			
			local farmflag = 1
			
			if hero_i~= -1 then
				-- do hero math
				for i=1, heroManager.iCount do
					if i == hero_i then
						local enemy = heroManager:getHero(i)
					
						--check enemy health
						if enemy.health < enemy.maxHealth * 0.30 then
							farmflag = 0
							if myHero:CanUseSpell(_Q) == READY then
								CastSpell(_Q, enemy)
							end
							if myHero:CanUseSpell(_Q) ~= READY then
								myHero:Attack(enemy)
							end
							if mindist < AttackRange then
								if myHero:CanUseSpell(_E) == READY then
									CastSpell(_E)
								end
								if myHero:CanUseSpell(_R) == READY then
									CastSpell(_R,enemy.x,enemy.z)
								end
								if myHero:CanUseSpell(SUMMONER_1) == READY then
									CastSpell(SUMMONER_1)
								end
								if mindist <= QRange + 50 then
									if myHero:CanUseSpell(_Q) == READY then
										SendChat("Huntin "..enemy.name)
									end
								end
								return
							end
						end
					
						if enemy.health / enemy.maxHealth < myHero.health/myHero.maxHealth + 0.3 then
							farmflag = 0
							if mindistTow < 1050 then
								farmflag = 1
								break
							end
							if myHero:CanUseSpell(_Q) == READY then
								CastSpell(_Q, enemy)
							end
							if myHero:CanUseSpell(_Q) ~= READY then
								myHero:Attack(enemy)
							end
							if mindist < QRange then
								if myHero:CanUseSpell(_E) == READY then
									CastSpell(_E)
								end
							end
						end
						break
					end
				end
			end
					--stay away from turret
			for name, tow in pairs(GetTurrets()) do
				if tow.team ~= myHero.team then
					if (GetDistance(tow)<1050 and mindist < 2000) or (GetDistance(tow)<1050 and myHero.health < myHero.maxHealth * 0.5) then
						SendChat("flee from "..name)
						myHero:HoldPosition()
						run(myHero.x, myHero.z,3.0)
						return
					end
				end
				if tow.team ~= myHero.team then
					if GetDistance(tow) < 1050 then
						farmflag = 0
						SendChat("attacking "..name)
						myHero:Attack(tow)
						return
					end
				end
			end
					--check self health
			if myHero.health < myHero.maxHealth * 0.3 then
				farmflag = 0
				if mindist < AttackRange then
					myHero:HoldPosition()
					run(myHero.x, myHero.z,15.0)
					if myHero:CanUseSpell(SUMMONER_1) == READY then
						CastSpell(SUMMONER_1)
					end
					if myHero:CanUseSpell(SUMMONER_2) == READY then
						CastSpell(SUMMONER_2)
					end
					if myHero:CanUseSpell(_E) == READY then
						CastSpell(_E)
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
					CastSpell(RECALL)
				end
				return
			end
			if potioning == 1 then
				if time - potionTime>14.0 then
					potioning = 0
				end
			end
			--potion
			if myHero.health < 0.4 * myHero.maxHealth then
				if potioning == 0 then
					for i = 1,6,1 do
						if myHero:getInventorySlot(_G["ITEM_"..i])==2003 then
							CastSpell(_G["ITEM_"..i])
							potioning = 1
							potionTime = time
						end
					end
				end
			end
			-- heal
			if myHero.health < 0.4 * myHero.maxHealth then
				if myHero:CanUseSpell(_W) == READY and moving == 0 then 
					CastSpell(_W)
					healing = 1
					healTime = time
					return
				end
			end
		 	if myHero.mana > myHero.maxMana * 0.5  and myHero.health < myHero.maxHealth * 0.6 then
				if myHero:CanUseSpell(_W) == READY and moving == 0 then 
					CastSpell(_W)
					healing = 1
					healTime = time
					return
				end
			end
			local min_minion_dist = 20000
			local min_minion
			
			if farmflag == 1 then
				theMinions:update()
				for i,minionObject in ipairs(theMinions.objects) do
           			if minionObject.team ~=  player.team then
						if GetDistance(minionObject) < min_minion_dist then
							min_minion_dist = GetDistance(minionObject)
							min_minion = minionObject
						end
					end
				end
				if min_minion_dist < 20000 then
					myHero:Attack(min_minion)
				end
				if min_minion_dist == 20000 then
					myHero:MoveTo(myHero.x + 200, myHero.z + 200)
				end
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