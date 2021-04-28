extends Node


export(int) var countLines = 8

export(Array, Array, int) var lines = [1,2,3]
onready var lbText = owner.get_node("view/point")
onready var bn = owner.get_node("view/bonus")
onready var ganho = owner.get_node("view/ganho")
onready var total = owner.get_node("view/total")
onready var porcentagem = owner.get_node("view/porcentagem")
onready var total_ganho = owner.get_node("view/total_ganho")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Reel3_stop():
	var obj = get_tree().get_nodes_in_group("Reel")
	var reel = []
	for i in obj:
		var slot = []
		for j in i.get_node("Real").get_children():
			if j.name.find("back") == -1:
				slot.append(j)
		reel.append(slot)
	
	pointMatch(reel)
	
func pointMatch(viewSlot):
	var bonus = 1000
	var point2 = [100,100,50,50,15,10,10,5,4]
	var point3 = [400,200,100,50,30,20,18,12,6]
	var point = 0
	var trava = false
	
#	vertical
	for i in viewSlot:
		if i[lines[0]-1].texture == i[lines[1]-1].texture:
			if(i[lines[0]-1].nameObj() == 9):
				trava = true
				i[lines[0]-1].matchBingo()
				i[lines[1]-1].matchBingo()
				point += point2[i[lines[1]-1].nameObj()-1]
			if i[lines[0]-1].texture == i[lines[2]-1].texture:
				i[lines[0]-1].matchBingo()
				i[lines[1]-1].matchBingo()
				i[lines[2]-1].matchBingo()
				point += point3[i[lines[1]-1].nameObj()-1]
				if(i[lines[0]-1].nameObj() == 1):
						point += bonus
						bn.text = str(1 + int(bn.text))
		elif i[lines[0]-1].nameObj() == 9:
			lbText.text = str(2 + int(lbText.text))
			point +=2
			i[lines[0]-1].matchBingo()
	
	#horizontal
	for i in viewSlot.size():
		if viewSlot[0][i].texture == viewSlot[1][i].texture:
			if(viewSlot[0][i].nameObj() == 9):
				viewSlot[0][i].matchBingo()
				viewSlot[1][i].matchBingo()
				point += point2[viewSlot[1][i].nameObj()-1]
			if viewSlot[0][i].texture == viewSlot[2][i].texture:
				viewSlot[0][i].matchBingo()
				viewSlot[1][i].matchBingo()
				viewSlot[2][i].matchBingo()
				point += point3[viewSlot[1][i].nameObj()-1]
				if(viewSlot[0][i].nameObj() == 1):
					point += bonus
					bn.text = str(1 + int(bn.text))
		elif viewSlot[0][i].nameObj() == 9:
			lbText.text = str(2 + int(lbText.text))
			point +=2
			viewSlot[0][i].matchBingo()
	
	####################################33
	# diagonal
	if viewSlot[0][0].texture == viewSlot[1][1].texture:
		if(viewSlot[0][0].nameObj() == 9):
			trava = true
			viewSlot[0][0].matchBingo()
			viewSlot[1][1].matchBingo()
			point += point2[viewSlot[0][0].nameObj()-1]
		if viewSlot[0][0].texture == viewSlot[2][2].texture:
			viewSlot[0][0].matchBingo()
			viewSlot[1][1].matchBingo()
			viewSlot[2][2].matchBingo()
			point += point3[viewSlot[0][0].nameObj()-1]
			if(viewSlot[0][0].nameObj() == 1):
				point += bonus
				bn.text = str(1 + int(bn.text))
	elif viewSlot[0][0].nameObj() == 9:
		lbText.text = str(2 + int(lbText.text))
		point +=2
		viewSlot[0][0].matchBingo()
			
	if viewSlot[0][2].texture == viewSlot[1][1].texture:
		if(viewSlot[0][2].nameObj() == 9):
			trava = true
			viewSlot[0][2].matchBingo()
			viewSlot[1][1].matchBingo()
			point += point3[viewSlot[0][2].nameObj()-1]
		if viewSlot[0][2].texture == viewSlot[2][0].texture:
			viewSlot[0][2].matchBingo()
			viewSlot[1][1].matchBingo()
			viewSlot[2][0].matchBingo()
			point += point3[viewSlot[0][2].nameObj()-1]
			if(viewSlot[0][2].nameObj() == 1):
				point += bonus
				bn.text = str(1 + int(bn.text))
	elif viewSlot[0][2].nameObj() == 9:
		lbText.text = str(2 + int(lbText.text))
		point +=2
		viewSlot[0][2].matchBingo()

			
	

		if viewSlot[0][0].nameObj() == 9:
			lbText.text = str(2 + int(lbText.text))
			point +=2
			viewSlot[0][0].matchBingo()
		if viewSlot[0][1].nameObj() == 9:
			lbText.text = str(2 + int(lbText.text))
			point +=2
			viewSlot[0][1].matchBingo()
		if viewSlot[0][2].nameObj() == 9:
			lbText.text = str(2 + int(lbText.text))
			point +=2
			viewSlot[0][2].matchBingo()
		if viewSlot[1][0].nameObj() == 9:
			lbText.text = str(2 + int(lbText.text))
			point +=2
			viewSlot[1][0].matchBingo()
		if viewSlot[2][0].nameObj() == 9:
			lbText.text = str(2 + int(lbText.text))
			point +=2
			viewSlot[2][0].matchBingo()

	lbText.text = str(-8+point + int(lbText.text))
	ganho.text = str(point)
	
	total.text = str(8 + int(total.text))
	total_ganho.text = str(point + int(total_ganho.text))
	var f = float(total_ganho.text)/float(total.text)
	porcentagem.text = str("%.2f " % f)
	if int(lbText.text) < 0:
		print("Total jogado: ", total.text)
		print("Total ganho: ", total_ganho.text)
		get_tree().quit()
