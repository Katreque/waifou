extends Node2D

class_name UI

var LoadingScreen: Control
var LobbyScreen: Control
var MainMenuScreen: Control
var SelectGameScreen: Control

func _ready() -> void:
	LoadingScreen = get_parent().get_node('LoadingLayer/Loading')
	LobbyScreen = get_parent().get_node('CanvasLayer/Lobby')
	MainMenuScreen = get_parent().get_node('CanvasLayer/MainMenu')
	SelectGameScreen = get_parent().get_node('CanvasLayer/SelectGame')
	
	MainMenuScreen.get_node('Play').pressed.connect(Callable(self, 'OnMainMenuPlayPressed'))
	Steam.lobby_created.connect(Callable(self, 'OnSteamLobbyCreated'))
	
	MainMenuScreen.visible = true

func OnMainMenuPlayPressed():
	SelectGameScreen.visible = true
	
func OnSteamLobbyCreated(_connect: int, _thisLobbyId: int):
	hideLoadingScreen(showLobbyScreen)

func showLoadingScreen():
	LoadingScreen.visible = true

func showLobbyScreen():
	LobbyScreen.visible = true
	MainMenuScreen.visible = false
	SelectGameScreen.visible = false
	
func showMainMenuScreen():
	LobbyScreen.visible = false
	MainMenuScreen.visible = true
	SelectGameScreen.visible = false
	
func showSelectGameScreen():
	LobbyScreen.visible = false
	MainMenuScreen.visible = false
	SelectGameScreen.visible = true

func hideLoadingScreen(callback: Callable):
	callback.call()
	await get_tree().create_timer(1).timeout
	LoadingScreen.visible = false

func updateLobbyScreenGameMode(gameModeText: String):
	LobbyScreen.updateGameModeText(gameModeText)

func updateLobbyScreenGameType(gameTypeText: String):
	LobbyScreen.updateGameTypeText(gameTypeText)
