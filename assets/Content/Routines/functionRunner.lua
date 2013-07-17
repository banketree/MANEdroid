MANE.functionRunner = MANE.Sprite:_Extend("functionRunner")

function MANE.functionRunner:Init(params)
	function self:func() end
	self.useGravity = false
	self.collideWithTerrain = false
end

function MANE.functionRunner:Update(params)	
	self:func();
end

function MANE.functionRunner:Draw(params)
end

function MANE.functionRunner:Collides(params)
end
