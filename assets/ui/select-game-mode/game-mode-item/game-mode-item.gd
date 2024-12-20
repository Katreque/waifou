extends PanelContainer

@export var modeName = ''
@export var modeImageNormal: ImageTexture
@export var modeImageHover: ImageTexture
@export var modeImagePressed: ImageTexture

@onready var ActionBtn: TextureButton = $Margin/GameModeItem/ColorRect/Btn
@onready var Text: RichTextLabel = $Margin/GameModeItem/Text

func _ready() -> void:
	Text.text = '[center][b]%s[/b][/center]' % modeName
	
	var defaultPanelTheme = get_theme_stylebox('panel')
	var hoverPanelTheme = load('res://assets/ui/select-game-mode/game-mode-item/hover-panel-theme.tres')
	
	ActionBtn.mouse_entered.connect(func(): add_theme_stylebox_override('panel', hoverPanelTheme))
	ActionBtn.focus_entered.connect(func(): add_theme_stylebox_override('panel', hoverPanelTheme))
	ActionBtn.mouse_exited.connect(func(): add_theme_stylebox_override('panel', defaultPanelTheme))
	ActionBtn.focus_exited.connect(func(): add_theme_stylebox_override('panel', defaultPanelTheme))
