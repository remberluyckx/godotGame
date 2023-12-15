extends Area2D

var velocity = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	look_at(velocity)
	position += velocity * 500 * delta


func _on_area_entered(area):
	pass
