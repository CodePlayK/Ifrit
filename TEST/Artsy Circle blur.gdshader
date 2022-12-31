shader_type canvas_item;

uniform float v = 1.0; 
uniform float size = 10.0;
void fragment() {
	vec4 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0);
	for (float x = -size; x < size; x++)
	{
		for (float y = -size; y < size; y++)
		{
			if (x*x + y*y > size*size){continue;}
			vec4 new_c = texture(SCREEN_TEXTURE, SCREEN_UV+SCREEN_PIXEL_SIZE*vec2(x, y));
			if (length(new_c) >length(c)){
				c = new_c;
			}
		}
	}
	COLOR = c;
	
}