extends PanelContainer

@onready var TitleLabel: RichTextLabel = $Card/Margin/Scroll/Margin/VBoxContainer/Label
@onready var DescriptionLabel: RichTextLabel = $Card/Margin/Scroll/Margin/VBoxContainer/RichTextLabel
@onready var ActionBtn: Button = $Card/Button

var gameType

func _ready() -> void:
	ActionBtn.pressed.connect(Callable(self, 'OnActionBtnPressed'))

func OnActionBtnPressed():
	Lobby.setAquouGameType(gameType)
	Lobby.createLobby()

func setTitle(title: String):
	TitleLabel.text = '[center][b]%s[/b][/center]' % title
	
func setDescription(description: String):
	DescriptionLabel.text = description
