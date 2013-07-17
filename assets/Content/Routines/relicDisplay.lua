MANE.relicDisplay = MANE.Sprite:_Extend("relicDisplay")
MANE.relicDisplay.orbTexture = MANE.engine:RequestTexture("Textures/orb.tga")

if collectedRelics == nil then collectedRelics = {0,0,0,0,0,0} end

relicColors = {
	MANE:vec4(.75,.75,1,1),
	MANE:vec4(1,.5,0,1),
	MANE:vec4(0,.75,.75,1),
	MANE:vec4(0,.75,.75,1),
	MANE:vec4(0,.75,.75,1),
	MANE:vec4(0,.75,.75,1)
}

function MANE.relicDisplay:Init(params)
	self.texture = MANE.powerup.orbTexture	
	self:SetTexture(self.orbTexture)
	self.size.x = 32; self.size.y = 32
	self.animationStart.x = 0; self.animationStart.y = 96
	self.bounding = MANE:vec4(8,8,0,16)
	self.useGravity = false
	self.collideWithTerrain = false
	self.color = relicColors[self.parameter]
	if not collectedRelics[self.parameter] == true then self.animationStart.x = 32 end
end

function MANE.relicDisplay:Update(params)
end

function MANE.relicDisplay:Draw(params)
end

function MANE.relicDisplay:Collides(other)
end
