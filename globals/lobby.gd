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
var lobbyMembers: Array = []
var lobbyMinMembers: int = 0
var lobbyMaxMembers: int = 0
var lobbyGameMode: int = 0
var lobbyGameType: int = 0
var lobbyOwnerId: int

func _ready() -> void:
	checkIfPlayerWasInvitedWithTheGameClosed()
	
	Steam.lobby_created.connect(Callable(self, 'OnLobbyCreated'))
	Steam.join_requested.connect(Callable(self, 'OnJoinRequested'))
	Steam.lobby_chat_update.connect(Callable(self, 'OnLobbyChatUpdate'))
	Steam.lobby_joined.connect(Callable(self, 'OnLobbyJoined'))
	Steam.lobby_message.connect(Callable(self, 'OnLobbyMessageReceived'))

func OnLobbyCreated(isConnected: int, thisLobbyId: int):
	if isConnected == 1:
		lobbyOwnerId = Steamworks.steamId
		
		Steam.setLobbyJoinable(thisLobbyId, true)
		Steam.allowP2PPacketRelay(true)

func OnJoinRequested(thisLobbyId: int, _friendId: int):
	Core.getUserInterfaceManager().showLoadingScreen()
	Steam.joinLobby(thisLobbyId)
	
func OnLobbyChatUpdate(thisLobbyId: int, _playerId: int, _makingChangeId: int, _chatState: int):
	fetchLobbyMembers()

func OnLobbyJoined(thisLobbyId: int, _permissions: int, _locked: bool, response: int):
	if (response == Steam.CHAT_ROOM_ENTER_RESPONSE_SUCCESS):
		lobbyId = thisLobbyId
		
		if (!isLobbyOwner()):
			setGameMode(int(Steam.getLobbyData(thisLobbyId, 'gameMode')))
			setGameType(int(Steam.getLobbyData(thisLobbyId, 'gameType')))
			print(lobbyGameMode)
			print(lobbyGameType)
			
		fetchLobbyMembers()
		Core.getUserInterfaceManager().showLobbyScreen()
		Core.getUserInterfaceManager().hideLoadingScreen()
	else:
		# Refatorar parte de erros no futuro
		var fail_reason: String
		match response:
			Steam.CHAT_ROOM_ENTER_RESPONSE_DOESNT_EXIST: fail_reason = "This lobby no longer exists."
			Steam.CHAT_ROOM_ENTER_RESPONSE_NOT_ALLOWED: fail_reason = "You don't have permission to join this lobby."
			Steam.CHAT_ROOM_ENTER_RESPONSE_FULL: fail_reason = "The lobby is now full."
			Steam.CHAT_ROOM_ENTER_RESPONSE_ERROR: fail_reason = "Uh... something unexpected happened!"
			Steam.CHAT_ROOM_ENTER_RESPONSE_BANNED: fail_reason = "You are banned from this lobby."
			Steam.CHAT_ROOM_ENTER_RESPONSE_LIMITED: fail_reason = "You cannot join due to having a limited account."
			Steam.CHAT_ROOM_ENTER_RESPONSE_CLAN_DISABLED: fail_reason = "This lobby is locked or disabled."
			Steam.CHAT_ROOM_ENTER_RESPONSE_COMMUNITY_BAN: fail_reason = "This lobby is community locked."
			Steam.CHAT_ROOM_ENTER_RESPONSE_MEMBER_BLOCKED_YOU: fail_reason = "A user in the lobby has blocked you from joining."
			Steam.CHAT_ROOM_ENTER_RESPONSE_YOU_BLOCKED_MEMBER: fail_reason = "A user you have blocked is in the lobby."
		
		print("Failed to join this chat room: %s" % fail_reason)

func OnLobbyMessageReceived(_thisLobbyId: int, user: int, message: String, _chatType: int):
	#if (user == lobbyOwnerId && message.split('-')[0] == 'kick'):
		#leaveLobby()
		#RETOMAR DAQUI
	pass

func isLobbyOwner() -> bool:
	if (lobbyOwnerId == Steamworks.steamId):
		return true
		
	return false

func checkIfPlayerWasInvitedWithTheGameClosed():
	var args: Array = OS.get_cmdline_args()
	if (args.size() > 0 && args[0] == '+connect_lobby' && int(args[1]) > 0):
		Steam.joinLobby(int(args[1]))
		Core.getUserInterfaceManager().showLoadingScreen()

func setGameMode(gameMode: int):
	lobbyGameMode = gameMode
	Steam.setLobbyData(lobbyId, 'gameMode', str(gameMode))
	Core.getUserInterfaceManager().updateLobbyScreenGameMode(getGameModeName())

func getGameModeName() -> String:
	if (lobbyGameMode):
		return GameModesNameMap[lobbyGameMode]
		
	return 'NONE'

func setGameType(gameType: int):
	lobbyGameType = gameType
	Steam.setLobbyData(lobbyId, 'gameType', str(gameType))
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
				
		Core.getUserInterfaceManager().showLoadingScreen()
		Steam.createLobby(Steam.LOBBY_TYPE_FRIENDS_ONLY, maxPlayers)

func fetchLobbyMembers():	
	lobbyMembers.clear()
	var numberOfMembers: int = Steam.getNumLobbyMembers(lobbyId)
	for member in range(0, numberOfMembers):
		var memberSteamId: int = Steam.getLobbyMemberByIndex(lobbyId, member)
		var memberSteamName: String = Steam.getFriendPersonaName(memberSteamId)
		
		lobbyMembers.append({
			'steamId': memberSteamId,
			'steamName': memberSteamName
		})
		
	lobbyOwnerId = Steam.getLobbyOwner(lobbyId)
	Core.getUserInterfaceManager().LobbyScreen.updatePlayersGrid()
	Core.getUserInterfaceManager().LobbyScreen.updateLobbyToOwnerState()

func kickMemberFromLobby(memberSteamId: int):
	if (isLobbyOwner()):
		Steam.sendLobbyChatMsg(lobbyId, 'kick-%s' % memberSteamId)

func leaveLobby():
	if lobbyId != 0:
		Steam.leaveLobby(lobbyId)
		lobbyId = 0
		lobbyMembers.clear()
