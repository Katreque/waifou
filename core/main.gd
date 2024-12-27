extends Node2D

func _ready() -> void:
	var UserInterfaceManager = load("res://core/ui-manager/UserInterfaceManager.tscn").instantiate()
	add_child(UserInterfaceManager)
