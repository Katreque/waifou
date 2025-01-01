extends Panel

const GameTypeItem = preload("res://assets/ui/select-game/select-game-type/game-type-item/GameTypeItem.tscn")

@onready var GameTypeContainer = $ScrollContainer/HBoxContainer

func clearGameTypeItems():
	for child in GameTypeContainer.get_children():
		child.queue_free()

func setGameTypeItems(gameMode: Lobby.GameModes):
	clearGameTypeItems()
	
	match gameMode:
		Lobby.GameModes.AQUOU:
			var firstGameTypeItem = GameTypeItem.instantiate()
			firstGameTypeItem.name = 'ClassicAquouGameTypeItem'
			GameTypeContainer.add_child(firstGameTypeItem)
			firstGameTypeItem.setTitle('Clássico')
			firstGameTypeItem.setDescription('Bem clássico mesmo!')
			firstGameTypeItem.gameType = Lobby.AquouGameType.CLASSIC
			
			var secondGameTypeItem = GameTypeItem.instantiate()
			secondGameTypeItem.name = 'MagicAquouGameTypeItem'
			GameTypeContainer.add_child(secondGameTypeItem)
			secondGameTypeItem.setTitle('Mágico')
			secondGameTypeItem.setDescription('Bem mágico mesmo!')
			secondGameTypeItem.gameType = Lobby.AquouGameType.MAGIC
