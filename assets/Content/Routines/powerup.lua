dofile("Content/Routines/functionRunner.lua")
dofile("Content/Routines/textSprite.lua")
dofile("Content/Routines/functions.lua")

MANE.powerup = MANE.Sprite:_Extend("powerup")
MANE.powerup.orbTexture = MANE.engine:RequestTexture("Textures/orb.tga")
MANE.powerup.saveSound = MANE.engine:RequestSound("Sfx/menuSelect.wav")
MANE.powerup.powerupSound = MANE.engine:RequestSound("Sfx/powerupSound.wav")

function MANE.powerup:Init(params)
	self.texture = MANE.powerup.orbTexture	
	self:SetTexture(self.orbTexture)
	self.size.x = 32; self.size.y = 32	
	self.animationStart.x = 0; self.animationStart.y = 0
	if self.parameter == 2 then self.animationStart.y = 32; end
	self.bounding = MANE:vec4(8,8,0,16)
	self.useGravity = false
	self.collideWithTerrain = false
	if self.parameter == 0 and playerCanJump then self.dead = true end
	if self.parameter == 1 and playerCanShoot then self.dead = true end
	if self.parameter == 3 and playerCanDoubleJump then self.dead = true end
end

function MANE.powerup:Update(params)
end

function MANE.powerup:Draw(params)
end

function MANE.powerup:Collides(other)
	if other.luaName == "player" then
		local param = self.parameter
		local displayString = "Derp"
		local additionalFunc = function()end

		if param == 0 then
			displayString = "Jump unlocked! Press " .. MANE.player.jumpKey:GetString() .. " to jump."
			additionalFunc = function()
				SetBackground(1)
				--MANE.engine.music:Load("Content/begin.ogg")		
			end	
			playerCanJump = true
		elseif param == 1 then
			displayString = "Shoot unlocked! Press " .. MANE.player.shootKey:GetString() .. " to shoot."
			playerCanShoot = true
		elseif param == 2 then
			MANE.engine.game:Save()--SaveGame()
			self.saveSound:Play() --PlaySound(powerup.saveSound)
		elseif param == 3 then
			displayString = "Double Jump Unlocked!"
			playerCanDoubleJump = true			
		end

		if param ~= 2 then
			MANE.engine.music:Stop()
			self.powerupSound:Play()
			other.active = false;
			runner = self.level:SpawnSprite("functionRunner",MANE:vec2(0,0),0)
			label = self.level:SpawnSprite("textSprite",MANE:vec2(self.position.x,self.position.y+64),0)
			label.string = displayString
			runner.timer = 5
			runner.player = other
			runner.label = label
			runner.additionalFunc = additionalFunc
			function runner:func(params) 
				self.timer = self.timer - MANE.engine.elapsedTime
				if self.timer < 0 then
					self.player.active = true
					self.dead = true
					self.label.dead = true
					self.additionalFunc()					
					MANE.engine.music:Play()
					
				end
			end
		end
		MANE.engine.game:Save() --save game :)
		self.dead = true
	end
end
