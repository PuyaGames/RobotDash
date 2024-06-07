shader_type canvas_item;

const float MATRIX = 2.3999632;
const int ITERATIONS = 200;

void fragment() {
	mat2 rot = mat2(vec2(cos(MATRIX), sin(MATRIX)), vec2(-sin(MATRIX), cos(MATRIX)));
	vec3 acc = vec3(0), div = acc;
	float r = 1.;
	
	for (int j = 0; j < ITERATIONS; j++)
	{  
		r += 1. / r;
		vec3 col = texture(TEXTURE, UV).xyz; 
		col = col * col *1.8;
		vec3 bokeh = pow(col, vec3(4));
		acc += col * bokeh;
		div += bokeh;
	}
	
	COLOR = vec4(acc / div, 1.0);
}