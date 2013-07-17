
MANE.enemy = MANE.Sprite:_Extend("enemy")

MANE.enemy.hurtSound = MANE.engine:RequestSound("Sfx/enemyHurt.wav")

function MANE.enemy:Init(params)
	
	self.facingDirection = 1
	self:SetTexture(MANE.player.texture)
	self.size.x = 32; self.size.y = 32
	self.animationStart.x = 0; self.animationStart.y = 0
	self.animationSpeed = 12
	self.animationFrameCount = 6
	self.horizontalFrames = 8
	self.bounding = MANE:vec4(7,0,7,8)
	self.useDirectionX = true

	self.color = MANE:vec4(1,0,0,1)
	self.hp = 1

	if self.parameter == 1 then
		self.color = MANE:vec4(.25,.25,1,1)
		self.hp = 4
	end
end

function MANE.enemy:Update(params)
	
	--Turn back if wall is infront
	local checkX = self.position.x+7
	if self.facingDirection > 0 then checkX = checkX + 7 end
	if not self:CheckGeometry(MANE:vec4(checkX,self.position.y-2,18,16)) or self.wallHit then --todo: sprite rect stuff
		self.facingDirection = -self.facingDirection
	end
	self.direction.x = self.facingDirection * 60
end

function MANE.enemy:Draw(params)
end

function MANE.enemy:Collides( other)
	if other.luaName == "bullet" then
		self.hp = self.hp - 1
		other.dead = true
		if self.hp <= 0 then	
			self.dead = true
			dust = self.level:SpawnSprite("functionRunner",self.position,0)
			dust:SetTexture(MANE.powerup.orbTexture)		
			dust.size.x = 32; dust.size.y = 32
			dust.animationSpeed = 30
			dust.animationFrameCount = 4
			dust.animationStart.x = 0; dust.animationStart.y = 64	
			dust.timer = 4 * (1/15)
			function dust:func()			
				self.timer = self.timer - MANE.engine.elapsedTime
				if self.timer <= 0 then self.dead = true end
			end
			MANE.bullet.damageSound:Play()
		else
			self.hurtSound:Play()
		end
	end

	if other.luaName == "player" then
		other.explode = true		
	end
end
