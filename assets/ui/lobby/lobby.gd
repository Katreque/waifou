extends Control

const PlayerCard = preload("res://assets/ui/lobby/player/Player.tscn")

@onready var GameModeText: RichTextLabel = $Panel/AR/VBox/MainContainer/VBox/GameMode
@onready var GameTypeText: RichTextLabel = $Panel/AR/VBox/MainContainer/VBox/Margin/GameType
@onready var Grid: GridContainer = $Panel/AR/VBox/MainContainer/VBox/GridMargin/Scroll/Grid
@onready var BackBtn: Button = $Panel/AR/VBox/ActionContainer/HBox/Back
@onready var InviteBtn: Button = $Panel/AR/VBox/ActionContainer/HBox/Invite
@onready var PlayBtn: Button = $Panel/AR/VBox/ActionContainer/HBox/Play

func _ready() -> void:
	updateLobbyBasedOnOwner()
	
	BackBtn.pressed.connect(Callable(self, 'OnBackBtnPressed'))
	InviteBtn.pressed.connect(Callable(self, 'OnInviteBtnPressed'))
	PlayBtn.pressed.connect(Callable(self, 'OnPlayBtnPressed'))

func OnBackBtnPressed():
	if (Lobby.isLobbyOwner()):
		Core.getUserInterfaceManager().showSelectGameScreen()
	else:
		Lobby.leaveLobby()
		Core.getUserInterfaceManager().showMainMenuScreen()

func OnInviteBtnPressed():
	Steam.activateGameOverlayInviteDialog(Lobby.lobbyId)

func OnPlayBtnPressed():
	pass

func updateGameModeText(newGameModeText: String):
	GameModeText.text = '[center][b]%s[/b][/center]' % newGameModeText
	
func updateGameTypeText(newGameTypeText: String):
	GameTypeText.text = '[center]%s[/center]' % newGameTypeText

func updatePlayersGrid():
	for Card in Grid.get_children():
		Card.queue_free()
	
	for Player in Lobby.lobbyMembers:
		var newPlayer = PlayerCard.instantiate()
		newPlayer.playerId = Player.steamId
		newPlayer.playerName = Player.steamName
		Grid.add_child(newPlayer)

func updateLobbyBasedOnOwner():
	if (Lobby.isLobbyOwner()):
		BackBtn.text = 'Voltar'
	else:
		BackBtn.text = 'Sair'
	
	for Card in Grid.get_children():
		if (Lobby.isLobbyOwner()):
			Card.RemovePlayerBtn.visible = true
		else:
			Card.RemovePlayerBtn.visible = false
		
		if (Lobby.lobbyOwnerId == Card.playerId):
			Card.CrownIcon.visible = true
		else:
			Card.CrownIcon.visible = false
