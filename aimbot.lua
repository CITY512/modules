local aimbot = {}

local Materials = {
	["Asphalt"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.8;
		["FrictionWeight"] = 0.3;
	};
	["Basalt"] = {
		["Elasticity"] = 0.15;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.7;
		["FrictionWeight"] = 0.3;
	};
	["Brick"] = {
		["Elasticity"] = 0.15;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.8;
		["FrictionWeight"] = 0.3;
	};
	["Cardboard"] = {
		["Elasticity"] = 0.05;
		["ElasticityWeight"] = 2;
		["Friction"] = 0.5;
		["FrictionWeight"] = 1;
	};
	["Carpet"] = {
		["Elasticity"] = 0.25;
		["ElasticityWeight"] = 2;
		["Friction"] = 0.4;
		["FrictionWeight"] = 1;
	};
	["CeramicTiles"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.51;
		["FrictionWeight"] = 1;
	};
	["ClayRoofTiles"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.51;
		["FrictionWeight"] = 1;
	};
	["Cobblestone"] = {
		["Elasticity"] = 0.17;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.5;
		["FrictionWeight"] = 1;
	};
	["Concrete"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.7;
		["FrictionWeight"] = 0.3;
	};
	["CorrodedMetal"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.7;
		["FrictionWeight"] = 1;
	};
	["CrackedLava"] = {
		["Elasticity"] = 0.15;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.65;
		["FrictionWeight"] = 1;
	};
	["DiamondPlate"] = {
		["Elasticity"] = 0.25;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.35;
		["FrictionWeight"] = 1;
	};
	["Fabric"] = {
		["Elasticity"] = 0.05;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.35;
		["FrictionWeight"] = 1;
	};
	["Foil"] = {
		["Elasticity"] = 0.25;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.4;
		["FrictionWeight"] = 1;
	};
	["Forcefield"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.25;
		["FrictionWeight"] = 1;
	};
	["Glacier"] = {
		["Elasticity"] = 0.15;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.05;
		["FrictionWeight"] = 2;
	};
	["Glass"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.25;
		["FrictionWeight"] = 1;
	};
	["Granite"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.4;
		["FrictionWeight"] = 1;
	};
	["Grass"] = {
		["Elasticity"] = 0.1;
		["ElasticityWeight"] = 1.5;
		["Friction"] = 0.4;
		["FrictionWeight"] = 1;
	};
	["Ground"] = {
		["Elasticity"] = 0.1;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.45;
		["FrictionWeight"] = 1;
	};
	["Ice"] = {
		["Elasticity"] = 0.15;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.02;
		["FrictionWeight"] = 3;
	};
	["LeafyGrass"] = {
		["Elasticity"] = 0.1;
		["ElasticityWeight"] = 2;
		["Friction"] = 0.4;
		["FrictionWeight"] = 2;
	};
	["Leather"] = {
		["Elasticity"] = 0.25;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.35;
		["FrictionWeight"] = 1;
	};
	["Limestone"] = {
		["Elasticity"] = 0.15;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.5;
		["FrictionWeight"] = 1;
	};
	["Marble"] = {
		["Elasticity"] = 0.17;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.2;
		["FrictionWeight"] = 1;
	};
	["Metal"] = {
		["Elasticity"] = 0.25;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.4;
		["FrictionWeight"] = 1;
	};
	["Mud"] = {
		["Elasticity"] = 0.07;
		["ElasticityWeight"] = 4;
		["Friction"] = 0.3;
		["FrictionWeight"] = 3;
	};
	["Neon"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.3;
		["FrictionWeight"] = 1;
	};
	["Pavement"] = {
		["Elasticity"] = 0.17;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.5;
		["FrictionWeight"] = 0.3;
	};
	["Pebble"] = {
		["Elasticity"] = 0.17;
		["ElasticityWeight"] = 1.5;
		["Friction"] = 0.4;
		["FrictionWeight"] = 1;
	};
	["Plaster"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.6;
		["FrictionWeight"] = 0.3;
	};
	["Plastic"] = {
		["Elasticity"] = 0.5;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.3;
		["FrictionWeight"] = 1;
	};
	["Rock"] = {
		["Elasticity"] = 0.17;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.5;
		["FrictionWeight"] = 1;
	};
	["RoofShingles"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.8;
		["FrictionWeight"] = 0.3;
	};
	["Rubber"] = {
		["Elasticity"] = 0.95;
		["ElasticityWeight"] = 2;
		["Friction"] = 1.5;
		["FrictionWeight"] = 3;
	};
	["Sand"] = {
		["Elasticity"] = 0.05;
		["ElasticityWeight"] = 2.5;
		["Friction"] = 0.5;
		["FrictionWeight"] = 5;
	};
	["Sandstone"] = {
		["Elasticity"] = 0.15;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.5;
		["FrictionWeight"] = 5;
	};
	["Salt"] = {
		["Elasticity"] = 0.05;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.5;
		["FrictionWeight"] = 1;
	};
	["SmoothPlastic"] = {
		["Elasticity"] = 0.5;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.2;
		["FrictionWeight"] = 1;
	};
	["Snow"] = {
		["Elasticity"] = 0.03;
		["ElasticityWeight"] = 4;
		["Friction"] = 0.3;
		["FrictionWeight"] = 3;
	};
	["Slate"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.4;
		["FrictionWeight"] = 1;
	};
	["Water"] = {
		["Elasticity"] = 0.01;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.005;
		["FrictionWeight"] = 1;
	};
	["Wood"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.48;
		["FrictionWeight"] = 1;
	};
	["WoodPlanks"] = {
		["Elasticity"] = 0.2;
		["ElasticityWeight"] = 1;
		["Friction"] = 0.48;
		["FrictionWeight"] = 1;
	};
}

