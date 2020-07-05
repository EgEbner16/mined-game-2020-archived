extends CanvasLayer

const HUD_UPDATE_SPEED = 5
const HUD_LERP_THRESHOLD = 10

var capital_value = 0
var capital_display = 0
var material_value = 0
var material_display = 0
var power_value = 0
var power_display = 0
var power_usage_value = 0
var coolant_value = 0
var coolant_display = 0
var coolant_usage_value = 0
var drones = 0
var drones_working = 0
var equipment = 0
var jobs = 0
var layer_number = 0

onready var drone_hud_value = $Control/TopBar/LeftSide/DroneHUDItem/Value
onready var job_hud_value = $Control/TopBar/LeftSide/JobHUDItem/Value
onready var equipment_hud_value = $Control/TopBar/LeftSide/EquipmentHUDItem/Value
onready var layer_hud_value = $Control/TopBar/LeftSide/LayerHUDItem/Value
onready var capital_hud_value = $Control/TopBar/RightSide/CapitalHUDItem/Value
onready var material_hud_value = $Control/TopBar/RightSide/MaterialHUDItem/Value
onready var power_hud_value = $Control/TopBar/RightSide/PowerHUDItem/Value
onready var coolant_hud_value = $Control/TopBar/RightSide/CoolantHUDItem/Value

# Called when the node enters the scene tree for the first time.
func _ready():
	capital_hud_value.text = str(capital_display)
	material_hud_value.text = str(material_display)
	power_hud_value.text = str(power_display)
	coolant_hud_value.text = str(coolant_display)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if capital_value != capital_display:
		capital_display = lerp(capital_display, capital_value, HUD_UPDATE_SPEED * delta)
		if capital_value - capital_display <= HUD_LERP_THRESHOLD and capital_value - capital_display >= HUD_LERP_THRESHOLD * -1:
			capital_display = capital_value
		capital_hud_value.text = str(int(capital_display))

	if material_value != material_display:
		material_display = lerp(material_display, material_value, HUD_UPDATE_SPEED * delta)
		if material_value - material_display <= HUD_LERP_THRESHOLD and material_value - material_display >= HUD_LERP_THRESHOLD * -1:
			material_display = material_value
		material_hud_value.text = str(int(material_display))

	if power_value != power_display:
		power_display = lerp(power_display, power_value, HUD_UPDATE_SPEED * delta)
		if power_value - power_display <= HUD_LERP_THRESHOLD and power_value - power_display >= HUD_LERP_THRESHOLD * -1:
			power_display = power_value
	if power_usage_value != 0:
		power_hud_value.text = '%smw %s%%' % [int(power_display), int((power_usage_value / power_display) * 100)]
	else:
		power_hud_value.text = '%smw %s%%' % [int(power_display), int(0)]

	if coolant_value != coolant_display:
		coolant_display = lerp(coolant_display, coolant_value, HUD_UPDATE_SPEED * delta)
		if coolant_value - coolant_display <= HUD_LERP_THRESHOLD and coolant_value - coolant_display >= HUD_LERP_THRESHOLD * -1:
			coolant_display = coolant_value
	if coolant_usage_value != 0:
		coolant_hud_value.text = '%st %s%%' % [int(coolant_display), int((coolant_usage_value / coolant_display) * 100)]
	else:
		coolant_hud_value.text = '%st %s%%' % [int(coolant_display), int(0)]

	drone_hud_value.text = str(drones) + ' / ' + str(drones_working)
	job_hud_value.text = str(jobs)
	equipment_hud_value.text = str(equipment)
	if layer_number == 0:
		layer_hud_value.text = 'Surface'
	else:
		layer_hud_value.text = str(layer_number)
	pass
