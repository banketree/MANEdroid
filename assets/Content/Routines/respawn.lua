
MANE.respawn = MANE.Sprite:_Extend("respawn")
MANE.respawn.textFont = MANE.engine:RequestFont("Fonts/font.mff")

function MANE.respawn:Init(params)
	--Create a member table for this object
	self.timer = 1
	self.text = "missingno"

	local messages = {
	"HERP DERP",
	"HURR",
	"NOOOOOOOOOO!!!",
	"LOL",
	"DON'T YOU DIE ON ME!",
	"Ouch",
	"That sucks.",
	"RIP LOL",
	":'(",
	--":3",
	"DX",
	--"Not worth the weight",
	"Crabcakes",
	"Sample Text",
	"Oh noez!",
	--"JOHN MADDEN"
	"Dead",
	"Stranger Danger!",
	"#yolo",
	"How unfortunate",
	"YOU FOOL",
	"You lack discipline",
	"Butterfingers",
	"Witty message here",
	"Bad touch!",
	"I'm mocking you",
	"Stop dying"
	 }	

	self.text = messages[math.random(1,24)];

	self.useGravity = false
	self.collideWithTerrain = false
end

function MANE.respawn:Update(params)
	self:DrawTextCentered(self.textFont,self.text)
	self.timer = self.timer - MANE.engine.elapsedTime
	if(self.timer <= 0) then self.level:Restart() end
end

function MANE.respawn:Draw(params)
	--self:DrawTextCentered(self.textFont,self.text)
end

function MANE.respawn:Collides()
end
