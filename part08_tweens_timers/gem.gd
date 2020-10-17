extends Area2D

onready var effect = get_node("effect")
onready var sprite = get_node("sprite")

signal gem_grabbed

func _ready():
	effect.interpolate_property(sprite, 'scale',
			sprite.get_scale(), Vector2(2.0, 2.0), 0.3,
			Tween.TRANS_QUAD, Tween.EASE_OUT)
	effect.interpolate_property(sprite, 'modulate',
			Color(1, 1, 1, 1), Color(1, 1, 1, 0), 2.0,
			Tween.TRANS_QUAD, Tween.EASE_OUT)

func _on_gem_area_entered( area ):
	if area.get_name() == "player":
		emit_signal("gem_grabbed")
		effect.start()


func _on_effect_tween_completed(object, key):
	queue_free()


