extends Node2D

const source_id = 0

const exit_id = 1
const player_id = 2
const lawlor_id = 3

var tile_size = 64  # tile size (in pixels)
var width = 15 # width of map (in tiles)
var height = 15 # height of map (in tiles)

var seconds = 5

var rng = RandomNumberGenerator.new()

@onready var Map = $TileMapLayer
@onready var LawlorLand = $Lawlor
# Called when the node enters the scene tree for the first time.
func _ready():
	add_player()
	add_exit()
	add_lawlor()

func add_player():
	if Global.new_level:
		var rd = rng.randi_range(1, 15)
		Global.player_pos = Vector2i(0,rd)
	Map.set_cell(Global.player_pos, source_id, Vector2i(0,0), player_id)

func add_exit():
	if Global.new_level:
		var rd = rng.randi_range(1, 15)
		Global.exit_pos = Vector2i(14,rd)
	Map.set_cell(Global.exit_pos, source_id, Vector2i(0,0), exit_id)
	
func add_lawlor():
	await get_tree().create_timer(seconds).timeout
	LawlorLand.set_cell(Global.player_pos, source_id, Vector2i(0,0), lawlor_id)

	
