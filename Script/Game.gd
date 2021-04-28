extends Node

signal stop(allStopped)

var allStopped = true
var freeKey = true
var value = 0
var time = 0.3
var newtime = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	newtime = time
	pass # Replace with function body.

#func _process(delta):
#	if freeKey && newtime < 0:
#			freeKey = false
#			emit_signal("stop", allStopped)
#			allStopped = false
#			newtime = time
#	newtime -= delta

func _unhandled_key_input(event):
	if freeKey:
		if event.is_action_pressed("ui_accept") and !event.is_echo():
			freeKey = false
			emit_signal("stop", allStopped)
			allStopped = false
			

func _on_Reel3_stop():
	value += 1
	allStopped = true
	freeKey = true
	pass # Replace with function body.

func _on_Reel_freeKeyStop():
	freeKey = true
	pass # Replace with function body.

func _on_1_matchScore(image, amount):
	print("IMAGEM: ", image, " pontos: ", amount)

