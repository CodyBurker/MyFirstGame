extends Sprite
var parent_rotate_speed: float

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	parent_rotate_speed = get_parent().get_parent().rotate_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rotate(parent_rotate_speed * delta)
