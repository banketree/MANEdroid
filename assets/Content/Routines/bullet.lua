dofile("Content/Routines/powerup.lua")

MANE.bullet = MANE.Sprite:_Extend("bullet")
MANE.bullet.texture = MANE.engine:RequestTexture("Textures/player_fim.tga")
MANE.bullet.damageSound = MANE.engine:RequestSound("Sfx/damage.wav")

function MANE.bullet:Init(params)
	self.texture = MANE.player.texture	
	self:SetTexture(MANE.bullet.texture)
	self.size.x = 12; self.size.y = 8
	self.animationStart.x = 0; self.animationStart.y = 32
	--sprite:SetBoundingIndents(0,0,0,0)
	self.userDirectionX = true
	self.useGravity = false
	self.collideWithSprites = false;
end

function MANE.bullet:Update(params)
	if self.wallHit then self.dead = true end
end

function MANE.bullet:Draw(params)
end

function MANE.bullet:Collides( other )
	
end
