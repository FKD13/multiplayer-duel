extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Server.send_request_waiting_players()
	State.connect("players_list_updated", self, "_on_playerList_updated")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_playerList_updated():
	var items = []
	for i in State.players_list:
		$PlayerList.add_item(i["name"])

func _on_playerList_item_activated(index: int):
	Server.send_challenge(State.players_list[index]["id"])


func _on_challengeList_item_activated(index):
	pass # Replace with function body.
