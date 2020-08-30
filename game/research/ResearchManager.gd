extends Node


class_name ResearchManager


onready var research_interface := get_node('/root/Game/InterfaceManager/ResearchInterface')


var research_affect_list: Dictionary


func _ready():
	self.create_research('Generator Power I', 2, 50000, 180, 'generator_power_multiplier', 1.25, 1.00)
	self.create_research('Generator Power II', 4, 250000, 300, 'generator_power_multiplier', 1.50, 1.00)
	self.create_research('Pump Coolant I', 2, 50000, 180, 'pump_coolant_multiplier', 1.25, 1.00)
	self.create_research('Pump Coolant II', 4, 250000, 300, 'pump_coolant_multiplier', 1.50, 1.00)
	self.create_research('Matter Reactor Processing I', 1, 125000, 120, 'matter_reactor_processing_multiplier', 1.15, 1.00)
	self.create_research('Matter Reactor Processing II', 3, 350000, 240, 'matter_reactor_processing_multiplier', 1.30, 1.00)
	self.create_research('Collector Efficiency I', 1, 125000, 120, 'collector_efficiency_multiplier', 1.10, 1.00)
	self.create_research('Collector Efficiency II', 3, 300000, 240, 'collector_efficiency_multiplier', 1.20, 1.00)
	self.create_research('Distributor Range I', 2, 75000, 180, 'distributor_range_increase', 50.0, 0.00)
	self.create_research('Distributor Range II', 3, 250000, 240, 'distributor_range_increase', 100.0, 0.00)
	self.create_research('Mining Drone Dig Speed I', 1, 150000, 120, 'mining_drone_dig_speed_reduction', 0.25, 0.00)
	self.create_research('Mining Drone Dig Speed II', 5, 600000, 360, 'mining_drone_dig_speed_reduction', 0.50, 0.00)
	self.create_research('Service Drone Move Speed I', 3, 75000, 240, 'service_drone_movement_speed_increase', 25, 0.00)
	self.create_research('Service Drone Move Speed II', 5, 650000, 360, 'service_drone_movement_speed_increase', 50, 0.00)
	self.create_research('Construction Drone Build I', 1, 75000, 120, 'construction_drone_build_power_increase', 0.25, 0.00)
	self.create_research('Construction Drone Build II', 4, 400000, 300, 'construction_drone_build_power_increase', 0.50, 0.00)
	self.create_research('Logistic Drone Capacity I', 2, 200000, 180, 'logistic_drone_storage_capacity_increase', 1, 0.00)
	self.create_research('Logistic Drone Capacity II', 5, 800000, 360, 'logistic_drone_storage_capacity_increase', 2, 0.00)
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

