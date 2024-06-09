shader_type canvas_item;

uniform float corner_radius = 40.0;

// from 
float rounded_box_sdf(vec2 center_position, vec2 size, float radius) {
    return length(max(abs(center_position) - size + radius, 0.0)) - radius;
}

void fragment() {
	float dis = rounded_box_sdf(vec2(0.5, 0.5), vec2(1.0, 1.0), corner_radius);
	COLOR = mix(vec4(1.0), texture(TEXTURE, UV).rbga, dis);
}

