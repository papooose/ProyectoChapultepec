shader_type spatial;
render_mode unshaded, depth_draw_never;

uniform vec4 shine_color : source_color = vec4( 1.0, 1.0, 1.0, 1.0 );



uniform float shine_alpha: hint_range(0.0, 1.0, 0.1) = 1.0;
uniform float cycle_interval : hint_range(0.5, 5.0, 0.5) = 2.5;
uniform float shine_speed : hint_range(1.0, 10.0, 0.5) = 3.0;
uniform float shine_width : hint_range(5.0, 100.0, 5) = 5.0;

uniform float shine_angle_x : hint_range(-90.0, 90.0, 15.0) = 0.0;
uniform float shine_angle_y : hint_range(-90.0, 90.0, 15.0) = 0.0;


mat3 rotation_x(float angle_x)
{
    float cx = cos(radians(angle_x));
    float sx = sin(radians(angle_x));
    return mat3(
        vec3(1.0, 0.0, 0.0),
        vec3(0.0, cx, -sx),
        vec3(0.0, sx, cx)
    );
}



mat3 rotation_matrix(float angle_x, float angle_y)
{
    return rotation_x(shine_angle_x);
}

void fragment( )
{
	vec3 vertex = ( INV_VIEW_MATRIX  * vec4( VERTEX, 1.0 ) ).xyz;

    mat3 rotation = rotation_matrix(shine_angle_x, shine_angle_y);
    vertex = rotation * vertex;

	float width = shine_width * 0.001 * cycle_interval;
	float frequency = floor( sin( vertex.z * cycle_interval + TIME * shine_speed * cycle_interval ) + width);
	ALBEDO = shine_color.rgb;
	ALPHA = clamp( ( 1.0 - dot( NORMAL, VIEW ) ) * frequency * shine_alpha, 0.0, 1.0 );
}