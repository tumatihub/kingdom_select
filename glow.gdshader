shader_type spatial;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//ALBEDO = texture(SCREEN_TEXTURE, SCREEN_UV).xyz;
	
	ALPHA = 0.1;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
