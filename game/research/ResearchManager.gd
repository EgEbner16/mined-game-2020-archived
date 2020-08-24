extends Node


class_name ResearchManager


onready var research_interface := get_node('/root/Game/InterfaceManager/ResearchInterface')

var research_list : Dictionary

func _ready():
	create_research('Generator Power I', 1, 10000, 120.0, 100)
	create_research('Generator Power II', 2, 50000, 120.0, 100)
	create_research('Generator Power III', 3, 100000, 120.0, 100)
	create_research('Generator Power IV', 4, 500000, 120.0, 100)


func create_research(research_name: String, tier: int, cost: int, progress_required: float, affect: float):
	research_list[research_name] = Research.new(research_name, tier, cost, progress_required, affect)
	research_interface.create_research_button(research_list[research_name])
