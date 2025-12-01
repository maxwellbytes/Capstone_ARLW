extends AnimationPlayer

#light_flicker anim only plays once then transitions to light_flux
#signal attached to AnimationPlayer
func _on_animation_finished(anim_name: StringName):
	if anim_name == "light_flicker":
		play("light_flux")
