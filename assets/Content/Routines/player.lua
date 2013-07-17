dofile("Content/Routines/bullet.lua")

MANE.player = MANE.Sprite:_Extend("player")
MANE.player.texture = MANE.engine:RequestTexture("Textures/player.tga")
MANE.player.leftKey = MANE.engine:RequestKey("left")
MANE.player.rightKey = MANE.engine:RequestKey("right")
MANE.player.jumpKey = MANE.engine:RequestKey("jump")
MANE.player.downKey = MANE.engine:RequestKey("down")
MANE.player.shootKey = MANE.engine:RequestKey("shoot")
MANE.player.jumpSound = MANE.engine:RequestSound("Sfx/jump.wav")
MANE.player.shootSound = MANE.engine:RequestSound("Sfx/shoot.wav")
MANE.player.gibTexture = MANE.engine:RequestTexture("Textures/gibs.tga")
MANE.player.deathSound = MANE.engine:RequestSound("Sfx/die.wav")

function MANE.player:Init(params)
	self.isJumping = false
	self.jumpTime = 0.0
	self.doubleJumpReady = false
	self.previousJumpTime = 0.0
	self.explode = false
	self.facingDirection = 1
	self.flipAmount = 0
	self.active = true
	
	self:SetTexture(MANE.player.texture)
	self.size = MANE:vec2(32,32)
	
	self.animationStart.x = 0; self.animationStart.y = 0
	self.animationSpeed = 12
	self.animationFrameCount = 6
	self.horizontalFrames = 8
	self:Register("player1")
	self.bounding = MANE:vec4(7,0,7,16)
	self.useDirectionX = true
end

function MANE.player:Update(params)

	elapsedTime = MANE.engine.elapsedTime;
	if not self.active then self.direction.x = 0; self.direction.y = 0; self.animationSpeed = 0 ; return end	
	
	if not self.explode then
		local directionX = 0
		local directionY = 0

		if MANE.player.leftKey.isDown then directionX = -200; self.facingDirection = -1; end
		if MANE.player.rightKey.isDown then directionX = 200; self.facingDirection = 1; end


		self.animationFrameCount = 6
		if directionX == 0 then self.animationFrameCount = 1 end
		if not self.onGround then self.animationFrameCount = 1; self.animationStartX = 192 
		else self.animationStartX = 0; MANE.engine.level.targetZoomSin = 0 end

		if self.facingDirection < 0 then
			self.flip.x = self.flip.x + elapsedTime*10
		else
			self.flip.x = self.flip.x - elapsedTime*10
		end
		self.flip.x = math.max( math.min( self.flip.x, 1), 0)



		--[[
		if self.jumpKey.isDown and playerCanJump then
			if self.onGround and self.jumpKey.justHit then
				self.isJumping = true
				self.jumpTime = 0.10
				self.previousJumpTime = 0.10
				self.velocity.y = 0
				self.jumpSound:Play()
			end
		else
			self.isJumping = false
		end
		--]]

		if not playerCanJump or not self.jumpKey.isDown then
			self.isJumping = false
		end

		local doJump = false;

		if self.jumpKey.justHit then
			if self.onGround then
				if playerCanDoubleJump then self.doubleJumpReady = true else self.doubleJumpReady = false end
				if playerCanJump then doJump = true end	
			else
				if self.doubleJumpReady then doJump = true; self.doubleJumpReady = false; end
			end
		end

		if doJump then
			self.isJumping = true
			self.jumpTime = 0.10
			self.previousJumpTime = 0.10
			self.velocity.y = 0
			self.jumpSound:Play()
		end



		self.direction.x = directionX
		self.direction.y = directionY

		if self.isJumping then
			--TODO: Make sure negative jump time is made up for
			self.jumpTime = self.jumpTime - elapsedTime			
			--self.velocity.y = self.velocity.y + 7500*MANE.engine.elapsedTime
			self.velocity.y = self.velocity.y + 7500 * elapsedTime	- ( 7500 * -math.min(0,self.jumpTime) )		
			--self.velocity.y = self.velocity.y + 150*self.previousJumpTime-math.max(self.jumpTime,0)
			if(self.jumpTime <= 0) then self.isJumping = false end
				
			self.previousJumpTime = self.jumpTime
		end

		if playerCanShoot and self.shootKey.justHit then		
			self.shootSound:Play() --PlaySound(self.shootSound)	
			local spawnX = self.position.x		
			if self.facingDirection > 0 then spawnX = spawnX +14 end			
			local newBullet = self.level:SpawnSprite("bullet",MANE:vec2(spawnX,self.position.y+7),0)
			newBullet.direction.x = self.facingDirection*420
			newBullet.useDirectionX = true
		end
		
	end

	--Death Explosion
	if self.explode or self.position.y < 0 then
		self.dead = true
		MANE.player.deathSound:Play()
		
	--head,right,torso,left
		local gibs = {0,0,0,0};
		local gibPositions = { {x=17,y=15}, {x=20,y=0}, {x=4,y=4}, {x=7,y=0} }		
		local gibSizes = { {x=11, y=16}, {x=15,y=17}, {x=16,y=16}, {x=4,y=16} }		
		
		for i = 1, 4 do
			gibs[i] = self.level:SpawnSprite("dummy",self.position,0)
			gibs[i]:SetTexture(self.gibTexture)
			
			gibs[i].position.x = gibs[i].position.x + gibPositions[i].x
			gibs[i].position.y = gibs[i].position.y + gibPositions[i].y
					
			gibs[i].size.x = gibSizes[i].x; gibs[i].size.y = gibSizes[i].y			
			gibs[i].animationStart.x = (i-1)*32
			gibs[i].velocity.x = math.random(-240,240)
			gibs[i].velocity.y = math.random(-240,240)
		end
		self.level:SpawnSprite("respawn",self.position,0) 
	end
end

function MANE.player:Draw(params)
end

function MANE.player:Collides( other )
end
