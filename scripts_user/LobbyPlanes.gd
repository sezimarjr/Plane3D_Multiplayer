extends Node

signal player_connected (peer_id,player_info)
signal player_disconnected (peer_id)
signal server_disconnected

const PORT = 7000
const MAX_CONNECTIONS = 2
var players : Dictionary = {}
var player_info : Dictionary = {"name":"NAME"}

func create_game():
	var _peer = ENetMultiplayerPeer.new()
	var _error = _peer.create_server(PORT,MAX_CONNECTIONS)
	if _error:
		return _error
	multiplayer.multiplayer_peer = _peer
	players[1] = player_info
	player_connected.emit(1,player_info)
	

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
