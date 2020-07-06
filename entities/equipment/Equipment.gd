extends Node2D

class_name Equipment

var capital_usage: float = 0.0
var capital_production: float = 0.0

var material_usage: float = 0.0
var material_production: float = 0.0

var power_usage: float = 0.0
var power_production: float = 0.0

var coolant_usage: float = 0.0
var coolant_production: float = 0.0

onready var resource_handler: ResourceHandler = ResourceHandler.new()

onready var entity: Entity = $Entity

func _ready():
	pass


