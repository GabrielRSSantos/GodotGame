extends Node

var Players = {}

var peer = ENetMultiplayerPeer.new()

func _ready():
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.server_disconnected.connect(server_disconnected)
	multiplayer.peer_disconnected.connect(peer_disconnected)

func connected_to_server():
	print("connected_to_server")
	SendPlayerInformation.rpc_id(1, "Saria", multiplayer.get_unique_id())

func server_disconnected():
	print("server_disconnected")

func peer_disconnected(id):
	print("peer_disconnected: " + str(id))

func Host():
	print("Hosted")
	peer.close()
	var error = await peer.create_server(2000)
	if error != OK:
		return "Cannot Host: " + str(error)
	multiplayer.set_multiplayer_peer(peer)
	SendPlayerInformation("Gabriel", multiplayer.get_unique_id())
	return "Hosted"

func Join(_ip):
	print("Join..." + str(_ip))
	peer.close()
	if _ip == "":
		peer.create_client("localhost", 2000)
		multiplayer.set_multiplayer_peer(peer)
		return "Joined localhost"
		
	var error = peer.create_client(_ip, 2000)
	
	if error != OK:
		return "Cannot Join... :" + str(error)
		
	multiplayer.set_multiplayer_peer(peer)
	return "Joined"
	
@rpc("any_peer", "call_local")
func StartGame(map):
	var scene = load(map).instantiate()
	get_tree().root.add_child(scene)
	
@rpc("any_peer")
func SendPlayerInformation(name, id):
	if !Players.has(id):
		Players[id] ={
		"name" : name,
		"id" : id,
		"sprite": name,
		"score": 0
		}
		
	if multiplayer.is_server():
		for i in Players:
			SendPlayerInformation.rpc(Players[i].name, i)

func _isClient():
	if multiplayer.is_server():
		return "Server: "
	else:
		return "Cliente: "
