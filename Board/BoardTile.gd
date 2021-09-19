extends Node2D
class_name BoardTile

signal clicked_tile

var selected = false

func init(num):
	var debugLabel = $Area2D/DebugLabel
	print(num)
	debugLabel.add_color_override("font_color", Color(255, 0, 0))
	debugLabel.text = str(num)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("clicked_tile", position)

func set_tile_position(inputPos):
	position = inputPos

func get_tile_position():
	return position

func set_selected(inputSelected):
	selected = inputSelected

func get_selected():
	return selected
