extends Node


var network = NetworkedMultiplayerENet.new()
var port = 8080
var max_clients = 1024

### variables to get matchmaking to work
# playerinfo
var player_info = {}
# when a player challenges another player the challenge is recorded here
var challenges = {}
# keep track of which players are playing each other
var playing = {}

func _ready():
	start_server()

func start_server():
	network.create_server(port, max_clients)
	get_tree().set_network_peer(network)
	
	print("Server started")
	
	network.connect("peer_connected", self, "_client_connected")
	network.connect("peer_disconnected", self, "_client_disconnected")
	print("Function connections set up")

func _client_connected(client_id):
	player_info[client_id] = {
		"name": null, 
	}
	print(player_info)

func _client_disconnected(client_id):
	player_info.erase(client_id)
	print(player_info)

### Login

remote func receive_name(name: String):
	var player_id = get_tree().get_rpc_sender_id()
	var regex = RegEx.new()
	regex.compile("^[a-z1-9]+$")
	if name.length() < 4:
		send_name_rejected(player_id, "Name can't be shorter than 4 characters")
	elif name.length() > 30:
		send_name_rejected(player_id, "Name can't be longer than 30 characters")
	elif not regex.search(name):
		send_name_rejected(player_id, "Name should be alphanumeric")
	else:
		send_name_accepted(player_id)
		player_info[player_id]["name"] = name
		print(player_info)
			
	
func send_name_accepted(player_id: int):
	rpc_id(player_id, "receive_name_accepted")

func send_name_rejected(player_id: int, reason: String):
	rpc_id(player_id, "receive_name_rejected", reason)

### Lobby

remote func receive_request_waiting_players():
	var player_id = get_tree().get_rpc_sender_id()
	var players_list = []
	for k in player_info.keys():
		for i in range(100):
			players_list.append({
				"name": player_info[k]["name"],
				"id": k,
			})
	send_waiting_players(player_id, players_list)

func send_waiting_players(player_id: int, players: Array):
	rpc_id(player_id, "receive_waiting_players", players)

remote func receive_challenge(player_id: int):
	pass

func send_challenge_accept(player_id: int):
	pass

func send_challenge_request(player_id: int, challenger_id: int):
	pass

### Game

remote func receive_bullet(position_x: int, speed: int):
	pass

func send_bullet(player_id: int, position_x: int, speed: int):
	pass

remote func receive_death():
	pass

func send_death(player_id: int):
	pass

remote func receive_quit():
	pass

func send_quit(player_id: int):
	pass
