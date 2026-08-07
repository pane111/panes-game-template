shader_type canvas_item;

uniform vec2 direction=vec2(1.0,0.0);
uniform float amount:hint_range(0.0, 1.0, 0.1);
uniform float smoothness : hint_range(0.0, 1.0) = 0.05;
uniform vec4 modulate : source_color;

void fragment() {
	vec2 dir = length(direction) > 0.0 ? normalize(direction) : vec2(1.0, 0.0);
	vec2 centered_uv = UV - vec2(0.5);
	float projection = dot(centered_uv, dir);
	float threshold = projection + 0.5;
	float edge0 = amount * (1.0 + smoothness);
	float edge1 = edge0 - smoothness;
	float mask = smoothstep(edge1, edge0, threshold);
	vec4 tex_color = texture(TEXTURE, UV);
	COLOR = tex_color * modulate;
	COLOR.a *= mask;
	
}
