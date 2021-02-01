extends Node

var network = NetworkedMultiplayerENet.new()
var port = 8080
var ip = "127.0.0.1"

func _ready():
	connect_to_server()

func connect_to_server():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_connection_failed")
	network.connect("connection_succeeded", self, "_connection_succeeded")

func _connection_failed():
	print("Failed to connect to server " + ip + ":" + str(port))

func _connection_succeeded():
	print("Connected to server " + ip + ":" + str(port))

### Login

func send_name(name: String):
	rpc_id(1, "receive_name", name)

remote func receive_name_accepted():
	get_tree().change_scene("res://scenes/main_scenes/Lobby.tscn")

remote func receive_name_rejected(reason: String):
	State.last_error = reason
	get_tree().change_scene("res://scenes/main_scenes/Error.tscn")

### Lobby

func send_request_waiting_players():
	rpc_id(1, "receive_request_waiting_players")

remote func receive_waiting_players(players: Array):
	State.set_players_list(players)

func send_challenge(player_id: int):
	rpc_id(1, "receive_challenge", player_id)

remote func receive_challenge_accept():
	pass
	
remote func receive_challenge_remove():
	State.remove_challenge()

remote func receive_challenge_request(player_id: int):
	State.add_challenge(player_id)

### Game

func send_bullet(position_x: int, speed: int):
	pass

remote func receive_bullet(position_x: int, speed: int):
	pass

func send_death():
	pass

remote func receive_death():
	pass

func send_quit():
	pass
