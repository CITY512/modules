# Projectile Aimbot Documentation
## Main Module
### Credits to "inkvy" on ROBLOX for making this aimbot
```lua
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/CITY512/modules/main/Projectile%20Aimbot/Projectile%20Aimbot.lua"))()
```
## Aimbot
```lua
-- NOTE: if startPosition, targetCharacter, projectileSpeed, projectileGravity is nil, function returns an error
local calculatedpath, aimvector = Aimbot:Compute(startPosition,targetCharacter,projectileSpeed,projectileGravity,{
	WalkSpeed = 16;
	JumpPower = 50;
	PredictJump = false;
	AlwaysJumping = false;
	Gravity = workspace.Gravity;
	Ping = 50; -- ms
	AimHeight = 0;
	IsAGun = false;
	IgnoreList = {};
	Interval = 1/80;
	MaxSimulationTime = 60;
	RespectCanCollide = true;
})
```
### Display Calculated Movements
```lua
if calculatedpath and #calculatedpath > 0 then
	local hue = 0
	local container = Instance.new("Folder", workspace)
	container.Name = "path"
	for i, v in ipairs(path) do
		local part = Instance.new("Part", container)
		part.Name = i
		part.Color = Color3.fromHSV(hue/360, 0.458824, 1)
		part.Size = Vector3.new(0.75,0.75,0.75)
		part.Shape = Enum.PartType.Ball
		part.Position = v
		part.Anchored = true
		part.CanCollide = false
		part.TopSurface = Enum.SurfaceType.Smooth
		part.BottomSurface = Enum.SurfaceType.Smooth

		hue += 3
		if hue >= 360 then
			hue = 0
		end
	end
end
```
### Display Aim Position
```lua
if aimvector then
	local container = Instance.new("Folder", workspace)
	container.Name = "aimvector"
	local part = Instance.new("Part", container)
	part.Name = "aimpos"
	part.Color = Color3.new(0,0,0)
	part.Size = Vector3.new(0.75,0.75,0.75)
	part.Shape = Enum.PartType.Ball
	part.Position = i
	part.Anchored = true
	part.CanCollide = false
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
end
```
