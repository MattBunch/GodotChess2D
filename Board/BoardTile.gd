extends Node2D
class_name BoardTile

signal clicked_tile

var selected = false
var tile_code setget set_tile_code, get_tile_code

func init(input_tile_code):
	var debugLabel = $Area2D/DebugLabel
	debugLabel.add_color_override("font_color", Color(255, 0, 0))
	set_tile_code(input_tile_code)
	debugLabel.text = get_tile_code()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		emit_signal("clicked_tile", position, get_tile_code())

func set_tile_code(input_tile_code):
	tile_code = input_tile_code

func get_tile_code():
	return tile_code

func set_tile_position(inputPos):
	position = inputPos

func get_tile_position():
	return position

func set_selected(inputSelected):
	selected = inputSelected

func get_selected():
	return selected
