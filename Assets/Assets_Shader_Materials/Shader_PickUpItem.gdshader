shader_type spatial;
render_mode unshaded;

// fragment uniforms

uniform bool active = false; // Sets pixels to flash color when true
uniform vec4 flash_color: source_color = vec4(1.0,1.0,1.0,1.0); // The color to use when active

uniform sampler2D texuture_a;

uniform float alpha: hint_range(0.0, 1.0, 0.005) = 1.0;
uniform vec3 tintColor : source_color;
uniform float fesnelAmount : hint_range(0.0, 5.0, 0.1);

// vertex uniforms
uniform float distortionVertex : hint_range(0.0, 0.3, 0.005) = 0.03;
uniform float speedVertex : hint_range(0.0, 1.0, 0.005) = 0.1;
uniform sampler2D noiseVertex;


float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void vertex() {
	float noiseVal = (texture(noiseVertex, UV + (TIME * speedVertex)).r * 2.0) - 1.0; // Range: -1.0 to 1.0
	vec3 displacement = NORMAL * noiseVal * distortionVertex;
	VERTEX = VERTEX + displacement;
}

void fragment() {
	vec4 col = texture(texuture_a,UV);
	vec4 set_col = col;
	if(active == true) {
		set_col = flash_color;
		}

	vec3 baseTexture = vec3(texture(texuture_a,UV).rgb);
	vec3 fesnelTint = (tintColor * fresnel(fesnelAmount, NORMAL, VIEW));
	
	vec4 texture_color = texture(texuture_a,UV);
	ALBEDO = baseTexture + vec3(set_col.r,set_col.g,set_col.b);
	ALPHA = alpha;
}


//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}