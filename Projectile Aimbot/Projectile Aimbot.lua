local module = {}
function module:Compute(startPosition,targetCharacter,projectileSpeed,projectileGravity,argumentTable)
	local LocalPlayer
	if game.Players.LocalPlayer then
		LocalPlayer = game.Players.LocalPlayer
	end
	assert(startPosition,"startpos is required")
	assert(typeof(startPosition) == "Vector3","startpos must be a Vector3")
	assert(targetCharacter,"Target character is required")
	assert(typeof(targetCharacter) == "Instance","Target character must be a Model")
	local targetHum
	local targetRoot
	if targetCharacter.ClassName == "Model" then
		targetHum = targetCharacter:FindFirstChildOfClass("Humanoid")
		targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")

		if not targetHum or not targetRoot then
			error("Target character must contain a humanoid and a humanoidrootpart")
		end
		if not targetRoot:IsA("BasePart") then
			error("HumanoidRootPart must be a basepart")
		end
	else
		error("Target character must be a character model")
	end
	assert(projectileSpeed,"Projectile Speed is required")
	assert(typeof(projectileSpeed) == "number","Projectile Speed must be a number (studs/s)")
	assert(projectileGravity,"Projectile Gravity is required")
	assert(typeof(projectileGravity) == "number","Projectile Gravity must be a number (studs/s²)")
	local playerWalkSpeed = argumentTable.WalkSpeed or targetHum.WalkSpeed
	local playerJumpPower = argumentTable.JumpPower or targetHum.JumpPower
	local predictJump = argumentTable.PredictJump or false
	local alwaysJumping = argumentTable.AlwaysJumping or false
	local predictLag = argumentTable.PredictLag == nil and true or argumentTable.PredictLag
	local gravity = argumentTable.Gravity or workspace.Gravity
	local ping = argumentTable.Ping or 50
	local aimHeight = argumentTable.AimHeight or 0
	local isAGun = argumentTable.IsAGun or false
	local ignoreList = argumentTable.IgnoreList or {}
	for _, v in pairs(ignoreList) do
		assert(typeof(v) == "Instance","Ignore list elements must be Instances")
	end
	local interval = argumentTable.Interval or 1/80
	local maxSimulationTime = argumentTable.MaxSimulationTime or 60
	local respectCanCollide = argumentTable.RespectCanCollide == nil and true or argumentTable.RespectCanCollide
	assert(interval > 0,"INTERVAlS CANNOT NOT BE 0 NOR NEGATIVE")
	assert(ping >= 0,"PING CANNOT BE NEGATIVE")
	assert(typeof(ignoreList) == "table","IgnoreList must be a table")
	assert(typeof(playerWalkSpeed) == "number","WalkSpeed must be a number (studs/s)")
	assert(typeof(playerJumpPower) == "number","JumpPower must be a number (studs/s)")
	assert(typeof(predictJump) == "boolean","Predict Jump must be a boolean")
	assert(typeof(alwaysJumping) == "boolean","Always Jumping must be a boolean")
	assert(typeof(gravity) == "number","Gravity must be a number (studs/s²)")
	assert(typeof(predictLag) == "boolean","PredictLag must be a boolean")
	assert(typeof(respectCanCollide) == "boolean","IgnoreCanCollide must be a boolean")
	assert(typeof(ping) == "number","Ping must be a number (ms)")
	assert(typeof(aimHeight) == "number","Aim Height must be a number (studs)")
	assert(typeof(isAGun) == "boolean","IsAGun must be a boolean")
	assert(typeof(interval) == "number","Interval must be a number")
	assert(typeof(maxSimulationTime) == "number","Maximum Calculations must be a number")
	local startTick = tick()
	local originalInterval = interval
	local simulatedPos = targetRoot.Position
	local simulatedVel = targetRoot.Velocity
	local simulationIgnoreList = {}
	local simulatedTime = 0
	local frictionDeceleration = 750
	local path = {}
	local moveDirection = targetHum.MoveDirection
	local walkToPoint = targetHum.WalkToPoint
	local prevSimulatedPos
	local pg = projectileGravity
	local v = projectileSpeed
	local launchAngle
	local travelTime
	local x
	local y
	local floorHit = Instance.new("Part", workspace)
	floorHit.Name = "floorHit"
	floorHit.Size = Vector3.new(2,2,1)
	floorHit.CFrame = CFrame.new(targetRoot.Position - Vector3.new(0,2,0)) * CFrame.Angles(0,math.rad(targetRoot.Orientation.Y),0)
	floorHit.Anchored = true
	local wallHit = Instance.new("Part", workspace)
	wallHit.Name = "wallHit"
	wallHit.Size = Vector3.new(2,2,1)
	wallHit.CFrame = CFrame.new(targetRoot.Position) * CFrame.Angles(0,math.rad(targetRoot.Orientation.Y),0)
	wallHit.Anchored = true
	local ceilHit = Instance.new("Part", workspace)
	ceilHit.Name = "ceilHit"
	ceilHit.Size = Vector3.new(2,1,1)
	ceilHit.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0,1.5,0)) * CFrame.Angles(0,math.rad(targetRoot.Orientation.Y),0)
	ceilHit.Anchored = true
	local function tableConcat(t1,t2)
		for i = 1, #t2, 1 do
			table.insert(t1,t2[i])
		end
		return t1
	end
	local function checkTouchingParts(tab,ignoreDescendantsInstances)
		local touchingParts = {}
		local touchingTrussLadder = false
		local function checkInsideIgnoreList(obj)
			for _, v in pairs(ignoreDescendantsInstances) do
				if obj:IsDescendantOf(v) then
					return true
				end
			end
			return false
		end
		for _, v in pairs(tab) do
			if not table.find(ignoreDescendantsInstances,v) and v ~= floorHit and v ~= wallHit and v ~= ceilHit and not v:IsDescendantOf(targetCharacter) and (not LocalPlayer.Character or not v:IsDescendantOf(LocalPlayer.Character)) and not checkInsideIgnoreList(v) and (not respectCanCollide or v.CanCollide) then
				table.insert(touchingParts,v)
				if v.ClassName == "TrussPart" then
					touchingTrussLadder = true
				end
			end
		end
		return touchingParts, touchingTrussLadder
	end
	local function updateIndicatorPosition()
		floorHit.Position = simulatedPos - Vector3.new(0,2,0)
		wallHit.Position = simulatedPos
		ceilHit.Position = simulatedPos + Vector3.new(0,1.5,0)
	end
	local function checkOrientation(basePart)
		return (math.abs(basePart.Orientation.X) == 0 or math.abs(basePart.Orientation.X) == 180) and (math.abs(basePart.Orientation.Z) == 0 or math.abs(basePart.Orientation.Z) == 180)
	end
	local function simulationStep()
		simulatedPos += Vector3.new(
			simulatedVel.X*interval + frictionDeceleration*moveDirection.X*interval^2/2,
			simulatedVel.Y*interval + -gravity*interval^2/2,
			simulatedVel.Z*interval + frictionDeceleration*moveDirection.Z*interval^2/2
		)
		local function calculateMoveDirection(axis)
			if axis == "X" then
				local xdir = moveDirection.X
				if moveDirection.X == 0 then
					local newmovedirx = simulatedVel.Unit.X
					if newmovedirx == newmovedirx then
						xdir = newmovedirx
					else
						xdir = 1
					end
				end
				return xdir
			elseif axis == "Z" then
				local zdir = moveDirection.Z
				if moveDirection.Z == 0 then
					local newmovedirz = simulatedVel.Unit.Z
					if newmovedirz == newmovedirz then
						zdir = newmovedirz
					else
						zdir = 1
					end
				end
				return zdir
			end
		end
		local function calculateVelocityOnAxis(axis)
			local goal
			if axis == "X" then
				goal = moveDirection.X * playerWalkSpeed
			elseif axis == "Z" then
				goal = moveDirection.Z * playerWalkSpeed
			end
			if simulatedVel[axis] > goal then
				if axis == "X" then
					simulatedVel -= Vector3.new(frictionDeceleration * math.abs(calculateMoveDirection("X")) * interval,0,0)
				elseif axis == "Z" then
					simulatedVel -= Vector3.new(0,0,frictionDeceleration * math.abs(calculateMoveDirection("Z")) * interval)
				end
				if simulatedVel[axis] < goal then
					if axis == "X" then
						simulatedVel = Vector3.new(goal,simulatedVel.Y,simulatedVel.Z)
					elseif axis == "Z" then
						simulatedVel = Vector3.new(simulatedVel.X,simulatedVel.Y,goal)
					end
				end
			elseif simulatedVel[axis] < goal then
				if axis == "X" then
					simulatedVel += Vector3.new(frictionDeceleration * math.abs(calculateMoveDirection("X")) * interval,0,0)
				elseif axis == "Z" then
					simulatedVel += Vector3.new(0,0,frictionDeceleration * math.abs(calculateMoveDirection("Z")) * interval)
				end
				if simulatedVel[axis] > goal then
					if axis == "X" then
						simulatedVel = Vector3.new(goal,simulatedVel.Y,simulatedVel.Z)
					elseif axis == "Z" then
						simulatedVel = Vector3.new(simulatedVel.X,simulatedVel.Y,goal)
					end
				end
			else
				if axis == "X" then
					simulatedVel = Vector3.new(goal,simulatedVel.Y,simulatedVel.Z)
				elseif axis == "Z" then
					simulatedVel = Vector3.new(simulatedVel.X,simulatedVel.Y,goal)
				end
			end
		end
		calculateVelocityOnAxis("X")
		calculateVelocityOnAxis("Z")
	end
	local function checkHighestLowest(obj,typ)
		local dirY
		if typ == 1 then
			dirY = -2
		elseif typ == 2 then
			dirY = 1
		end
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = {obj}
		params.FilterType = Enum.RaycastFilterType.Include
		local blockcast = workspace:Blockcast(CFrame.new(Vector3.new(simulatedPos.X,simulatedPos.Y + dirY / math.abs(dirY),simulatedPos.Z)) * CFrame.Angles(0,math.rad(targetRoot.Orientation.Y),0),Vector3.new(2, 0.002, 1),Vector3.new(0,dirY,0),params)
		if blockcast and blockcast.Position then
			return blockcast.Position.Y
		end
	end
	if moveDirection == Vector3.new(0,0,0) then
		if walkToPoint ~= Vector3.new(0,0,0) then
			moveDirection = CFrame.new(targetRoot.Position * Vector3.new(1,0,1), walkToPoint * Vector3.new(1,0,1)).LookVector
		end
	end
	simulationIgnoreList = {floorHit,wallHit,ceilHit,targetCharacter}
	if LocalPlayer.Character then
		table.insert(simulationIgnoreList,LocalPlayer.Character)
	end
	while true do
		local simulationTick = tick()
		local tickDifference = predictLag and (simulationTick - startTick) or 0
		simulatedPos += Vector3.new(0,aimHeight,0)
		x = (Vector2.new(simulatedPos.X,simulatedPos.Z) - Vector2.new(startPosition.X,startPosition.Z)).Magnitude
		y = simulatedPos.Y - startPosition.Y
		launchAngle = projectileGravity ~= 0 and math.atan((v^2 - math.sqrt(v^4 - pg*(pg*x^2 + 2*y*v^2))) / (pg*x)) or math.atan(y/x)
		travelTime = isAGun and ping / 1000 + tickDifference or x / math.cos(launchAngle) / v + ping / 1000 + tickDifference
		interval = travelTime - simulatedTime <= interval and travelTime - simulatedTime or originalInterval	
		simulatedPos -= Vector3.new(0,aimHeight,0)
		if simulatedTime >= travelTime or simulatedTime >= maxSimulationTime or simulatedPos.Y <= workspace.FallenPartsDestroyHeight then break end
		prevSimulatedPos = simulatedPos
		moveDirection = walkToPoint ~= Vector3.new(0,0,0) and CFrame.new(targetRoot.Position * Vector3.new(1,0,1), walkToPoint * Vector3.new(1,0,1)).LookVector or moveDirection
		simulationStep()
		simulatedVel -= Vector3.new(0,gravity*interval,0)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = simulationIgnoreList
		raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
		raycastParams.RespectCanCollide = respectCanCollide
		local checkFloorIntercept = workspace:Blockcast(CFrame.new(prevSimulatedPos - Vector3.new(0,1.001,0)) * CFrame.Angles(0,math.rad(targetRoot.Orientation.Y),0),Vector3.new(2, 0.002, 1),(prevSimulatedPos - Vector3.new(0,1.001,0)) - (simulatedPos - Vector3.new(0,1.001,0)),raycastParams)
		local checkCeilIntercept = workspace:Blockcast(CFrame.new(prevSimulatedPos + Vector3.new(0,1.001,0)) * CFrame.Angles(0,math.rad(targetRoot.Orientation.Y),0),Vector3.new(2, 0.002, 1),(prevSimulatedPos + Vector3.new(0,1.001,0)) - (simulatedPos + Vector3.new(0,1.001,0)),raycastParams)
		if checkFloorIntercept and checkFloorIntercept.Position and checkFloorIntercept.Position.Y <= prevSimulatedPos.Y then
			simulatedPos = Vector3.new(simulatedPos.X,checkFloorIntercept.Position.Y + 3,simulatedPos.Z)
		elseif checkCeilIntercept and checkCeilIntercept.Position and checkCeilIntercept.Position.Y >= prevSimulatedPos.Y then
			simulatedPos = Vector3.new(simulatedPos.X,checkCeilIntercept.Position.Y - 2,simulatedPos.Z)
		end
		updateIndicatorPosition()
		local wallTouchingParts, touchingTrussLadder = checkTouchingParts(wallHit:GetTouchingParts(),ignoreList)
		if #wallTouchingParts > 0 then
			if touchingTrussLadder then
				simulatedVel = Vector3.new(0,targetHum.WalkSpeed,0)
			else
				local dir = CFrame.new(prevSimulatedPos,simulatedPos).LookVector.Unit
				if dir ~= dir then dir = Vector3.new(0,0,0) end
				simulatedPos += Vector3.new(-dir.X,0,0)
				updateIndicatorPosition()
				local wallTouchingParts = checkTouchingParts(wallHit:GetTouchingParts(),ignoreList)
				if #wallTouchingParts > 0 then
					simulatedPos += Vector3.new(dir.X,0,-dir.Z)
					updateIndicatorPosition()
					local wallTouchingParts = checkTouchingParts(wallHit:GetTouchingParts(),ignoreList)
					if #wallTouchingParts > 0 then
						simulatedPos = prevSimulatedPos
					end
				end
			end
		end
		updateIndicatorPosition()
		local floorTouchingParts, touchingTrussLadder = checkTouchingParts(floorHit:GetTouchingParts(),ignoreList)
		if not touchingTrussLadder and #floorTouchingParts > 0 and simulatedVel.Y <= interval then
			local highest
			for _, v in pairs(floorTouchingParts) do
				if v.ClassName == "Part" and v.Shape == Enum.PartType.Block and checkOrientation(v) and simulatedPos.Y - 1 > v.Position.Y + v.Size.Y / 2 and (not highest or v.Position.Y + v.Size.Y / 2 > highest) then
					highest = v.Position.Y + v.Size.Y / 2
					print(v)
				else
					local height = checkHighestLowest(v,1)
					if height and (not highest or height > highest) then
						highest = height
					end
				end
			end
			if highest then
				frictionDeceleration = 750
				simulatedPos = Vector3.new(simulatedPos.X,highest + 3,simulatedPos.Z)
				simulatedVel *=  Vector3.new(1,0,1)
				if predictJump and targetHum.Jump or alwaysJumping then
					simulatedVel = Vector3.new(simulatedVel.X,playerJumpPower,simulatedVel.Z)
				end
			else
				frictionDeceleration = 142
			end
		end
		updateIndicatorPosition()
		local ceilTouchingParts, touchingTrussLadder = checkTouchingParts(ceilHit:GetTouchingParts(),ignoreList)
		if not touchingTrussLadder and #ceilTouchingParts > 0 and simulatedVel.Y >= -interval then
			local lowest
			for _, v in pairs(floorTouchingParts) do
				if (v.ClassName == "Part" or v.ClassName == "SpawnLocation") and v.Shape == Enum.PartType.Block and checkOrientation(v) and simulatedPos.Y + 1.9 < v.Position.Y - v.Size.Y / 2 and (not lowest or v.Position.Y - v.Size.Y / 2 < lowest) then
					lowest = v.Position.Y - v.Size.Y / 2
					print(v)
				else
					local low = checkHighestLowest(v,2)
					if low and (not lowest or low < lowest) then
						lowest = low
					end
				end
			end
			if lowest then
				simulatedPos = Vector3.new(simulatedPos.X,lowest - 2,simulatedPos.Z)
				simulatedVel *=  Vector3.new(1,-1,1)
			end
		end
		if #floorTouchingParts <= 0 and #ceilTouchingParts <= 0 then
			frictionDeceleration = 142
		end
		if travelTime - simulatedTime >= originalInterval then
			table.insert(path,simulatedPos)
		end
		simulatedTime += interval
	end
	floorHit:Destroy()
	wallHit:Destroy()
	ceilHit:Destroy()
	simulatedPos += Vector3.new(0,aimHeight,0)
	local aimPosition = Vector3.new(simulatedPos.X,(x * math.tan(launchAngle))+startPosition.Y,simulatedPos.Z)
	if aimPosition ~= aimPosition then
		aimPosition = nil
	end
	return path, aimPosition
end
return module
