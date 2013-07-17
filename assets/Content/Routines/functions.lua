dofile("Content/Routines/starParticle.lua")
dofile("Content/Routines/plainParticle.lua")

if backgroundTextures==nil then
	backgroundTextures = 
	{
		poolbg = MANE.engine:RequestTexture("Backgrounds/pool.tga"),
		crystalbg = MANE.engine:RequestTexture("Backgrounds/crystalbg.tga"),
		balconybg = MANE.engine:RequestTexture("Backgrounds/balconybg.tga")
	}
end

if backgrounds==nil then
backgrounds = 
{
	{
		isParticle = true,
		particleType = "starParticle",
		position = MANE:vec2(320,0),
		size = MANE:vec2(0,256),
		direction = MANE:vec2(-64,1),
		color = MANE:vec4(0,0,0,1),
		music = "Content/begining.ogg",
		emitTime = 1/15,
		layers = 0
	},
	{
		isParticle = true,
		particleType = "plainParticle",
		position = MANE:vec2(0,250),
		size = MANE:vec2(320,0),
		direction = MANE:vec2(4,-64),
		color = MANE:vec4(0.37254902,0.42745098,0.494117647,1),
		music = "Content/fim.ogg",
		emitTime = 1/40,
		layers = 1,
		positions = { MANE:vec2(0,0) },
		paralax = { MANE:vec2(0,0) },
		repeatX = { false },
		repeatY = { false },
		textures = { backgroundTextures.balconybg },
		bgColors = { MANE:vec4(1,1,1,1) }
	},
	{
		isParticle = false,
		layers = 2,
		positions = { MANE:vec2(0,0), MANE:vec2(0,16) },
		paralax = { MANE:vec2(0,0), MANE:vec2(.5,.5) },
		repeatX = { false, true },
		repeatY = { false, false},
		textures = { backgroundTextures.poolbg, backgroundTextures.crystalbg },
		bgColors = { MANE:vec4(1,1,1,1), MANE:vec4(.5,.5,.5,1) },
		color = MANE:vec4(0,0,0,1),
		music = "Content/hay.ogg"
	}

}
end

function SetBackground(index)
	if currentBackground == index or not playerCanJump then return 0 end
	currentBackground = index
	local bg = backgrounds[index]
	MANE.engine.level:ClearBackgrounds()

	if bg.isParticle then
		local newbg = MANE:ParticleBackground(bg.particleType,bg.position,bg.size,bg.direction,MANE.engine.level)
		newbg.emitter.interval = bg.emitTime
		MANE.engine.level:AddParticleBackground(newbg)
	end
	for i = 1, bg.layers do
		local newbg = MANE:Background(bg.textures[i],bg.positions[i],MANE:vec2(0,0),bg.paralax[i],MANE.engine.level)
		newbg.repeatX = bg.repeatX[i]; newbg.repeatY = bg.repeatY[i]
		newbg.color = bg.bgColors[i]			
		MANE.engine.level:AddBackground(newbg)
	end
	
	MANE.engine:SetBGColor(bg.color)
	MANE.engine.music:Load(bg.music)
	MANE.engine.music:Play()
end
