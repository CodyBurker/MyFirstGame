extends Line2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var node_position: Vector2
var self_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	node_position = get_parent().get_node("Launcher").position
	self_position = self.position
	self.set_point_position(1,node_position - self_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	node_position = get_parent().get_node("Launcher").position
	self_position = self.position
	self.set_point_position(0,node_position - self_position)
