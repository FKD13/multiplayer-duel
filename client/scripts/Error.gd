extends Control


func _ready():
	$ErrorLabel.text = State.last_error

func _on_button_pressed():
	get_tree().change_scene("res://scenes/main_scenes/Login.tscn")