function aimbot:ComputePathAsync(startpos,targetchar,projectilespeed,projectilegravity,ignorelist,predictspamjump,ping,aimheight,isagun,calculationspersecond,maxcalculations) -- Gets the Vector3Value of where to aim at
	assert(typeof(startpos),"startpos is required")
	assert(typeof(startpos) == "Vector3","startpos must be a Vector3")
	assert(typeof(targetchar),"Target character is required")

	local targethum
	local targetroot
	if targetchar.ClassName == "Model" then
		targethum = targetchar:FindFirstChildOfClass("Humanoid")
		targetroot = targetchar:FindFirstChild("HumanoidRootPart")
		if not targethum or not targetroot then
			error("Target character must contain a humanoid and a humanoidrootpart")
		end
		if not targetroot:IsA("BasePart") then
			error("HumanoidRootPart must be a basepart")
		end
	else
		error("Target character must be a character model")
	end

	assert(typeof(projectilespeed),"Projectile Speed is required")
	assert(typeof(projectilespeed) == "number","Projectile Speed must be a number (studs/s)")
	assert(typeof(projectilegravity),"Projectile Gravity is required")
	assert(typeof(projectilegravity) == "number","Projectile Gravity must be a number (studs/s²)")

	local ignorelist = ignorelist or {}
	local predictspamjump = predictspamjump or false
	local ping = ping or 50
	local aimheight = aimheight or 0
	local isagun = isagun or false
	local calculationspersecond = calculationspersecond or 80
	local maxcalculations = maxcalculations or 30*calculationspersecond

	assert(typeof(ignorelist) == "table","IgnoreList must be a table")

	for _, i in pairs(ignorelist) do
		assert(typeof(i) == "Instance","Ignored instances must be Instances")
	end

	assert(typeof(predictspamjump) == "boolean","predictspamjump must be a boolean")
	assert(typeof(ping) == "number","ping must be a number (ms)")
	assert(typeof(aimheight) == "number","aimheight must be a number (studs)")
	assert(typeof(isagun) == "boolean","IsAGun must be a boolean")
	assert(typeof(calculationspersecond) == "number","Calcuations Per Second must be a number")
	assert(typeof(maxcalculations) == "number","Maximum Calculations must be a number")

	local lplr = game.Players.LocalPlayer

	local v = projectilespeed
	local pg = projectilegravity
	local path = {}
	local tpos = targetroot.Position
	local tvel = targetroot.Velocity
	local movedir = targethum.MoveDirection
	local ws = targethum.WalkSpeed
	local jp = targethum.JumpPower
	local pointpos = tpos
	local pointvel = tvel
	local g = workspace.Gravity
	local t = 0
	local x
	local y
	local projduration = 0
	local launchangle = 0
	local dt = calculationspersecond
	local floorhitprevpos
	local ceilinghitprevpos
	local pointprevpos
	local pointprevvel
	local prevprojduration
	local floormaterial
	local friction = 143

	local ceilinghit = Instance.new("Part", workspace)
	ceilinghit.Anchored = true
	ceilinghit.CFrame = CFrame.new(tpos + Vector3.new(0,1.5,0)) * CFrame.Angles(0,math.rad(targetroot.Orientation.Y),0)
	ceilinghit.Size = Vector3.new(2,1,1)

	local wallhit = Instance.new("Part", workspace)
	wallhit.Anchored = true
	wallhit.CFrame = CFrame.new(tpos) * CFrame.Angles(0,math.rad(targetroot.Orientation.Y),0)
	wallhit.Size = Vector3.new(4, 2, 1)

	local floorhit = Instance.new("Part", workspace)
	floorhit.Anchored = true
	floorhit.CFrame = CFrame.new(tpos + Vector3.new(0,-2,0)) * CFrame.Angles(0,math.rad(targetroot.Orientation.Y),0)
	floorhit.Size = Vector3.new(2,2.002,1)

	local function tableconcat(t1,t2)
		for i = 1,#t2 do
			t1[#t1+1] = t2[i]
		end
		return t1
	end
	local function CheckTouchingParts(tab,ignoredescendantsinstances)
		local touchingparts = {}
		local function CheckInsideIgnoreList(obj)
			local inside = false
			for _, v in pairs(ignoredescendantsinstances) do
				if obj:IsDescendantOf(v) then
					inside = true
				end
			end
			return inside
		end
		for _, v in pairs(tab) do
			if not table.find(ignoredescendantsinstances,v) and not CheckInsideIgnoreList(v) then
				table.insert(touchingparts,v)
			end
		end
		return touchingparts
	end

	local ignorelist = tableconcat({targetchar,ceilinghit,wallhit,floorhit},ignorelist)
	if lplr and lplr.Character then
		table.insert(ignorelist,lplr.Character)
	end
	while true do
		pointpos += Vector3.new(0,aimheight,0)

		x = (Vector2.new(pointpos.X,pointpos.Z) - Vector2.new(startpos.X,startpos.Z)).Magnitude
		y = pointpos.Y - startpos.Y
		if isagun then
			launchangle = math.atan(y/x)
			projduration = ping / 1000
		else
			launchangle = math.atan(y/x)
			if pg ~= 0 then
				launchangle = math.atan((v^2 - math.sqrt(v^4 - pg*(pg*x^2 + 2*y*v^2))) / (pg*x))
			end
			projduration = x / math.cos(launchangle) / v + ping / 1000
		end
		if t >= projduration or t*dt >= maxcalculations or pointpos.Y <= workspace.FallenPartsDestroyHeight then break end

		pointpos -= Vector3.new(0,aimheight,0)

		floorhitprevpos = floorhit.Position
		ceilinghitprevpos = ceilinghit.Position

		pointprevvel = pointvel
		pointprevpos = pointpos
		prevprojduration = projduration

		pointvel -= Vector3.new(0,g/dt,0)
		pointpos += Vector3.new(pointvel.X*(1/dt) + friction*movedir.X*(1/dt)^2/2,pointvel.Y*(1/dt) + -g*(1/dt)^2/2,pointvel.Z*(1/dt) + friction*movedir.Z*(1/dt)^2/2) -- y = vΔt + ½at²

		ceilinghit.CFrame = CFrame.new(pointpos + Vector3.new(0,1.5,0)) * CFrame.Angles(0,math.rad(targetroot.Orientation.Y),0)
		wallhit.CFrame = CFrame.new(pointpos) * CFrame.Angles(0,math.rad(targetroot.Orientation.Y),0)
		floorhit.CFrame = CFrame.new(pointpos + Vector3.new(0,-2,0)) * CFrame.Angles(0,math.rad(targetroot.Orientation.Y),0)

		local floortp = floorhit:GetTouchingParts()
		local walltp = wallhit:GetTouchingParts()
		local ceilingtp = ceilinghit:GetTouchingParts()

		local floorhitchecktp = CheckTouchingParts(floortp,ignorelist)
		local ceilinghitchecktp = CheckTouchingParts(floortp,ignorelist)

		local params = RaycastParams.new()
		params.FilterDescendantsInstances = ignorelist
		params.FilterType = Enum.RaycastFilterType.Exclude

		local checkfallingthroughray = workspace:Raycast(pointprevpos - Vector3.new(0,3,0),(pointpos - Vector3.new(0,3,0)) - (pointprevpos - Vector3.new(0,3,0)),params)
		local checkceilinghitray = workspace:Raycast(pointprevpos + Vector3.new(0,2,0),(pointpos + Vector3.new(0,2,0)) - (pointprevpos + Vector3.new(0,2,0)),params)
		if checkfallingthroughray and checkfallingthroughray.Position and checkfallingthroughray.Instance then
			floormaterial = checkfallingthroughray.Instance.Material
			if floormaterial then
				friction = 750
			end

			pointpos = Vector3.new(pointpos.X,checkfallingthroughray.Position.Y + 3,pointpos.Z)
			pointvel *= Vector3.new(1,0,1)

			local y = pointpos.Y - pointprevpos.Y
			local py = pointprevvel.Y
			local tm = (-py - math.sqrt(2*g*y + py^2)) / g -- t = (-u ± √(2ay + u²)) ÷ a

			if predictspamjump and targethum.Jump then
				pointvel += Vector3.new(0,jp,0)
				pointpos += Vector3.new(0,pointvel.Y*(1/(dt - tm)) + -g*(1/(dt - tm))^2/2,0)
				pointvel -= Vector3.new(0,g*(dt - tm),0)
			end
		elseif #floorhitchecktp > 0 then
			local highest
			for _, v in pairs(floorhitchecktp) do
				if not table.find(walltp,v) then
					if not highest or v.Position.Y > highest[2] then
						highest = {v,v.Position.Y}
					end
				end
			end
			if highest and highest[1] then
				floormaterial = highest[1].Material
				if floormaterial then
					friction = 750
				end

				local goalx = movedir.X * ws
				local goalz = movedir.Z * ws

				if pointvel.X > goalx then
					pointvel -= Vector3.new(friction / dt * math.abs(movedir.X),0,0)
					if pointvel.X < goalx then
						pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
					end
				elseif pointvel.X < goalx then
					pointvel += Vector3.new(friction / dt * math.abs(movedir.X),0,0)
					if pointvel.X > goalx then
						pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
					end
				else
					pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
				end
				if pointvel.Z > goalz then
					pointvel -= Vector3.new(0,0,friction / dt * math.abs(movedir.Z))
					if pointvel.Z < goalz then
						pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
					end
				elseif pointvel.Z < goalz then
					pointvel += Vector3.new(0,0,friction / dt * math.abs(movedir.Z))
					if pointvel.Z > goalz then
						pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
					end
				else
					pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
				end

				local interceptpoint = pointpos * Vector3.new(1,0,1) + (highest[1].Position * Vector3.new(0,1,0) + Vector3.new(0,highest[1].Size.Y/2,0))
				pointpos = interceptpoint + Vector3.new(0,3,0)
				pointvel *= Vector3.new(1,0,1)

				local y = pointpos.Y - pointprevpos.Y
				local py = pointprevvel.Y
				local tm = (-py - math.sqrt(2*g*y + py^2)) / g

				if predictspamjump and targethum.Jump then
					pointvel += Vector3.new(0,jp,0)
					pointpos += Vector3.new(0,pointvel.Y*(1/(dt - tm)) + -g*(1/(dt - tm))^2/2,0)
					pointvel -= Vector3.new(0,g*(dt - tm),0)
				end
			end
		elseif checkceilinghitray and checkceilinghitray.Position then
			pointpos = Vector3.new(pointpos.X,checkceilinghitray.Position.Y - 3,pointpos.Z)
			pointvel = Vector3.new(pointvel.X,-math.abs(pointvel.Y),pointvel.Z)
		elseif #ceilinghitchecktp > 0 then
			local lowest
			for _, v in pairs(floorhitchecktp) do
				if not table.find(walltp,v) then
					if not lowest or v < lowest[2] then
						lowest = {v,v.Position.Y}
					end
				end
			end
			if lowest and lowest[1] then
				pointpos = pointpos * Vector3.new(1,0,1) + (lowest[1].Position * Vector3.new(0,1,0) + Vector3.new(0,-lowest[1].Size.Y/2 - 3,0))
				pointvel = Vector3.new(pointvel.X,-math.abs(pointvel.Y),pointvel.Z)
			end
		else
			friction = 143

			local goalx = movedir.X * ws
			local goalz = movedir.Z * ws

			if pointvel.X > goalx then
				pointvel -= Vector3.new(friction / dt * math.abs(movedir.X),0,0) -- 143.1926
				if pointvel.X < goalx then
					pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
				end
			elseif pointvel.X < goalx then
				pointvel += Vector3.new(friction / dt * math.abs(movedir.X),0,0)
				if pointvel.X > goalx then
					pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
				end
			else
				pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
			end
			if pointvel.Z > goalz then
				pointvel -= Vector3.new(0,0,friction / dt * math.abs(movedir.Z))
				if pointvel.Z < goalz then
					pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
				end
			elseif pointvel.Z < goalz then
				pointvel += Vector3.new(0,0,friction / dt * math.abs(movedir.Z))
				if pointvel.Z > goalz then
					pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
				end
			else
				pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
			end
		end
		t += 1/dt

		table.insert(path,pointpos)
	end

	ceilinghit:Destroy()
	wallhit:Destroy()
	floorhit:Destroy()

	pointpos += Vector3.new(0,aimheight,0)

	print(projduration)
	local aimposition = Vector3.new(pointpos.X,(x * math.tan(launchangle))+startpos.Y,pointpos.Z)
	return path, aimposition
end

return aimbot
