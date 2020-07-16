extends Interface

class_name DroneInterface

onready var drone_manager: DroneManager = get_node('/root/Game/World/DroneManager')

func _ready():
	pass

func _input(event):
	if event.is_action_released("display_drone_interface"):
		self.change_state()


func _on_BuyMiningDrone_pressed():
	drone_manager.create_drone('mining', 0)

func _on_BuyServiceDrone_pressed():
	drone_manager.create_drone('service', 0)

func _on_BuyConstructionDrone_pressed():
	drone_manager.create_drone('construction', 0)

func _on_BuyLogisticDrone_pressed():
	drone_manager.create_drone('logistic', 0)
