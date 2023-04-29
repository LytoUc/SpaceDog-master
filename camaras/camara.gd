extends Camera2D


var target : 

func _ready():
	target = get_node("/root/Main/Player") # Cambia "Main/Player" por la ruta de tu personaje en la jerarquía de nodos
	set_process(true)

func _process(delta):
	if target:
		position = target.position
