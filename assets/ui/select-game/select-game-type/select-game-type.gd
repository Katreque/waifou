extends Panel

const GameTypeItem = preload("res://assets/ui/select-game/select-game-type/game-type-item/GameTypeItem.tscn")

@onready var GameTypeContainer = $ScrollContainer/HBoxContainer

func clearGameTypeItems():
	for child in GameTypeContainer.get_children():
		child.queue_free()

func setGameTypeItems(gameMode: int):
	clearGameTypeItems()
	
	match gameMode:
		Lobby.GameModes.AQUOU:
			var firstGameType = Lobby.GameTypes[Lobby.GameModes.AQUOU].CLASSIC
			var firstGameTypeItem = GameTypeItem.instantiate()
			firstGameTypeItem.name = 'ClassicAquouGameTypeItem'
			firstGameTypeItem.gameType = firstGameType
			GameTypeContainer.add_child(firstGameTypeItem)
			firstGameTypeItem.setTitle(Lobby.GameTypesNameMap[firstGameType])
			firstGameTypeItem.setDescription('Bem clássico mesmo!')
			
			var secondGameType = Lobby.GameTypes[Lobby.GameModes.AQUOU].MAGIC
			var secondGameTypeItem = GameTypeItem.instantiate()
			secondGameTypeItem.name = 'MagicAquouGameTypeItem'
			secondGameTypeItem.gameType = secondGameType
			GameTypeContainer.add_child(secondGameTypeItem)
			secondGameTypeItem.setTitle(Lobby.GameTypesNameMap[secondGameType])
			secondGameTypeItem.setDescription('Bem mágico mesmo!')
