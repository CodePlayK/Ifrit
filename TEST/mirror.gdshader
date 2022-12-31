shader_type canvas_item;
uniform float offset_x=150.0;
uniform float mix_value=1.3;
void fragment() {
	float uv_h=SCREEN_PIXEL_SIZE.y/TEXTURE_PIXEL_SIZE.y;
	float uv_w=SCREEN_PIXEL_SIZE.x/TEXTURE_PIXEL_SIZE.x;
	vec2 reflection=vec2(SCREEN_UV.x+0.001*offset_x*uv_w,SCREEN_UV.y);
	COLOR=mix(COLOR,texture(SCREEN_TEXTURE,reflection),mix_value);
}
