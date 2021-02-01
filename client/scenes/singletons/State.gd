extends Node


signal players_list_updated
signal challenge_list_updated


var last_error: String = "No Error"
var players_list: Array = []


func set_players_list(players_list: Array):
	self.players_list = players_list
	emit_signal("players_list_updated")


func add_challenge():
	self.
	pass


func remove_challenge():
	pass
