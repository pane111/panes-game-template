shader_type canvas_item;

uniform vec4 origin : source_color;
uniform vec4 new : source_color;
uniform bool use_gradient;
uniform float speed : hint_range(0.0, 5.0) = 1.0;
uniform sampler2D color_gradient : source_color;

void fragment() {
	vec4 current_pixel = texture(TEXTURE, UV);
	if (use_gradient==false)
		if (current_pixel == origin)
			COLOR = new;
		else
			COLOR = current_pixel;
	else {
		float time_offset = fract(TIME*speed);
		
		vec4 gradient_col = texture(color_gradient, vec2(time_offset, 0.0));
		if (current_pixel == origin)
			COLOR = gradient_col;
		else
			COLOR = current_pixel;
	}
		
}