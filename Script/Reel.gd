extends Node2D

export var freeSpin = false
export var sizeWheel = 3
export var velocity = 3800
export(float) var timeSpin = 1.5
export(Array, int) var reelSize
export(Array, Texture) var textures
export var firstReel = true

enum {STOP, START}

onready var sfxReel = $sfxReel
onready var sfxReelStop = $sfxReelStop
var swapFigure = 1000
var posTop = -1280
var posStop = 25
var real
var fake
var status
var stop = false
var reelTime
var vel
var setReal = false


signal stop
signal freeKeyStop
signal spin

func _ready():
	randomize()
	add_to_group("Reel")
	real = get_node("Real")
	fake = get_node("Fake")
	setTextureFake(real)
	setTextureFake(fake)
	if not owner.connect("stop", self, "_stop") == OK:
		print("Erro não foi possível linkar o sinal stop")
		get_tree().quit()
	status = STOP
	vel = velocity
	
func _process(delta):
	
	if status == START:
		if !sfxReel.playing:
			sfxReel.playing = false
		if !stop:
			testWheel(real)
			testWheel(fake)
		else:
			reelStop()
		
		real.translate(Vector2(0,1)*vel*delta)
		fake.translate(Vector2(0,1)*vel*delta)
		vel += 25*delta
		if reelTime  > 0:
			reelTime -=delta
		else:
			stop = true
		
	if status == STOP:
		if get_node("Real").position.y > 5:
			real.translate(Vector2(0,-1)*1000*delta)
			fake.translate(Vector2(0,-1)*1000*delta)
		elif get_node("Real").position.y < 0:
			vel = velocity
			sfxReel.playing = false
			sfxReelStop.play()
			get_node("Real").position.y = 0
			get_node("Fake").position.y = -1280
			setReal = false
			
func testWheel(k):
	if k.position.y >= swapFigure:
		if k.name == "Real":
			setTextureReal(k)
			firstReel = !firstReel
		else:
			setTextureFake(k)
			emit_signal("freeKeyStop")
		
		k.position.y = posTop
		
	
func setTextureReal(objeto):
	if !setReal:
		setReal = true
		var p = reelSize.duplicate()
		
		for i in objeto.get_children():
			var code = randi() % reelSize.size()
			while(p[code] == 0):
				code = randi() % reelSize.size()
			p[code] -= 1
			i.texture = textures[code]

func setTextureFake(objeto):
	for i in objeto.get_children():
		i.texture = textures[randi() % textures.size()]

func reelStop():
	status = STOP
	get_node("Real").position.y = posStop
	get_node("Fake").position.y = posTop
	emit_signal("stop")
	

func _stop(allStopped):
	if !allStopped:
		stop = true
	else:
		stop = false
		status = START
		reelTime = timeSpin
		emit_signal("spin")
	
	
#	33%
#	if firstReel:
#		p = [0, 1, 2, 4, 6, 9, 14, 18, 25]
#	else:
#		p = [1, 1, 3, 5, 7, 10, 12, 15, 19]
#	60%
#	if firstReel:
#		p = [1, 3, 5, 8, 11, 14, 17, 21, 25]
#	else:
#		p = [1, 2, 4, 5, 7, 10, 13, 15, 19]
#	50%
#	if firstReel:
#		p = [1, 2, 5, 8, 11, 14, 17, 21, 25]
#	else:
#		p = [1, 2, 4, 5, 7, 10, 13, 15, 19]
