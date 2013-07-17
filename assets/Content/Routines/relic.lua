dofile("Content/Routines/textSprite.lua")

MANE.relic = MANE.Sprite:_Extend("relic")
MANE.relic.orbTexture = MANE.engine:RequestTexture("Textures/orb.tga")
MANE.relic.powerupSound = MANE.engine:RequestSound("Sfx/powerupSound.wav")

if collectedRelics == nil then collectedRelics = {0,0,0,0,0,0} end

function MANE.relic:Init(params)
	self.texture = MANE.powerup.orbTexture	
	self:SetTexture(self.orbTexture)
	self.size.x = 32; self.size.y = 32
	self.animationStart.x = 0; self.animationStart.y = 96
	self.bounding = MANE:vec4(8,8,0,16)
	self.useGravity = false
	self.collideWithTerrain = false
	if collectedRelics[self.parameter] == true then self.dead = true end
end

function MANE.relic:Update(params)
end

function MANE.relic:Draw(params)
end

function MANE.relic:Collides(other)
	if other.luaName == "player" then
		local param = self.parameter

		MANE.engine.music:Stop()
		self.powerupSound:Play()
		other.active = false;
		runner = self.level:SpawnSprite("functionRunner",MANE:vec2(0,0),0)
		label = self.level:SpawnSprite("textSprite",MANE:vec2(other.position.x,other.position.y-16),0)
		label.string = "You found relic #" .. param .. "!"	
		runner.timer = 5
		runner.player = other
		runner.label = label
		function runner:func(params) 
			self.timer = self.timer - MANE.engine.elapsedTime
			if self.timer < 0 then
				self.player.active = true
				self.dead = true
				self.label.dead = true
				MANE.engine.music:Play()	
			end
		end
		self.dead = true
		collectedRelics[param] = true
	end
end
