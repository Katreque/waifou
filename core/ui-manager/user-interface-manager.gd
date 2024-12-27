extends Node2D

var MainMenu: Control
var SelectGame: Control

func _ready() -> void:
	MainMenu = get_parent().get_node('CanvasLayer/MainMenu')
	MainMenu.get_node('Play').pressed.connect(Callable(self, 'OnMainMenuPlayPressed'))
	MainMenu.visible = true
	
	SelectGame = get_parent().get_node('CanvasLayer/SelectGame')

func OnMainMenuPlayPressed():
	SelectGame.visible = true
