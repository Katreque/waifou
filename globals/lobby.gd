extends Node

const GameModes = {
	'AQUOU': 1,
	'WOLFOU': 2,
	'TRUMFOU': 3
}

const GameModesNameMap = {
	1: 'Aquou',
	2: 'Wolfou',
	3: 'Trumfou',
}

const GameTypes = {
	GameModes.AQUOU: {
		'CLASSIC': 1,
		'MAGIC': 2
	}
}

const GameTypesNameMap = {
	1: 'Clássico',
	2: 'Mágico',
}

const PACKET_READ_LIMIT: int = 32
const AQUOU_LOBBY_LIMITS = {
	'min': 2,
	'max': 8
}

var lobbyId: int = 0
var lobbyData
var lobbyMembers: Array = []
var lobbyMinMembers: int = 0
var lobbyMaxMembers: int = 0
var lobbyGameMode: int = 0
var lobbyGameType: int = 0

func _ready() -> void:
	Steam.lobby_created.connect(Callable(self, 'OnLobbyCreated'))

func OnLobbyCreated(isConnected: int, thisLobbyId: int):
	if isConnected == 1:
		lobbyId = thisLobbyId
		print('Created a lobby: %s' % thisLobbyId)

		Steam.setLobbyJoinable(lobbyId, true)
		Steam.allowP2PPacketRelay(true)

func setGameMode(gameMode: int):
	lobbyGameMode = gameMode
	Core.getUserInterfaceManager().updateLobbyScreenGameMode(getGameModeName())

func getGameModeName() -> String:
	if (lobbyGameMode):
		return GameModesNameMap[lobbyGameMode]
		
	return 'NONE'

func setGameType(gameType: int):
	lobbyGameType = gameType
	Core.getUserInterfaceManager().updateLobbyScreenGameType(getGameTypeName())
	
func getGameTypeName() -> String:
	if (lobbyGameType):
		return GameTypesNameMap[lobbyGameType]
		
	return 'NONE'
	
func createLobby():
	if (!lobbyId && lobbyGameMode && lobbyGameType):
		var maxPlayers: int
		
		match lobbyGameMode:
			GameModes.AQUOU:
				maxPlayers = AQUOU_LOBBY_LIMITS.max
				
		Steam.createLobby(Steam.LOBBY_TYPE_FRIENDS_ONLY, maxPlayers)
