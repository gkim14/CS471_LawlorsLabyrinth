extends Node2D

const source_id = 0

const exit_id = 1
const player_id = 2

var tile_size = 64  # tile size (in pixels)
var width = 15 # width of map (in tiles)
var height = 15 # height of map (in tiles)

var rng = RandomNumberGenerator.new()

@onready var Map = $TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready():
	add_player()
	add_exit()

func add_player():
	var rd = rng.randi_range(1, 15)
	Map.set_cell(Vector2i(0,rd), source_id, Vector2i(0,0), player_id)

func add_exit():
	var rd = rng.randi_range(1, 15)
	Map.set_cell(Vector2i(14, rd), source_id, Vector2i(0,0), exit_id)
	
