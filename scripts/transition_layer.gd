extends CanvasLayer

@onready var overlay: ColorRect = $ColorRect
var tween: Tween
var initialized = false

func _ready():
	overlay.visible = true
	overlay.modulate.a = 0.0
	initialized = true

func fade_in(duration: float = 0.5) -> void:
	if not initialized:
		push_error("transition_layer.fade_in called before initialized")
		return
		
	tween = create_tween()
	tween.tween_property(overlay, "modulate:a", 1.0, duration)
	await tween.finished

func fade_out(duration: float = 0.5) -> void:
	if not initialized:
		push_error("transition_layer.fade_out called before initialized")
		return
		
	tween = create_tween()
	tween.tween_property(overlay, "modulate:a", 0.0, duration)
	await tween.finished
