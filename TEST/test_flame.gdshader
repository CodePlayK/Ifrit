shader_type canvas_item;

uniform float radius = 0.45;
uniform float blur = 0.01;
uniform float ellipticity = 1.2;

void fragment(){
	float color;
	vec2 uv = SCREEN_UV - .5;
	uv.y *= -1.;
	color = smoothstep(radius, radius - blur, length(vec2(uv.x * ellipticity, uv.y + abs(uv.y) * step(.5, radius))));
	color *= 1. - smoothstep(-0.4, 0.6, uv.y);
	//color += 0.4 - abs(uv.x);
	
	uv = vec2(SCREEN_UV.x, SCREEN_UV.y);
	float n = texture(SCREEN_TEXTURE, uv+TIME).r;
	
	float red = step(.4, color * .3 + n * .4);
	float green = step(.5, color * .3 + n * .4);
	float blue = step(.6, color * .3 + n * .4);
	
	COLOR = vec4(vec3(red, green, blue), red);
}