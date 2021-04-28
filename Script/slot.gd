extends Sprite


var bingo = false
var time = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	var dad = get_parent().get_parent()
	if not dad.connect("spin", self, "_spin") == OK:
		print("Erro ao conectar slot a spin")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if bingo:
		scale = Vector2(1.1,1.1)
		rotate(2*delta)
	pass

func matchBingo():
	bingo = true

func _spin():
	bingo = false
	scale = Vector2(1,1)
	rotation = 0
	
	
func nameObj():
	return int(texture.get_path()[-5])
	pass
