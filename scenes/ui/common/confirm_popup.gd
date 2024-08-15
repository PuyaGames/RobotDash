extends CanvasLayer
class_name ConfirmPopup


signal confirm
signal cancel


@export var click_sound : AudioStream


func _ready() -> void:
	$AnimationPlayer.play("Enter")


func init_text(text : String) -> void:
	$Panel/VBoxContainer/MarginContainer/Label.text = text


func _on_confirm_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	confirm.emit()


func _on_cancel_button_button_down() -> void:
	SoundManager.play_sound(click_sound)
	queue_free()
	cancel.emit()
