
MANE.exit = MANE.Sprite:_Extend("exit")
--MANE.exit.entryOffset = MANE:vec2(0,0)
--MANE.exit.entryVelocity = MANE:vec2(0,0)

function MANE.exit:Init(params)
	self.useGravity = false
	self.collideWithTerrain = false
end

function MANE.exit:Update (params)
end

function MANE.exit:Draw(params)
end

function MANE.exit:Collides ( other )
	if other.luaName == "player" then
		entryNumber = levelProperties.exitData[self.parameter].entry
		self.level:Load(levelProperties.exitData[self.parameter].level)
	end
end
