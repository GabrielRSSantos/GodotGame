extends Control

@onready var ipList = $IpList
@onready var playerList = $PlayerList

var t

func _ready():
	for p in GameManager.Players:
		GameManager.Players[p].score = 0
	for i in IP.get_local_addresses():
		ipList.add_item(i)

func _process(_delta):
	if playerList.item_count < GameManager.Players.size():
		playerList.clear()
		for i in GameManager.Players:
			playerList.add_item(str(i))

func _on_host_pressed():
	t = await GameManager.Host()
	$Status.text = t

func _on_join_pressed():
	t = GameManager.Join($Ip.text)
	$Status.text = t

func _on_start_pressed():
	print(GameManager.Players)
	$Status.text = "Start"

func _on_ip_list_item_selected(i):
	$Ip.text = ipList.get_item_text(i)

func _on_fase_1_pressed():
	GameManager.StartGame.rpc("res://Nodes/TSCN/cena_1.tscn")
	apagarCenaAtual.rpc()

func _on_fase_2_pressed():
	GameManager.StartGame.rpc("res://Nodes/TSCN/cena_2.tscn")
	apagarCenaAtual.rpc()

@rpc("any_peer", "call_local", "reliable")
func apagarCenaAtual():
	self.queue_free()
	
