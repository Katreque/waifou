extends Node

var isOnSteamDeck: bool = false
var isOnline: bool = false
var isOwned: bool = false
var steamAppId: int = 2007460
var steamId: int = 0
var steamUsername: String = ""

func _init() -> void:
	OS.set_environment("SteamAppId", str(steamAppId))
	OS.set_environment("SteamGameId", str(steamAppId))

func _ready() -> void:
	initialize_steam()

func _process(_delta: float) -> void:
	Steam.run_callbacks()

func initialize_steam() -> void:
	var initialize_response: Dictionary = Steam.steamInitEx()
	print("Did Steam initialize?: %s" % initialize_response)

	if initialize_response['status'] > 0:
		print("Failed to initialize Steam. Shutting down. %s" % initialize_response)
		get_tree().quit()

	isOnSteamDeck = Steam.isSteamRunningOnSteamDeck()
	isOnline = Steam.loggedOn()
	isOwned = Steam.isSubscribed()
	steamId = Steam.getSteamID()
	steamUsername = Steam.getPersonaName()

	if isOwned == false:
		print("User does not own this game")
		#get_tree().quit()
