extends Node2D

@export var PlayerScene: PackedScene
@export var PlayerScene2: PackedScene
var currentPlayer

func _ready():
	var index = 0
	for i in GameManager.Players:
		currentPlayer = PlayerScene.instantiate()
		if GameManager.Players[i].sprite == "Saria":
			currentPlayer = PlayerScene2.instantiate()
		currentPlayer.name = str(GameManager.Players[i].id)
		currentPlayer.set_multiplayer_authority(currentPlayer.name.to_int())
		get_tree().get_first_node_in_group("MainScene").add_child(currentPlayer)
		
		for spawn in get_tree().get_nodes_in_group("PlayerSpawn"):
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
		index += 1
#	

func _process(delta):
	if get_tree().get_nodes_in_group("Coin").size() == 0:
		self.queue_free()
		GameManager.StartGame.rpc("res://Nodes/TSCN/main_menu.tscn")
