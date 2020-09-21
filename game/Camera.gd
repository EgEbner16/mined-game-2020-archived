extends KinematicBody2D

const ACCELERATION = 2.0
const MAX_SPEED = 40.0
const FRICTION = 6.0
const ZOOM_SPEED = 10.0
const ZOOM_MARGIN = 0.1
const ZOOM_MIN = 0.5
const ZOOM_MAX = 4.0

var velocity = Vector2.ZERO
var zoom_position = Vector2.ZERO
var zoom_factor = 1.0
var zoom_level = 1.0

onready var base_viewport_x_limit = get_viewport().size.x / 2
onready var base_viewport_y_limit = get_viewport().size.y / 2

var world_width_px = ProjectSettings.get_setting('game/config/world_size').x * ProjectSettings.get_setting('game/config/tile_size')
var world_height_px = ProjectSettings.get_setting('game/config/world_size').y * ProjectSettings.get_setting('game/config/tile_size')

onready var camera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.limit_left = 0
	$Camera2D.limit_top = 0
	$Camera2D.limit_right = world_width_px
	$Camera2D.limit_bottom = world_height_px
	position = Vector2(world_width_px / 2, world_height_px /2)


func _physics_process(delta):

	var viewport_x_limit = self.base_viewport_x_limit * self.zoom_level
	var viewport_y_limit = self.base_viewport_y_limit * self.zoom_level

	if position.x <  viewport_x_limit:
		position.x =  viewport_x_limit

	if position.y < viewport_y_limit:
		position.y = viewport_y_limit

	if position.x >= world_width_px - viewport_x_limit:
		position.x = world_width_px - viewport_x_limit

	if position.y >= world_height_px - viewport_y_limit:
		position.y = world_height_px - viewport_y_limit

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("scroll_right") - Input.get_action_strength("scroll_left")
	input_vector.y = Input.get_action_strength("scroll_down") - Input.get_action_strength("scroll_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, (ACCELERATION / Engine.time_scale))
	else:
		velocity = velocity.move_toward(Vector2.ZERO, (FRICTION / Engine.time_scale))
	print(velocity)
	print(delta)

	# May need to hold on to an old vector and change it using it a delta

	move_and_collide(velocity * (delta / Engine.time_scale) * 60)

	camera.zoom.x = lerp(camera.zoom.x, zoom_level, ZOOM_SPEED * (delta / Engine.time_scale))
	camera.zoom.y = lerp(camera.zoom.y, zoom_level, ZOOM_SPEED * (delta / Engine.time_scale))

	zoom_level = clamp(zoom_level, ZOOM_MIN, ZOOM_MAX)


func _input(event):
	if abs(zoom_position.x - get_global_mouse_position().x) > ZOOM_MARGIN:
		zoom_factor = 1.0
	if abs(zoom_position.y - get_global_mouse_position().y) > ZOOM_MARGIN:
		zoom_factor = 1.0
	if Input.is_action_pressed("zoom_in"):
		if zoom_level > ZOOM_MIN:
			zoom_level -= 0.30
			position = lerp(position, get_global_mouse_position(), 0.30)
	if Input.is_action_pressed("zoom_out"):
		if zoom_level < ZOOM_MAX:
			zoom_level += 0.30
