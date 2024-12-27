extends Panel

@export var modeName = ''
@export var modeImageNormal: ImageTexture
@export var modeImageHover: ImageTexture
@export var modeImagePressed: ImageTexture

@onready var Text: RichTextLabel = $Card/Margin/GameModeItem/Text

func _ready() -> void:
	Text.text = '[center][b]%s[/b][/center]' % modeName
