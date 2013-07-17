
MANE.starParticle = MANE.Particle:_Extend("starParticle")

function MANE.starParticle:Init(params)
	local small = math.random(0,1)
	if small == 1 then
		self.size = MANE:vec2(2,2)
		self.direction.x = self.direction.x * .5
	else
		self.size = MANE:vec2(3,3)
	end
	self.color = MANE:vec4(0,0,.5,1)
end

function MANE.starParticle:Update(params)
	self.color = MANE:vec4(math.random(.5,1),math.random(.5,1),math.random(.5,1),1)
	if self.position.x < 0 then self.deleteMe = true end
end
