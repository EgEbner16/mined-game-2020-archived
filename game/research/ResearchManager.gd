extends Node


class_name ResearchManager


onready var research_interface := get_node('/root/Game/InterfaceManager/ResearchInterface')


var research_affect_list: Dictionary


func _ready():
	self.create_research('Generator Power I', 1, 10000, 3.0, 'generator_power_multiplier', 1.25, 1.00)
	self.create_research('Generator Power II', 2, 50000, 3.0, 'generator_power_multiplier', 1.50, 1.00)
	self.create_research('Generator Power III', 3, 100000, 3.0, 'generator_power_multiplier', 1.75, 1.00)
	self.create_research('Generator Power IV', 4, 500000, 3.0, 'generator_power_multiplier', 2.00, 1.00)
	self.update_research_affect()


func create_research(research_name: String, tier: int, cost: int, progress_required: float, affect_type: String, affect_upgrade: float, affect_default: float):
	# Need to create a node that is attached to the research manager so we can navigate the Node Tree from the button.
	var research = Research.new(research_name, tier, cost, progress_required, affect_type, affect_upgrade, affect_default)
	self.add_child(research)
	research_interface.create_research_button(research)


func update_research_affect():
	for research in self.get_children():
		if not research_affect_list.has(research.affect_type):
			research_affect_list[research.affect_type] = research.affect_default
		if research.is_complete:
			if research.affect_upgrade < research.affect_default:
				if research_affect_list[research.affect_type] > research.affect_upgrade:
					research_affect_list[research.affect_type] = research.affect_upgrade
			if research.affect_upgrade > research.affect_default:
				if research_affect_list[research.affect_type] < research.affect_upgrade:
					research_affect_list[research.affect_type] = research.affect_upgrade

