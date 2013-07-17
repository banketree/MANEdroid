
MANE.deathtrap = MANE.Sprite:_Extend("deathtrap")

function MANE.deathtrap:Init(param)	
	self.useGravity = false
	self.collideWithTerrain = false
	return members
end

function MANE.deathtrap:Update(param)
end

function MANE.deathtrap:Draw(params)
end

function MANE.deathtrap:Collides ( other )	
	if other.luaName == "player" then
		other.explode = true		
	end
end
