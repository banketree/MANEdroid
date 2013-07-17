MANE.levitator = MANE.Sprite:_Extend("levitator")
MANE.levitator.texture = MANE.engine:RequestTexture("Textures/player.tga")

function MANE.levitator:Init(params)
	self:SetTexture(MANE.levitator.texture)
	self.size.x = 32; self.size.y = 32
	self.animationStart.x = 32*(self.parameter); self.animationStart.y = 64
	self.useGravity = false
	self.playerColliding = false	
	self.playerWasColliding = false
	self.strobe = math.pi/2
	self.color = MANE:vec4(1,1,1,.5)
end

function MANE.levitator:Update(parmas)
	if self.playerColliding then
		self.strobe = self.strobe + math.pi * MANE.engine.elapsedTime
		self.color = MANE:vec4(1,1,1,math.abs(math.sin(self.strobe))*.5)
	elseif self.playerWasColliding then
		self.strobe = math.pi/2
		self.color = MANE:vec4(1,1,1,.5)	
	end
	self.playerWasColliding = self.playerColliding
	self.playerColliding = false;
	self.collideWithSprites = false;
	self.collideWithTerrain = false;
	--color changing here
	--only strobe if player is colliding
end

function MANE.levitator:Draw(params)
end

function MANE.levitator:Collides(other)
	if other.luaName == "player" then
		self.playerColliding = true
		if self.parameter == 0 then		
			if other.velocity.y < 0 then other.velocity.y = 0 end
			other.velocity.y = other.velocity.y + 1000 * MANE.engine.elapsedTime
			other.onGround = true			
		elseif self.parameter == 1 then
			if other.velocity.y > 0 then other.velocity.y = 0 end
			other.velocity.y = other.velocity.y - 1000 * MANE.engine.elapsedTime
		elseif self.parameter == 2 then
			if other.velocity.x > 0 then other.velocity.x = 0 end
			other.direction.x = other.velocity.x - 1000 * MANE.engine.elapsedTime
			other.onGround = true
		else
			if other.direction.x < 0 then other.velocity.x = 0 end
			other.direction.x = other.direction.x + 1000 * MANE.engine.elapsedTime
			other.onGround = true
		end

		--TODO: Other Parameters for other directions
	end
end

