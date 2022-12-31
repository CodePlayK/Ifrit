shader_type canvas_item;

void fragment() {
  COLOR = texture(TEXTURE, UV); //read from texture
  if (COLOR.b>0.5)
  COLOR.b = 1.7; //set blue channel to 1.0
}
void vertex() {
  VERTEX += vec2(10.0, 0.0);
}