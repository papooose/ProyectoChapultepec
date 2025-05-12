shader_type spatial;
render_mode cull_disabled, depth_draw_always; // NO LIGHTING!, "depth_draw_always" to 'fix' Z-ordering

uniform bool warp_ScreenSpace = false;
uniform sampler2D texture_albedo : source_color, filter_nearest;


uniform sampler2D noise;
uniform sampler2D gradient;
uniform float emission_strength = 1.0;
uniform float burn : hint_range(0.0, 1.0, 0.01) = 0.0;




void fragment() {
	vec2 uv = vec2(0.0);

	if(warp_ScreenSpace){
		uv = SCREEN_UV;
	}else{
		uv = UV;
	}

	// TODO: ADD NOISE SAMPLER INSTEAD OF USING TRIG?
	// TWEAK THE COEFFS AND/OR EQUATION FOR A DIFFERENT WARP PATTERN
	uv.x += sin(uv.y * 1.54 * PI + TIME) * cos(uv.y * 1.31 * PI + TIME) * 0.1;
	uv.y += cos(uv.x * 1.74 * PI + TIME) * -sin(uv.y * 1.64 * PI + TIME) * 0.1;
	vec4 color = texture(texture_albedo, uv * 2.0);
	float noise_value = texture(noise, UV).r * 0.5;
	if (noise_value < burn) {
		float gradient_coord = clamp(burn - noise_value, 0.01, 0.99);
		vec4 gradient_color = texture(gradient, vec2(gradient_coord, 1.0));
		color *= gradient_color;
		float gradient_intensity = (
			abs(gradient_color.r - gradient_color.g) +
			abs(gradient_color.r - gradient_color.b) +
			abs(gradient_color.b - gradient_color.g)
		) / 3.0;
		EMISSION = gradient_color.rgb * gradient_intensity * emission_strength;
	}

	ALBEDO = color.rgb;
	ALPHA = color.a;
}
