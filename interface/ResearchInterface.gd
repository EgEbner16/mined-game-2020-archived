extends Interface


class_name ResearchInterface


const RESEARCH_BUTTON = preload("res://interface/ResearchButton.tscn")
const RESEARCH_TIER_CONTAINER = preload("res://interface/ResearchTierVBox.tscn")


func _ready():
	pass


func _physics_process(delta):
	pass


func create_research_button(research: Research) -> void:
	update_tier_containers(research.tier)
	var research_button = RESEARCH_BUTTON.instance()
	research_button.get_node("Button").text = research.research_name
	research_button.get_node("Label").text = "Cost: $%s" % research.cost
	if research.in_progress:
		research_button.set_process(true)
	else:
		research_button.set_process(false)
	research_button.research_node_path = research.get_path()
	var tier_box = $ColorRect/HBoxContainer.get_node('Tier%sVboxContainer' % research.tier).add_child(research_button)


func update_tier_containers(tier: int):
	for i in range(tier):
		var tier_number = i + 1
		if not $ColorRect/HBoxContainer.has_node('Tier%sVboxContainer' % tier_number):
			var research_tier_container = RESEARCH_TIER_CONTAINER.instance()
			research_tier_container.name = 'Tier%sVboxContainer' % tier_number
			research_tier_container.get_node("Label").text = 'Tier %s' % tier_number
			$ColorRect/HBoxContainer.add_child(research_tier_container)
