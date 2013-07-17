MANE.block = MANE.Sprite:_Extend("block")
MANE.block.texture = MANE.engine:RequestTexture("Textures/block.tga")

function MANE.block:Init(params)
	self:SetTexture(MANE.block.texture)
	self.size.x = 32; self.size.y = 32
	self.useGravity = false
	self.isSolid = true
end

function MANE.block:Update(parmas)
end

function MANE.block:Draw(params)
end

function MANE.block:Collides(other)
	if other.luaName == "bullet" then
		self.dead = true
		other.dead = true
	end
end

