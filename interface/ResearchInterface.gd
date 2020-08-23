extends Interface

class_name ResearchInterface

func _ready():
	pass

func _physics_process(delta):
	$ColorRect/HBoxContainer/Tier1VBoxContainer/GeneratorResearch1ProgressBar.value += 0.01
