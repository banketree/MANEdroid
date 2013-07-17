
MANE.textSprite = MANE.Sprite:_Extend("textSprite")
MANE.textSprite.font = MANE.engine:RequestFont("Fonts/font.mff")

function MANE.textSprite:Init(params)
	self.string = ""
	self.useGravity = false
	self.collideWithTerrain = false
end

function MANE.textSprite:Update(params)
end

function MANE.textSprite:Draw(params)
	self:DrawTextCentered(self.font,self.string)
end

function MANE.textSprite:Collides(other)
end
