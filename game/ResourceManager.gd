extends Node

class_name ResourceManager

var capital: float = 1.0
var material: float = 1.0
var power: float = 1.0
var coolant: float = 1.0

func _ready():
	pass 

func _on_Timer_timeout():
	capital += 200
	material += 98
	power += 124
	coolant += 1500
