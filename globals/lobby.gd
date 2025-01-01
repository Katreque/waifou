extends Node

enum GameModes {NONE, AQUOU, WOLFOU, TRUMFOU}
enum AquouGameType {NONE, CLASSIC, MAGIC}

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
var lobbyGameMode: GameModes
var lobbyGameType: AquouGameType

func _ready() -> void:
	Steam.lobby_created.connect(Callable(self, 'OnLobbyCreated'))

func OnLobbyCreated(isConnected: int, thisLobbyId: int):
	if isConnected == 1:
		lobbyId = thisLobbyId
		print('Created a lobby: %s' % thisLobbyId)

		Steam.setLobbyJoinable(lobbyId, true)
		Steam.allowP2PPacketRelay(true)

func setGameMode(gameMode: GameModes):
	lobbyGameMode = gameMode

func setAquouGameType(gameType: AquouGameType):
	lobbyGameType = gameType
	
func createLobby():
	if (lobbyId == 0 && lobbyGameMode && lobbyGameType):
		var maxPlayers: int
		
		match lobbyGameMode:
			GameModes.AQUOU:
				maxPlayers = AQUOU_LOBBY_LIMITS.max
				
		Steam.createLobby(Steam.LOBBY_TYPE_FRIENDS_ONLY, maxPlayers)
