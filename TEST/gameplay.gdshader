shader_type canvas_item;

uniform sampler2D noise;
uniform float radius = 0.45;
uniform float blur = 0.01;
uniform float ellipticity = 1.2;

void fragment(){
	vec4 base=texture(TEXTURE,UV);
	vec4 noise_t=texture(noise,vec2(UV.x,UV.y+TIME));
	COLOR=mix(base,noise_t,.5);
	
}