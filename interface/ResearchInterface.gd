extends Interface

class_name ResearchInterface

const RESEARCH_BUTTON = preload("res://interface/ResearchButton.tscn")


func _ready():
	pass


func _physics_process(delta):
	pass


func create_research_button(research: Research) -> void:
	var research_button = RESEARCH_BUTTON.instance()
	research_button.get_node("Button").text = research.research_name
	research_button.get_node("Label").text = "Cost: $%s" % research.cost
	research_button.research_node_path = research.get_path()

	match research.tier:
		1:
			$ColorRect/HBoxContainer/Tier1VBoxContainer.add_child(research_button)
		2:
			$ColorRect/HBoxContainer/Tier2VBoxContainer.add_child(research_button)
		3:
			$ColorRect/HBoxContainer/Tier3VBoxContainer.add_child(research_button)
		4:
			$ColorRect/HBoxContainer/Tier4VBoxContainer.add_child(research_button)
