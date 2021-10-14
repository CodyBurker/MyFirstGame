extends KinematicBody2D

var dragging = false
var x_in_bounds: bool
var y_in_bounds: bool
var asteroid = load("res://MovingAsteroid.tscn")
export var delete_launcher = false
export var launch_speed = 100
var start_pos: Vector2

signal dragsignal;

func _ready():
	connect("dragsignal",self,"_set_drag_pc")
	start_pos = self.position
	
func _process(_delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		var viewport_size2_x = get_viewport().size.x
		var viewport_size2_y = get_viewport().size.y
		
		x_in_bounds = mousepos.x > 0 and (viewport_size2_x - mousepos.x) > 0
		y_in_bounds = mousepos.y > 0 and (viewport_size2_y - mousepos.y) > 0
		
		var in_bounds = x_in_bounds and y_in_bounds
		
		if in_bounds:
			self.position = Vector2(mousepos.x, mousepos.y)

func _set_drag_pc():
	dragging=!dragging
	if not dragging:
		var asteroid_pos = self.position
		# LAUNCH IT
		if start_pos.y - asteroid_pos.y < 0:
			var instance = asteroid.instance()
			instance.name = "MovingAsteroid"
			var linear_velocity: Vector2
			linear_velocity = launch_speed * (asteroid_pos - start_pos)
			linear_velocity = - linear_velocity
			instance.set_linear_velocity(linear_velocity)
			instance.position = self.position
			get_parent().add_child(instance)
			if delete_launcher:
				get_parent().get_node("DrawLine").queue_free()
				self.queue_free()
			# Start camera follow
			get_parent().get_node("Camera2D").follow_object(instance)
		# Otherwise reset the position.
		else:
			self.position = start_pos


func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal")
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			var screensize = get_viewport().get_rect().size
