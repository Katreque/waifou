extends PanelContainer

@onready var CrownIcon = $Margin/HBox/CrownIcon
@onready var PlayerNameText = $Margin/HBox/PlayerName
@onready var RemovePlayerBtn = $Margin/HBox/Remove

var playerId: int
var playerName: String

func _ready() -> void:
	PlayerNameText.text = playerName
	
	if (!Lobby.isLobbyOwner()):
		RemovePlayerBtn.visible = false
		CrownIcon.visible = false
		
	RemovePlayerBtn.pressed.connect(Callable(self, 'OnRemovePlayerBtnPressed'))

func OnRemovePlayerBtnPressed():
	Lobby.kickMemberFromLobby(playerId)
