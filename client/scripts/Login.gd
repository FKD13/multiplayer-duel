extends Control


func _ready():
	pass

func submit_name():
	var name: String = $NameField.text
	Server.send_name(name)
	$NameField.editable = false
	$Submit.disabled = true

func _on_submit_pressed():
	submit_name()


func _on_namefield_text_entered(new_text):
	submit_name()
