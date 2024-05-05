## Main Module

```lua
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/CITY512/modules/main/Projectile%20Aimbot.lua"))()
```

### Projectile Aimbot

```lua
local Path, AimPosition = Aimbot:ComputePathAsync(startPosition,targetCharacter,projectileSpeed,projectileGravity{
	WalkSpeed = 16
	JumpPower = 50
	PredictSpamJump = false
	Gravity = 196.2
	Ping = 50 -- ms
	AimHeight = 0
	IsAGun = false
	IgnoreList = {}
	Interval = 1/80
	MaxSimulationTime = 60
	IgnoreCantCollide = true
}
```
