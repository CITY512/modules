local aimbot = {}

function aimbot:ComputePathAsync(startpos,target,projectilespeed,projectilegravity,predictspamjump,IsAGun,accuracy,maxduration) -- Gets the Vector3Value of where to aim at
	assert(typeof(startpos) == "Vector3", "A Vector3 must be provided for the startpos")
	assert(typeof(target) == "Instance", "A character model must be provided for the target")
	assert(typeof(projectilespeed) == "number", "A number value must be provided for the projectile speed")
	assert(typeof(projectilegravity) == "number", "A number value must be provided for the projectile gravity")
	if not target:IsA("Model") or not target:FindFirstChildOfClass("Humanoid") or not target:FindFirstChild("HumanoidRootPart") then 
		error("Target must be a model, must have a humanoid and a HumanoidRootPart inside")
	end
	if not target.HumanoidRootPart:IsA("BasePart") then
		error("HumanoidRootPart must be a BasePart")
	end
	
	local accuracy = accuracy or 80
	local maxduration = maxduration or 60 -- Stops infinite loop bug
	local predictspamjump = predictspamjump or false
	local IsAGun = IsAGun or false
	
	assert(typeof(predictspamjump) == "boolean", "A boolean must be provided for predictspamjump")
	assert(typeof(IsAGun) == "boolean", "A boolean must be provided for IsAGun")
	assert(typeof(accuracy) == "number", "A number value must be provided for the accuracy")
	assert(typeof(maxduration) == "number", "A number value must be provided for the maxduration")
	
	local function tableconcat(t1,t2)
		for i=1,#t2 do
			t1[#t1+1] = t2[i]
		end
		return t1
	end
	local lplr = game.Players.LocalPlayer
	
	local char = lplr.Character

	local projduration = 0
	local pointduration = 0
	local pos = target.HumanoidRootPart.Position
	local a = 0
	local b = 0
	local c = 0
	local x = 0 
	local y = 0
	local xvel = target.HumanoidRootPart.Velocity.X
	local yvel = target.HumanoidRootPart.Velocity.Y
	local zvel = target.HumanoidRootPart.Velocity.Z
	local movex = target.HumanoidRootPart.Parent.Humanoid.MoveDirection.X
	local movey = target.HumanoidRootPart.Parent.Humanoid.MoveDirection.Y
	local movez = target.HumanoidRootPart.Parent.Humanoid.MoveDirection.Z
	
	local floorhit = Instance.new("Part", workspace)
	floorhit.Name = "floorhit"
	floorhit.Anchored = true
	floorhit.Size = Vector3.new(2, 0.5, 1)
	floorhit.Position = target.HumanoidRootPart.Position - Vector3.new(0,2.775,0)
	floorhit.Orientation = target.HumanoidRootPart.Orientation * Vector3.new(0,1,0)

	local ceilinghit = Instance.new("Part", workspace)
	ceilinghit.Name = "ceilinghit"
	ceilinghit.Anchored = true
	ceilinghit.Size = Vector3.new(1, 0.5, 1)
	ceilinghit.Position = target.HumanoidRootPart.Position + Vector3.new(0,1.775,0)
	ceilinghit.Orientation = target.HumanoidRootPart.Orientation * Vector3.new(0,1,0)

	local wallhit = Instance.new("Part", workspace)
	wallhit.Name = "wallhit"
	wallhit.Anchored = true
	wallhit.Size = Vector3.new(4.25, 2.25, 1)
	wallhit.Position = target.HumanoidRootPart.Position
	wallhit.Orientation = target.HumanoidRootPart.Orientation * Vector3.new(0,1,0)
	
	local path = {}
	local ignoredescendantsinstances = {target,char,floorhit,wallhit,ceilinghit} -- Blacklists parts and it's descendants

	local function checktouchingparts(tab) -- Filters out any parts/part's descendants from the ignoredescendantsinstances table
		if #tab > 0 then
			local touchingparts = {}
			for i = 1,#tab,1 do
				local aa
				for v = 1,#ignoredescendantsinstances,1 do
					if not tab[i]:FindFirstAncestor(ignoredescendantsinstances[v].Name) and tab[i] ~= ignoredescendantsinstances[v] and aa ~= false then
						aa = true
					else
						aa = false
					end
				end
				if aa then
					table.insert(touchingparts,tab[i])
				end
			end
			if #touchingparts > 0 then
				return {true,touchingparts}
			else
				return {false,{}}
			end
		else
			return {false,{}}
		end
	end
	repeat
		pointduration = pointduration + (1/accuracy)

		yvel = yvel - workspace.Gravity / accuracy

		local prevpos = pos
		pos = pos + Vector3.new(xvel/accuracy,yvel/accuracy,zvel/accuracy)

		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = ignoredescendantsinstances

		floorhit.Position = pos - Vector3.new(0,2.775,0)
		ceilinghit.Position = pos + Vector3.new(0,1.775,0)
		wallhit.Position = pos

		local floortouchingparts = floorhit:GetTouchingParts()
		local ceilingtouchingparts = ceilinghit:GetTouchingParts()
		local walltouchingparts = wallhit:GetTouchingParts()

		local checktouchingpartsfloortouchingparts = checktouchingparts(floortouchingparts)
		local checktouchingpartswalltouchingparts = checktouchingparts(walltouchingparts)

		local groundpartinterception = workspace:Raycast(prevpos,pos-prevpos,params) -- Stops it from falling through the ground

		if groundpartinterception and groundpartinterception.Position then
			if not checktouchingpartswalltouchingparts[1] then
				yvel = groundpartinterception.Position.Y - pos.Y + 3
				pos = pos + Vector3.new(0,yvel,0)
				yvel = 0
			else
				yvel = 0
			end
		elseif checktouchingpartsfloortouchingparts[1] then
			local goalx = movex * target.Humanoid.WalkSpeed
			local goalz = movez * target.Humanoid.WalkSpeed

			if xvel > goalx then
				xvel -= 132.8 / accuracy
			elseif xvel < goalx then
				xvel += 132.8 / accuracy
			else
				xvel = goalx
			end
			if zvel > goalz then
				zvel -= 132.8 / accuracy
			elseif zvel < goalz then
				zvel += 132.8 / accuracy
			else
				zvel = goalz
			end

			if not checktouchingpartswalltouchingparts[1] then
				local highest
				local sort = {}
				if #checktouchingpartsfloortouchingparts > 0 then
					for i = 1,#checktouchingpartsfloortouchingparts[2],1 do
						table.insert(sort,{checktouchingpartsfloortouchingparts[2][i],checktouchingpartsfloortouchingparts[2][i].Position.Y})
					end
					table.sort(sort,
						function(a,b)
							return a[2] > b[2]
						end
					)
				end
				highest = sort[1][1]
				if highest and sort then
					if highest:IsA("Part") and highest.Shape == Enum.PartType.Block or highest:IsA("MeshPart") and highest.MeshId == "" then
						yvel = highest.Position.Y + highest.Size.Y/2 - pos.Y + 3
						pos = pos + Vector3.new(0,yvel,0)
						yvel = 0
					else
						local raycastfloorhit = workspace:Raycast(pos,Vector3.new(0,-3,0),params)
						if raycastfloorhit and raycastfloorhit.Position then
							yvel = raycastfloorhit.Position.Y - pos.Y + 3
							pos = pos + Vector3.new(0,yvel,0)
							yvel = 0
						end
					end
					if target.Humanoid.Jump and predictspamjump then -- if the player continuously punches their space key
						yvel = target.Humanoid.JumpPower
						pos = pos + Vector3.new(0,yvel/accuracy,0) 
					end
				end
			else
				yvel = 0
			end
		end
		if checktouchingparts(ceilingtouchingparts)[1] then -- If the player hits the ceiling
			yvel = math.abs(yvel) / -1
		else -- else if the player is in the air
			local goalx = movex * target.Humanoid.WalkSpeed
			local goalz = movez * target.Humanoid.WalkSpeed

			if xvel > goalx then
				xvel -= 132.8 / accuracy
			elseif xvel < goalx then
				xvel += 132.8 / accuracy
			else
				xvel = goalx
			end
			if zvel > goalz then
				zvel -= 132.8 / accuracy
			elseif zvel < goalz then
				zvel += 132.8 / accuracy
			else
				zvel = goalz
			end
		end
		local plr1 = startpos
		local plr2 = pos

		x = (Vector2.new(plr2.X,plr2.Z)-Vector2.new(plr1.X,plr1.Z)).Magnitude
		y = plr2.Y-plr1.Y
		local g = projectilegravity
		local v = projectilespeed
		if g == 0 then
			c = math.atan(y/x)
		else
			c = math.atan( ((v^2) - math.sqrt( (v^4) - (g * ( (g*(x^2)) + (2*(y*(v^2))) )) )) / (g*x) )
		end
		local prevprojduration = projduration
		if IsAGun then
			projduration = game.Players.LocalPlayer:GetNetworkPing()
		else
			projduration = ((x / math.cos(c)) / v) + game.Players.LocalPlayer:GetNetworkPing()
		end
		table.insert(path,pos)
	until pointduration > projduration or pointduration > maxduration or pos.Y < workspace.FallenPartsDestroyHeight -- Checks if the projectile reaches their future position or if the player falls below the void
	floorhit:Destroy()
	ceilinghit:Destroy()
	wallhit:Destroy()

	--[[
	local charclone = targetroot.Parent:Clone()
	charclone.Parent = nodesfolder
	charclone:SetPrimaryPartCFrame(CFrame.new(pos))
	
	for _, i in pairs(charclone:GetChildren()) do
		if i:IsA("BasePart") and i.Name ~= "HumanoidRootPart" then
			i.Transparency = 0.75
			i.BrickColor = BrickColor.new("Medium stone grey")
			i.Anchored = true
			for _, v in pairs(i:GetChildren()) do
				v:Destroy()
			end
		else
			i:Destroy()
		end
	end
	]]
	local aimposition = Vector3.new(pos.X,(x * math.tan(c))+char.HumanoidRootPart.Position.Y,pos.Z)
	return path,aimposition
end
return aimbot
