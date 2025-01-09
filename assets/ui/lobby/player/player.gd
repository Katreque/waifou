extends PanelContainer

@onready var PlayerNameText = $Margin/HBox/PlayerName

var playerId: int
var playerName: String

func _ready() -> void:
	PlayerNameText.text = playerName
