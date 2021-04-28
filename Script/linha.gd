extends Node2D


export(Array, NodePath) var slots
export(NodePath) var stopReelFinal

var slotLine = []

signal matchScore(image, amount)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in slots:
		slotLine.append(get_node(i))
		
	if get_node(stopReelFinal).connect("stop", self, "_on_Reel3_stop") != OK:
		print("Erro ao linkar ", name, " ao reel stop")
	
	pass # Replace with function body.
	
	
func _on_Reel3_stop():
	var score = false
	var amount = 0
	
	if slotLine[0].texture == slotLine[1].texture:
		score = true
		slotLine[0].matchBingo()
		slotLine[1].matchBingo()
		amount = 2
		if slotLine[0].texture == slotLine[2].texture:
			slotLine[2].matchBingo()
			amount = 3
	elif slotLine[0].nameObj() == 9:
		score = true
		slotLine[0].matchBingo()
		amount = 1
		
	if score:
		emit_signal("matchScore", slotLine[0].nameObj(), amount)
