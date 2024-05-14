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

function aimbot:ComputePathAsync(startPosition,targetCharacter,projectileSpeed,projectileGravity,argumentTable)
	-- Start Position

	local LocalPlayer
	if game.Players.LocalPlayer then
		LocalPlayer = game.Players.LocalPlayer
	end
	assert(startPosition,"startpos is required")
	assert(typeof(startPosition) == "Vector3","startpos must be a Vector3")

	-- Target Character
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

	-- Projectile Configurations
	assert(projectileSpeed,"Projectile Speed is required")
	assert(typeof(projectileSpeed) == "number","Projectile Speed must be a number (studs/s)")
	assert(projectileGravity,"Projectile Gravity is required")
	assert(typeof(projectileGravity) == "number","Projectile Gravity must be a number (studs/s²)")

	-- Player Configurations
	local playerWalkSpeed = argumentTable.WalkSpeed or targetHum.WalkSpeed
	local playerJumpPower = argumentTable.JumpPower or targetHum.JumpPower
	local predictSpamJump = argumentTable.PredictSpamJump or false

	-- Workspace Configurations
	local gravity = argumentTable.Gravity or workspace.Gravity

	-- Aimbot Configurations
	local ping = argumentTable.Ping or 50
	local aimHeight = argumentTable.AimHeight or 0
	local isAGun = argumentTable.IsAGun or false

	-- Simulation Configurations
	local ignoreList = argumentTable.IgnoreList or {}
	local interval = argumentTable.Interval or 1/80
	local maxSimulationTime = argumentTable.MaxSimulationTime or 60
	local ignoreCantCollide = argumentTable.IgnoreCantCollide
	if ignoreCantCollide ~= false then
		ignoreCantCollide = true
	end

	-- Assert
	assert(typeof(ignoreList) == "table","IgnoreList must be a table")

	for _, i in pairs(ignoreList) do
		assert(typeof(i) == "Instance","Ignore list elements must be Instances")
	end

	assert(typeof(playerWalkSpeed) == "number","WalkSpeed must be a number (studs/s)")
	assert(typeof(playerJumpPower) == "number","JumpPower must be a number (studs/s)")
	assert(typeof(predictSpamJump) == "boolean","Predict Spam Jump must be a boolean")
	assert(typeof(gravity) == "number","Gravity must be a number (studs/s²)")
	assert(typeof(ignoreCantCollide) == "boolean","IgnoreCanCollide must be a boolean")
	assert(typeof(ping) == "number","Ping must be a number (ms)")
	assert(typeof(aimHeight) == "number","Aim Height must be a number (studs)")
	assert(typeof(isAGun) == "boolean","IsAGun must be a boolean")
	assert(typeof(interval) == "number","Interval must be a number")
	assert(typeof(maxSimulationTime) == "number","Maximum Calculations must be a number")

	-- Variables
	local originalInterval = interval
	local simulatedPos = targetRoot.Position
	local simulatedVel = targetRoot.Velocity
	local simulatedTime = 0
	local frictionDeceleration = 750
	local path = {}
	local moveDirection = targetHum.MoveDirection
	local walkToPoint = targetHum.WalkToPoint
	local prevSimulatedPos
	local pg = projectileGravity
	local v = projectileSpeed
	local launchAngle
	local projDuration
	local x
	local y

	-- Hit Detection

	local floorHit = Instance.new("Part", workspace)
	floorHit.Size = Vector3.new(2,2,1)
	floorHit.CFrame = CFrame.new(targetRoot.Position - Vector3.new(0,2,0)) * CFrame.Angles(0,math.rad(targetRoot.Orientation.Y),0)
	floorHit.Anchored = true

	local wallHit = Instance.new("Part", workspace)
	wallHit.Size = Vector3.new(2,2,1)
	wallHit.CFrame = CFrame.new(targetRoot.Position) * CFrame.Angles(0,math.rad(targetRoot.Orientation.Y),0)
	wallHit.Anchored = true

	local ceilHit = Instance.new("Part", workspace)
	ceilHit.Size = Vector3.new(2,1,1)
	ceilHit.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0,1.5,0)) * CFrame.Angles(0,math.rad(targetRoot.Orientation.Y),0)
	ceilHit.Anchored = true

	-- Functions
	local function tableConcat(t1,t2)
		for i = 1, #t2, 1 do
			table.insert(t1,t2[i])
		end
		return t1
	end
	local function checkTouchingParts(tab,ignoreDescendantsInstances)
		local touchingParts = {}
		local function checkInsideIgnoreList(obj)
			local inside = false
			for _, v in pairs(ignoreDescendantsInstances) do
				if obj:IsDescendantOf(v) then
					inside = true
				end
			end
			return inside
		end
		for _, v in pairs(tab) do
			if not table.find(ignoreDescendantsInstances,v) and not checkInsideIgnoreList(v) and (not ignoreCantCollide or v.CanCollide) then
				table.insert(touchingParts,v)
			end
		end
		return touchingParts
	end
	local function updatePositions()
		floorHit.Position = simulatedPos - Vector3.new(0,2,0)
		wallHit.Position = simulatedPos
		ceilHit.Position = simulatedPos + Vector3.new(0,1.5,0)
	end

	local function checkOrientation(basePart)
		return (math.abs(basePart.Orientation.X) ~= 0 and math.abs(basePart.Orientation.X) ~= 180) and (math.abs(basePart.Orientation.Z) ~= 0 and math.abs(basePart.Orientation.Z) ~= 180)
	end
	local function simulationStep()
		local function calculateVelocityOnAxis(axis)
			local goal
			if axis == "X" then
				goal = moveDirection.X * playerWalkSpeed
			elseif axis == "Z" then
				goal = moveDirection.Z * playerWalkSpeed
			end
			if simulatedVel[axis] > goal then
				if axis == "X" then
					simulatedVel -= Vector3.new(frictionDeceleration * math.abs(moveDirection.X) * interval,0,0)
				elseif axis == "Z" then
					simulatedVel -= Vector3.new(0,0,frictionDeceleration * math.abs(moveDirection.Z) * interval)
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
					simulatedVel += Vector3.new(frictionDeceleration * math.abs(moveDirection.X) * interval,0,0)
				elseif axis == "Z" then
					simulatedVel += Vector3.new(0,0,frictionDeceleration * math.abs(moveDirection.Z) * interval)
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

		simulatedPos += Vector3.new(
			simulatedVel.X*interval + frictionDeceleration*moveDirection.X*interval^2/2,
			simulatedVel.Y*interval + -gravity*interval^2/2,
			simulatedVel.Z*interval + frictionDeceleration*moveDirection.Z*interval^2/2
		) -- Calculates next simulated point position

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
		local priorityray

		local rot = floorHit.Orientation.Y
		local function getPosition(offset,rot)
			local positionMatrix = {
				{offset.X},
				{offset.Y}
			}
			local rotationMatrix = {
				{math.cos(math.rad(rot)),-math.sin(math.rad(rot))},
				{math.sin(math.rad(rot)),math.cos(math.rad(rot))}
			}
			local resultMatrix = {
				{rotationMatrix[1][1] * positionMatrix[1][1] + rotationMatrix[1][2] * positionMatrix[2][1]},
				{rotationMatrix[2][1] * positionMatrix[1][1] + rotationMatrix[2][2] * positionMatrix[2][1]}
			}
			local x,z = floorHit.Position.X + resultMatrix[1][1],floorHit.Position.Z + resultMatrix[2][1]
			return x,z
		end

		local params = RaycastParams.new()
		params.FilterDescendantsInstances = {obj}
		params.FilterType = Enum.RaycastFilterType.Include

		local x,z = getPosition(Vector2.new(0.9375,0.4375),-rot)
		local ray1 = workspace:Raycast(Vector3.new(x,simulatedPos.Y + dirY / math.abs(dirY),z),Vector3.new(0,dirY,0),params)

		local x,z = getPosition(Vector2.new(-0.9375,0.4375),-rot)
		local ray2 = workspace:Raycast(Vector3.new(x,simulatedPos.Y + dirY / math.abs(dirY),z),Vector3.new(0,dirY,0),params)

		local x,z = getPosition(Vector2.new(0.9375,-0.4375),-rot)
		local ray3 = workspace:Raycast(Vector3.new(x,simulatedPos.Y + dirY / math.abs(dirY),z),Vector3.new(0,dirY,0),params)

		local x,z = getPosition(Vector2.new(-0.9375,-0.4375),-rot)
		local ray4 = workspace:Raycast(Vector3.new(x,simulatedPos.Y + dirY / math.abs(dirY),z),Vector3.new(0,dirY,0),params)

		if ray1 and ray1.Position and (not priorityray or ((typ == 1 and ray1.Position.Y > priorityray) or (typ == 2 and ray1.Position < priorityray))) then
			priorityray = ray1.Position.Y
		end
		if ray2 and ray2.Position and (not priorityray or ((typ == 1 and ray2.Position.Y > priorityray) or (typ == 2 and ray2.Position < priorityray))) then
			priorityray = ray2.Position.Y
		end
		if ray3 and ray3.Position and (not priorityray or ((typ == 1 and ray3.Position.Y > priorityray) or (typ == 2 and ray3.Position < priorityray))) then
			priorityray = ray3.Position.Y
		end
		if ray4 and ray4.Position and (not priorityray or ((typ == 1 and ray4.Position.Y > priorityray) or (typ == 2 and ray4.Position < priorityray))) then
			priorityray = ray4.Position.Y
		end

		return priorityray
	end

	-- Update Ignore List Variable
	if LocalPlayer and LocalPlayer.Character then
		table.insert(ignoreList,LocalPlayer.Character)
	end
	ignoreList = tableConcat(ignoreList,{targetCharacter,ceilHit,wallHit,floorHit})

	-- Check Move Direction
	if moveDirection == Vector3.new(0,0,0) then -- if walking is called by :MoveTo() instead of :Move()
		if walkToPoint ~= Vector3.new(0,0,0) then
			moveDirection = CFrame.new(targetRoot.Position * Vector3.new(1,0,1), walkToPoint * Vector3.new(1,0,1)).LookVector
		end
	end

	-- Simulation
	while true do -- Repeats until the projectile meets the simulated point
		simulatedPos += Vector3.new(0,aimHeight,0)

		x = (Vector2.new(simulatedPos.X,simulatedPos.Z) - Vector2.new(startPosition.X,startPosition.Z)).Magnitude
		y = simulatedPos.Y - startPosition.Y

		if isAGun then
			launchAngle = math.atan(y/x)
			projDuration = ping / 1000
			if projDuration - simulatedTime <= interval then
				interval = projDuration - simulatedTime
			else
				interval = originalInterval
			end
		else
			if projectileGravity ~= 0 then
				launchAngle = math.atan((v^2 - math.sqrt(v^4 - pg*(pg*x^2 + 2*y*v^2))) / (pg*x))
			else
				launchAngle = math.atan(y/x)
			end
			projDuration = x / math.cos(launchAngle) / v + ping / 1000
			if projDuration - simulatedTime <= interval then
				interval = projDuration - simulatedTime
			else
				interval = originalInterval
			end
		end

		simulatedPos -= Vector3.new(0,aimHeight,0)

		if simulatedTime >= projDuration or simulatedTime >= maxSimulationTime or simulatedPos.Y <= workspace.FallenPartsDestroyHeight then break end

		prevSimulatedPos = simulatedPos -- Previous Simulated Position
		if walkToPoint ~= Vector3.new(0,0,0) and (walkToPoint * Vector3.new(1,0,1) - simulatedPos * Vector3.new(1,0,1)).Magnitude <= 2 then
			moveDirection = Vector3.new(0,0,0)
		end

		simulationStep()

		simulatedVel -= Vector3.new(0,gravity*interval,0) -- Decreasing Y Velocity due to Gravity Acceleration

		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = ignoreList
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude

		local checkFloorIntercept = workspace:Raycast(simulatedPos - Vector3.new(0,3,0),(prevSimulatedPos - Vector3.new(0,3,0)) - (simulatedPos - Vector3.new(0,3,0)),raycastParams) -- Checks if simulated point phases through the ground
		local checkWallIntercept = workspace:Raycast(simulatedPos,prevSimulatedPos - simulatedPos,raycastParams) -- Checks if simulated point phases through the ceiling
		local checkCeilIntercept = workspace:Raycast(simulatedPos + Vector3.new(0,2,0),(prevSimulatedPos + Vector3.new(0,2,0)) - (simulatedPos + Vector3.new(0,2,0)),raycastParams) -- Checks if simulated point phases through the ceiling

		if checkFloorIntercept and checkFloorIntercept.Position and checkFloorIntercept.Position.Y <= prevSimulatedPos.Y and checkFloorIntercept.Instance and (not ignoreCantCollide or checkFloorIntercept.Instance.CanCollide) then
			simulatedPos = Vector3.new(simulatedPos.X,checkFloorIntercept.Position.Y + 3,simulatedPos.Z)
		elseif checkCeilIntercept and checkCeilIntercept.Position and checkCeilIntercept.Position.Y >= prevSimulatedPos.Y and checkCeilIntercept.Instance and (not ignoreCantCollide or checkCeilIntercept.Instance.CanCollide) then
			simulatedPos = Vector3.new(simulatedPos.X,checkCeilIntercept.Position.Y - 2,simulatedPos.Z)
		end

		updatePositions() -- Update Hit Detection positions

		local wallTouchingParts = checkTouchingParts(wallHit:GetTouchingParts(),ignoreList)

		if #wallTouchingParts > 0 then -- Touching the wall
			local dir = CFrame.new(simulatedPos,prevSimulatedPos).LookVector
			simulatedPos += Vector3.new(prevSimulatedPos.X - simulatedPos.X,0,0)
			updatePositions()
			local wallTouchingParts = checkTouchingParts(wallHit:GetTouchingParts(),ignoreList)
			if #wallTouchingParts > 0 then
				simulatedPos -= Vector3.new(prevSimulatedPos.X - simulatedPos.X,0,-(prevSimulatedPos.Z - simulatedPos.Z))
				updatePositions()
				local wallTouchingParts = checkTouchingParts(wallHit:GetTouchingParts(),ignoreList)
				if #wallTouchingParts > 0 then
					simulatedPos = prevSimulatedPos
				end
			end
		end

		local floorTouchingParts = checkTouchingParts(floorHit:GetTouchingParts(),ignoreList)

		if #floorTouchingParts > 0 and simulatedVel.Y <= interval then -- Touching the floor
			local highest
			for _, i in pairs(floorTouchingParts) do
				if i.ClassName == "Part" and i.Shape == Enum.PartType.Block and checkOrientation(i) and simulatedPos.Y - 1 > i.Position.Y + i.Size.Y / 2 and (not highest or i.Position.Y + i.Size.Y / 2 > highest) then
					highest = i.Position.Y + i.Size.Y / 2
				else
					local height = checkHighestLowest(i,1)
					if height and (not highest or height > highest) then
						highest = height
					end
				end
			end
			if highest then
				frictionDeceleration = 750
				simulatedPos = Vector3.new(simulatedPos.X,highest + 3,simulatedPos.Z)
				simulatedVel *=  Vector3.new(1,0,1)
				if predictSpamJump and targetHum.Jump then
					simulatedVel = Vector3.new(simulatedVel.X,playerJumpPower,simulatedVel.Z)
				end
				updatePositions()
			else
				frictionDeceleration = 142
			end
		end

		local ceilTouchingParts = checkTouchingParts(ceilHit:GetTouchingParts(),ignoreList)

		if #ceilTouchingParts > 0 and simulatedVel.Y >= -interval then -- Touching the ceiling
			local lowest
			for _, i in pairs(floorTouchingParts) do
				if (i.ClassName == "Part" or i.ClassName == "SpawnLocation") and i.Shape == Enum.PartType.Block and checkOrientation(i) and simulatedPos.Y + 1.9 < i.Position.Y - i.Size.Y / 2 and (not lowest or i.Position.Y - i.Size.Y / 2 < lowest) then
					lowest = i.Position.Y - i.Size.Y / 2
				else
					local low = checkHighestLowest(i,2)
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
		-- Add Simulated Point To Table
		if projDuration - simulatedTime >= originalInterval then
			table.insert(path,simulatedPos)
		end
		simulatedTime += interval
	end

	-- Destroy Hit Detections
	floorHit:Destroy()
	wallHit:Destroy()
	ceilHit:Destroy()

	-- Set Aim Height
	simulatedPos += Vector3.new(0,aimHeight,0)

	-- Calculate Aim Position
	local aimPosition = Vector3.new(simulatedPos.X,(x * math.tan(launchAngle))+startPosition.Y,simulatedPos.Z)

	-- Return Values
	return path, aimPosition
end

return aimbot
