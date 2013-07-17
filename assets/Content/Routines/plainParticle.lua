
MANE.plainParticle = MANE.Particle:_Extend("plainParticle")

function MANE.plainParticle:Init(params)
	local small = math.random(0,1)
	if small == 1 then
		self.size = MANE:vec2(1,1)
		self.direction.x = self.direction.x * .5
		self.direction.y = self.direction.y * .5
	else
		self.size = MANE:vec2(2,2)
	end
	self.color = MANE:vec4(1,1,1,math.random())
end

function MANE.plainParticle:Update(params)
	if self.position.y < 0 then self.deleteMe = true; end
	--self.color = MANE:vec4(1,math.random(.5,1),math.random(.5,1),1)
end
