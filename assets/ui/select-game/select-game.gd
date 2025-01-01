extends Control

@onready var SelectGameMode: VBoxContainer = $AspectRatioContainer/MainPanel/VBoxContainer/Control/SelectGameMode
@onready var SelectGameModeAquouBtn: Button = $AspectRatioContainer/MainPanel/VBoxContainer/Control/SelectGameMode/GridContainer/Aquou/Card/Button
@onready var SelectGameType: Panel = $AspectRatioContainer/MainPanel/VBoxContainer/Control/SelectGameType
@onready var BackBtn: Button = $AspectRatioContainer/MainPanel/VBoxContainer/MarginContainer/Back

func _ready() -> void:
	SelectGameModeAquouBtn.pressed.connect(Callable(self, 'OnAquouBtnPressed'))
	BackBtn.pressed.connect(Callable(self, 'OnBackBtnPressed'))

func OnBackBtnPressed():
	if SelectGameMode.visible:
		self.visible = false
		return
	
	showSelectGameMode()

func OnAquouBtnPressed():
	var gameMode = Lobby.GameModes.AQUOU
	Lobby.setGameMode(gameMode)
	SelectGameType.setGameTypeItems(gameMode)
	showSelectGameType()

func showSelectGameMode():
	SelectGameMode.visible = true
	SelectGameType.visible = false
	
func showSelectGameType():
	SelectGameType.visible = true
	SelectGameMode.visible = false
