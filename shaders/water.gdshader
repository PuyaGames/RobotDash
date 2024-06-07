shader_type canvas_item;

uniform float blur_radius = 0.0;
uniform sampler2D noise_texture;
uniform float speed = 0.1;
uniform float strength = 0.02;

const float MATRIX = 2.3999632;
const int ITERATIONS = 200;

// From: https://www.bilibili.com/video/BV1sh4y1Z73u/
vec3 blur(sampler2D tex, vec2 uv, float radius)
{
	mat2 rot = mat2(vec2(cos(MATRIX), sin(MATRIX)), vec2(-sin(MATRIX), cos(MATRIX)));
	vec3 acc = vec3(0), div = acc;
	float r = 1.;
	vec2 vangle = vec2(0.0,radius*.01 / sqrt(float(ITERATIONS)));
	
	for (int j = 0; j < ITERATIONS; j++)
	{  
		r += 1. / r;
		vangle = rot * vangle;
		vec3 col = texture(tex, uv + (r-1.) * vangle).xyz; 
		col = col * col *1.8;
		vec3 bokeh = pow(col, vec3(4));
		acc += col * bokeh;
		div += bokeh;
	}
	
	return acc / div;
}

void fragment() {
	float noise = texture(noise_texture, fract(UV + TIME * speed)).r;
	
	COLOR = vec4(blur(TEXTURE, UV - noise * strength, blur_radius), 1.0);
}