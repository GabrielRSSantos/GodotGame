extends Control

@export var Port = 8910
@export var Adress = "127.0.0.1"
var peer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#func _on_host_button_down ():
#	peer = ENetMultiplayerPeer.new()
#	var error = peer.create_server(Port, 2)
#	if error != OK:
#		print("cannot host: " + str(error))
#		return
#	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
#	multiplayer.set_multiplayer_peer(peer)
#	print("Waiting For Players!")
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
