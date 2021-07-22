extends KinematicBody2D

const MAXSPEED = 100
const ACCELERATION = 300
const FRICTION = 200

var motion = Vector2.ZERO

func _physics_process(delta):
	var input_vector = get_input_vector()
	apply_movement(input_vector, delta)
	apply_friction(input_vector, delta)
	motion = move_and_slide(motion)
	
	
func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return input_vector.normalized()
	
	
func apply_movement(input_vector, delta):
	look_at(get_global_mouse_position())
	if input_vector != Vector2.ZERO:
		motion = motion.move_toward(input_vector * MAXSPEED, ACCELERATION * delta)

		
func apply_friction(input_vector, delta):
	if input_vector == Vector2.ZERO:
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
