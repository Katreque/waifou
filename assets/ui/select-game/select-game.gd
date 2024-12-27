extends Control

@onready var SelectGameMode: VBoxContainer = $AspectRatioContainer/Panel/SelectGameMode
@onready var SelectGameModeAquouBtn: Button = $AspectRatioContainer/Panel/SelectGameMode/GridContainer/Aquou/Card/Button
@onready var SelectGameModeBackBtn: Button = $AspectRatioContainer/Panel/SelectGameMode/Back
@onready var SelectGameType: VBoxContainer = $AspectRatioContainer/Panel/SelectGameType
@onready var SelectGameTypeBackBtn: Button = $AspectRatioContainer/Panel/SelectGameType/Back

func _ready() -> void:
	SelectGameModeBackBtn.pressed.connect(func(): visible = false)
	SelectGameModeAquouBtn.pressed.connect(Callable(self, 'OnAquouBtnClicked'))
	SelectGameTypeBackBtn.pressed.connect(Callable(self, 'showSelectGameMode'))

func OnAquouBtnClicked():
	showSelectGameType()

func showSelectGameMode():
	SelectGameMode.visible = true
	SelectGameType.visible = false
	
func showSelectGameType():
	SelectGameType.visible = true
	SelectGameMode.visible = false
