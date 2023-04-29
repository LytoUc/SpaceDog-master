extends Node3D

func _on_Area_body_entered(body):
	if body.name == "Laika":
		body.planet_area_entered(self)


func _on_Area_body_exited(body):
	if body.name == "Laika":
		body.planet_area_exited()
