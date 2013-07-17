
MANE.levelTextSprite = MANE.Sprite:_Extend("levelTextSprite")
MANE.levelTextSprite.font = MANE.engine:RequestFont("Fonts/font.mff")

function MANE.levelTextSprite:Init(params)
	self.useGravity = false
	self.collideWithTerrain = false
end

function MANE.levelTextSprite:Update(params)
end

function MANE.levelTextSprite:Draw(params)
	self:DrawTextCentered(self.font,displayText[self.parameter])
end

function MANE.levelTextSprite:Collides(other)
end
