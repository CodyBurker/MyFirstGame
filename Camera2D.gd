extends Camera2D
var follow=false
var objecttofollow: Node2D
export var follow_slingshot=true
var origin: Vector2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	origin = self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if follow and follow_slingshot:
		self.position = objecttofollow.position
	else: 
		position = origin

func follow_object(followme):
	follow=true
	objecttofollow = followme
