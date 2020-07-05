extends Node

class_name ResourceManager

var capital: float = 0.0
var capital_usage: float = 0.0
var material: float = 0.0
var material_usage: float = 0.0
var power: float = 0.0
var power_usage: float = 0.0
var coolant: float = 0.0
var coolant_usage: float = 0.0

func _ready():
	capital = ProjectSettings.get_setting('game/config/starting_capital')

func use_capital(amount: float) -> bool:
	if amount <= capital + capital_usage:
		capital_usage += amount
		return true
	else:
		return false

func use_material(amount: float) -> bool:
	if amount <= material + material_usage:
		material_usage += amount
		return true
	else:
		return false

func gain_capital(amount: float) -> void:
	capital_usage -= amount

func gain_material(amount: float) -> void:
	material_usage -= amount

func calculate_power() -> void:
	power = 1679
	power_usage = 1345	

func calculate_coolant() -> void:
	coolant = 673
	coolant_usage = 1211

func _on_Timer_timeout():
	capital -= capital_usage
	capital_usage = 0.0
	material -= material_usage
	material_usage = 0.0

