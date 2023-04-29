extends Camera3D

@onready var target : Object = get_parent().get_node("Laika")
@export var smooth_speed : float
@export var offset: Vector3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(target != null):
		self.transform.origin = lerp(self.transform.origin,target.transform.origin + offset, smooth_speed*delta)
