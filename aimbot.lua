local aimbot = {}


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

	local ps = projectilespeed
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
	repeat
		floorhitprevpos = floorhit.Position
		ceilinghitprevpos = ceilinghit.Position

		pointprevvel = pointvel
		pointprevpos = pointpos
		prevprojduration = projduration

		pointvel -= Vector3.new(0,g/dt,0)
		pointpos += Vector3.new(0,pointvel.Y*(1/dt) + -g*(1/dt)^2/2,0)

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

		local checkfallingthroughray = workspace:Raycast(pointpos * Vector3.new(1,0,1) + pointprevpos * Vector3.new(0,1,0),pointpos - (pointpos * Vector3.new(1,0,1) + pointprevpos * Vector3.new(0,1,0)),params)
		local checkceilinghitray = workspace:Raycast(pointprevpos + Vector3.new(0,2,0),(pointpos + Vector3.new(0,2,0)) - (pointprevpos + Vector3.new(0,2,0)),params)
		if checkfallingthroughray and checkfallingthroughray.Position then
			pointpos = Vector3.new(pointpos.X,checkfallingthroughray.Position.Y + 3,pointpos.Z)
			pointvel *= Vector3.new(1,0,1)

			local y = pointpos.Y - pointprevpos.Y
			local py = pointprevvel.Y
			local tm = (-py - math.sqrt(2*g*y + py^2)) / g

			if predictspamjump and targethum.Jump then
				pointvel += Vector3.new(0,jp,0)
				pointpos += Vector3.new(0,pointvel.Y*(1/(dt - tm)) + -g*(1/(dt - tm))^2/2,0)
				pointvel = Vector3.new(pointvel.X,jp - g*tm,pointvel.Z)
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
				local goalx = movedir.X * ws
				local goalz = movedir.Z * ws

				if pointvel.X > goalx then
					pointvel -= Vector3.new(750 / dt * math.abs(movedir.X),0,0)
					if pointvel.X < goalx then
						pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
						pointpos += Vector3.new(pointvel.X/dt,0,0)
					else
						pointpos += Vector3.new(pointvel.X*(1/dt) + -750*(1/dt)^2/2,0,0)
					end
				elseif pointvel.X < goalx then
					pointvel += Vector3.new(750 / dt * math.abs(movedir.X),0,0)
					if pointvel.X > goalx then
						pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
						pointpos += Vector3.new(pointvel.X/dt,0,0)
					else
						pointpos += Vector3.new(pointvel.X*(1/dt) + 750*(1/dt)^2/2,0,0)
					end
				else
					pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
					pointpos += Vector3.new(pointvel.X/dt,0,0)
				end
				if pointvel.Z > goalz then
					pointvel -= Vector3.new(0,0,750 / dt * math.abs(movedir.Z))
					if pointvel.Z < goalz then
						pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
						pointpos += Vector3.new(0,0,pointvel.Z/dt)
					else
						pointpos += Vector3.new(0,0,pointvel.Z*(1/dt) + -750*(1/dt)^2/2)
					end
				elseif pointvel.Z < goalz then
					pointvel += Vector3.new(0,0,750 / dt * math.abs(movedir.Z))
					if pointvel.Z > goalz then
						pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
						pointpos += Vector3.new(0,0,pointvel.Z/dt)
					else
						pointpos += Vector3.new(0,0,pointvel.Z*(1/dt) + 750*(1/dt)^2/2)
					end
				else
					pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
					pointpos += Vector3.new(0,0,pointvel.Z/dt)
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
					pointvel = Vector3.new(pointvel.X,jp - g*(dt - tm),pointvel.Z)
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
			local goalx = movedir.X * ws
			local goalz = movedir.Z * ws

			if pointvel.X > goalx then
				pointvel -= Vector3.new(143 / dt * math.abs(movedir.X),0,0) -- 143.1926
				if pointvel.X < goalx then
					pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
					pointpos += Vector3.new(pointvel.X/dt,0,0)
				else
					pointpos += Vector3.new(pointvel.X*(1/dt) + -143*(1/dt)^2/2,0,0)
				end
			elseif pointvel.X < goalx then
				pointvel += Vector3.new(143 / dt * math.abs(movedir.X),0,0)
				if pointvel.X > goalx then
					pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
					pointpos += Vector3.new(pointvel.X/dt,0,0)
				else
					pointpos += Vector3.new(pointvel.X*(1/dt) + 143*(1/dt)^2/2,0,0)
				end
			else
				pointvel = Vector3.new(goalx,pointvel.Y,pointvel.Z)
				pointpos += Vector3.new(pointvel.X/dt,0,0)
			end
			if pointvel.Z > goalz then
				pointvel -= Vector3.new(0,0,143 / dt * math.abs(movedir.Z))
				if pointvel.Z < goalz then
					pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
					pointpos += Vector3.new(0,0,pointvel.Z/dt)
				else
					pointpos += Vector3.new(0,0,pointvel.Z*(1/dt) + -143*(1/dt)^2/2)
				end
			elseif pointvel.Z < goalz then
				pointvel += Vector3.new(0,0,143 / dt * math.abs(movedir.Z))
				if pointvel.Z > goalz then
					pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
					pointpos += Vector3.new(0,0,pointvel.Z/dt)
				else
					pointpos += Vector3.new(0,0,pointvel.Z*(1/dt) + 143*(1/dt)^2/2)
				end
			else
				pointvel = Vector3.new(pointvel.X,pointvel.Y,goalz)
				pointpos += Vector3.new(0,0,pointvel.Z/dt)
			end
		end

		pointpos += Vector3.new(0,aimheight,0)

		x = (Vector2.new(pointpos.X,pointpos.Z) - Vector2.new(startpos.X,startpos.Z)).Magnitude
		y = pointpos.Y - startpos.Y
		if isagun then
			launchangle = math.atan(y/x)
			projduration = ping / 1000
		else
			launchangle = math.atan(y/x)
			if pg ~= 0 then
				launchangle = math.atan((ps^2 - math.sqrt(ps^4 - pg*(pg*x^2 + 2*y*ps^2))) / (pg*x))
			end
			projduration = x / math.cos(launchangle) / ps + ping / 1000
		end

		pointpos -= Vector3.new(0,aimheight,0)

		t += 1/dt

		table.insert(path,pointpos)
	until t >= projduration or t*dt >= maxcalculations or pointpos.Y <= workspace.FallenPartsDestroyHeight

	ceilinghit:Destroy()
	wallhit:Destroy()
	floorhit:Destroy()

	pointpos += Vector3.new(0,aimheight,0)

	print(projduration)
	local aimposition = Vector3.new(pointpos.X,(x * math.tan(launchangle))+startpos.Y,pointpos.Z)
	return path, aimposition
end

return aimbot
