extends Button

@onready var burger: AnimatedSprite2D = $burger
@onready var grease_counter: Label = $greaseCounter
@onready var click_multipler_button: Button = $ClickMultiplerButton
@onready var click_sound_effect: AudioStreamPlayer2D = $ClickSoundEffect

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	assert(burger, "Node 'burger' not found!")
	assert(grease_counter, "Node 'greaseCounter' not found!")
	assert(click_multipler_button, "Node 'ClickMultiplerButton' not found!")
	assert(click_sound_effect, "Node 'ClickSoundEffect' not found!")

func _on_pressed() -> void:
	Global.greasePoints += Global.clickMultiplier
	grease_counter.text = str(round(Global.greasePoints))
	click_sound_effect.play()
	burger.scale.x = 0.28
	burger.scale.y = 0.28
	await get_tree().create_timer(0.1).timeout
	burger.scale.x = 0.3
	burger.scale.y = 0.3

func _on_click_multipler_pressed() -> void:
	rng.randomize()
	if Global.greasePoints >= Global.clickPrice:
		Global.clickMultiplier += 1
		Global.greasePoints -= Global.clickPrice
		grease_counter.text = str(round(Global.greasePoints))
		Global.clickPrice *= rng.randf_range(1.4, 2.1)
		click_multipler_button.text = "+1 Grease Point Per Click\nCost: " + str(round(Global.clickPrice))
