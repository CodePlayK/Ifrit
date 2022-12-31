shader_type canvas_item;
uniform vec4 color:source_color;
void fragment() {
	// Place fragment code here.
	vec4 old_color=texture(TEXTURE,UV);
	vec4 new_color=color;
	new_color.a=old_color.a;
	COLOR=new_color;
}
