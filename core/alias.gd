extends Node

func getUserInterfaceManager() -> UI:
	return get_tree().get_root().get_node('Main').get_node('UserInterfaceManager')
