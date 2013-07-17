
MANE.spring = MANE.Sprite:_Extend("spring")
MANE.spring.texture = MANE.engine:RequestTexture("Textures/block.tga")
MANE.spring.sound = MANE.engine:RequestSound("Sfx/spring.wav")

function MANE.spring:Init(params)
	self.springTime = 0
	--self.springSin = 0	

	self:SetTexture(MANE.spring.texture)
	self.size = MANE:vec2(32,32)
	
	self.animationStart.x = 0; self.animationStart.y = 32
	self.animationSpeed = 0
	self.animationFrameCount = 6
	self.horizontalFrames = 8

	self.bounding = MANE:vec4(7,0,7,28)	
	self.collideWithTerrain = false
	self.useGravity = false;
end

function MANE.spring:Update(params)
	if self.springTime > 0 then
		self.springTime = self.springTime - MANE.engine.elapsedTime
		if self.springTime <= 0 then
			self.animationSpeed = 0
			self.currentFrame = 0
		end
	end

	--[[ if self.currentSin ~= self.targetSin then
		local sign = 1; if self.currentSin > self.targetSin then sign = -1 end		
		self.currentSin = self.currentSin + (math.pi * MANE.engine.elapsedTime)*sign		
		MANE.engine.level.zoom = 1 - (math.sin(self.currentSin)*.5)
	end --]]
	MANE.engine.level.zoom = math.max(0, math.min(1,MANE.engine.level.zoom))
	--if self.currentSin >= self.targetSin then self.targetSin = 0 end	
	--self.currentSin = math.max(0, self.currentSin)

	

end

function MANE.spring:Draw(params)
end

function MANE.spring:Collides(other)
	--start animation
	if other.luaName == "player" then
		other.onGround = false;
		other.doubleJumpReady = false;
		if self.springTime <= 0 then
			--start animation
			self.animationSpeed = 24
			--push player up!
			other.velocity.y = 925
			
			MANE.spring.sound:Play()

			self.springTime  = (1/24) * 7
			MANE.engine.level.targetZoomSin = math.pi/2			
			--self.targetSin = math.pi/2
		end
	end
end
