extends Node2D

const source_id = 0

const exit_id = 1
const player_id = 2
const lawlor_id = 3

var tile_size = 64  # tile size (in pixels)
var width = 15 # width of map (in tiles)
var height = 15 # height of map (in tiles)

var seconds = 4.0

var rng = RandomNumberGenerator.new()

@onready var Map = $TileMapLayer
@onready var LawlorLand = $Lawlor
@onready var main = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	await main.updated
	if Global.level_count%5 == 0:
		seconds += 1.5
	add_player()
	add_exit()
	emit_signal("ready")
	add_lawlor()

func add_player():
	if Global.new_level:
		var rd = rng.randi_range(1, Global.maze_size)
		Global.player_pos = Vector2i(0,rd)
	Map.set_cell(Global.player_pos, source_id, Vector2i(0,0), player_id)

func add_exit():
	if Global.new_level:
		var rd = rng.randi_range(1, Global.maze_size)
		Global.exit_pos = Vector2i(Global.maze_size-1,rd)
	Map.set_cell(Global.exit_pos, source_id, Vector2i(0,0), exit_id)

func add_lawlor():
	await get_tree().create_timer(seconds, false).timeout
	LawlorLand.set_cell(Global.player_pos, source_id, Vector2i(0,0), lawlor_id)
