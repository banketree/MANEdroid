dofile("Content/Routines/player.lua")

MANE.entry = MANE.Sprite:_Extend("entry")
MANE.entry.textFont = MANE.engine:RequestFont("Fonts/font.mff")
--MANE.entry = entry

--make sure this is defined by the time we save
if collectedRelics == nil then collectedRelics = {false,false,false,false,false,false} end

function MANE.entry:Init(params)
	--SetSize(0,0)
	self.useGravity = false
	
	--spawn the sprite
	if self.parameter == entryNumber then
		newplayer = self.level:SpawnSprite("player",self.position,0)
	end
end

function MANE.entry:Update(params)
	if self.parameter == entryNumber then 
		MANE.engine.game:Save()
		self.dead = true
	end
end

function MANE.entry:Draw(params)
end

function MANE.entry:Collides(params)
end
