shader_type canvas_item;
uniform vec2 r_displacement = vec2(3.0, 1.0);
uniform vec2 g_displacement = vec2(0.0, 0.0);
uniform vec2 b_displacement = vec2(-3.0, -1.0);
uniform float chromatic_scale = 1.0;
uniform float core_size = 100;
uniform float core_chromatic = 100;
uniform float edge_chromatic_scale = 100;
uniform bool block_core = false;
uniform bool block_edge = false;
uniform sampler2D offset_image;


const float offset=0.5;
vec4 chromatic_text(sampler2D texture1,vec2 uv1,vec2 size,float scale){
	float r = textureLod(texture1, uv1 + vec2(size*r_displacement*scale), 0.0).r;
	float g = textureLod(texture1, uv1 + vec2(size*g_displacement*scale), 0.0).g;
	float b = textureLod(texture1, uv1 + vec2(size*b_displacement*scale), 0.0).b;
	return vec4(r, g, b, 1.0);
}
void fragment() {
	if ((SCREEN_UV.x-offset)*(SCREEN_UV.x-offset)+(SCREEN_UV.y-offset)*(SCREEN_UV.y-offset)>0.1*core_size*0.01){
	if (!block_edge){
	COLOR = mix(COLOR,chromatic_text(SCREEN_TEXTURE,SCREEN_UV,SCREEN_PIXEL_SIZE,chromatic_scale*core_chromatic*0.01*edge_chromatic_scale*0.01),1.0);
	}}
	else{
	if (!block_core){
	COLOR = mix(COLOR,chromatic_text(SCREEN_TEXTURE,SCREEN_UV,SCREEN_PIXEL_SIZE,chromatic_scale*core_chromatic*0.01),1.0);
	}}
	//COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV,0.6);
}

