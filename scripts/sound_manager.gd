extends Node

@onready var sfx_player = AudioStreamPlayer.new()
@onready var music_player = AudioStreamPlayer.new()
@onready var ui_player = AudioStreamPlayer.new()

var sounds = {
	# Game SFX
	"player_move": preload("res://assets/sounds/sfx/sfx_vehicle_carloop1.ogg"),
	"enemy_chase": preload("res://assets/sounds/sfx/sfx_alarm_loop3.wav"),
	"enemy_catch": preload("res://assets/sounds/sfx/sfx_deathscream_robot1.wav"),
	"next_level": preload("res://assets/sounds/sfx/sfx_sounds_fanfare3.wav"),
	"background_music": preload("res://assets/sounds/music/Juhani Junkala [Retro Game Music Pack] Ending.ogg"),
	"title_music": preload("res://assets/sounds/music/doubts_loop.ogg"),
	
	# UI SFX
	"ui_start": preload("res://assets/sounds/sfx/sfx_menu_select4.wav"),
	"ui_hover": preload("res://assets/sounds/sfx/sfx_menu_move4.wav"),
	"ui_pause_open": preload("res://assets/sounds/sfx/sfx_sounds_pause2_in.wav"),
	"ui_pause_close": preload("res://assets/sounds/sfx/sfx_sounds_pause2_out.wav"),
	"ui_game_over": preload("res://assets/sounds/sfx/GameOver.wav"),
	"ui_press": preload("res://assets/sounds/sfx/sfx_sounds_button7.wav")
}

var looping_sounds = {}

func _ready():
	add_child(sfx_player)
	add_child(music_player)
	add_child(ui_player)
	
	sfx_player.bus = "SFX"
	music_player.bus = "Music"
	ui_player.bus = "UI"
	
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	music_player.process_mode = Node.PROCESS_MODE_ALWAYS

# One-shot SFX
func play_sfx(sound_name: String, volume: float = -15.0):
	if not sounds.has(sound_name): return
	var player = AudioStreamPlayer.new()
	player.stream = sounds[sound_name]
	player.volume_db = volume
	player.bus = "SFX"
	add_child(player)
	player.play()
	
	player.finished.connect(func(p = player):
		if is_instance_valid(p):
			p.queue_free()
	)

# Music
func play_music(sound_name: String, loop = true, fade_in = false):
	if not sounds.has(sound_name): return
	music_player.stream = sounds[sound_name]
	music_player.stream.loop = loop
	if fade_in:
		music_player.volume_db = -40
		music_player.play()
		var tween = create_tween()
		tween.tween_property(music_player, "volume_db", -10, 1.0)
	else:
		music_player.volume_db = -10
		music_player.play()

func stop_music(fade_out = false):
	if fade_out:
		var tween = create_tween()
		tween.tween_property(music_player, "volume_db", -40, 0.5)
		tween.finished.connect(func(): 
			if is_instance_valid(music_player):
				music_player.stop()
		)
	else:
		music_player.stop()

func lower_music_volume(target_db: float = -20.0, duration: float = 1.0):
	if not music_player.playing:
		return
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", target_db, duration)

func restore_music_volume(target_db: float = -10.0, duration: float = 1.0):
	if not music_player.playing:
		return
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", target_db, duration)

# Looping SFX
func create_looping_sfx(sound_name: String, volume: float = 0.0):
	if not sounds.has(sound_name):
		return
	var player = AudioStreamPlayer.new()
	player.bus = "SFX"
	player.volume_db = volume
	player.stream = sounds[sound_name]
	if player.stream is AudioStreamOggVorbis:
		player.stream.loop = true
	add_child(player)
	looping_sounds[sound_name] = player

func play_looping_sfx(sound_name: String, volume: float = -23):
	if not looping_sounds.has(sound_name):
		create_looping_sfx(sound_name, volume)
	var player = looping_sounds[sound_name]
	if not is_instance_valid(player):
		create_looping_sfx(sound_name, volume)
		player = looping_sounds[sound_name]
	
	player.volume_db = volume
	if player.stream is AudioStreamOggVorbis:
		player.stream.loop = true
		
	if not player.playing:
		player.play()

func stop_looping_sfx(sound_name: String, fade_out: float = 0.3):
	if not looping_sounds.has(sound_name):
		return
	var player = looping_sounds[sound_name]
	if not is_instance_valid(player):
		looping_sounds.erase(sound_name)
		return
	
	# Fade out with tween
	if fade_out > 0.0:
		var tween = create_tween()
		tween.tween_property(player, "volume_db", -40, fade_out)
		tween.finished.connect(func(p = player):
			if is_instance_valid(p):
				p.stop()
				p.volume_db = -23
		)
	else:
		player.stop()
		player.volume_db = -23

# Stop all active SFX
func stop_sounds():
	sfx_player.stop()
	for key in looping_sounds.keys():
		stop_looping_sfx(key)
