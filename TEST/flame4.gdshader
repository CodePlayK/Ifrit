shader_type canvas_item;
uniform float wave_speed = 2.0;
uniform float line = 2.0;


void fragment() {
	COLOR=texture(TEXTURE,UV);
	if(
	2.0*abs(cos(wave_speed*TIME))*(UV.x-1.0)>UV.y-1.0-line*0.01
	&&	
	2.0*abs(cos(wave_speed*TIME))*(UV.x-1.0)<UV.y-1.0
	&&UV.x>0.5
	){
		COLOR=COLOR;
	}else{
		if(
	UV.x-1.0 <UV.y
	&&
	-2.0*abs(cos(wave_speed*TIME))*UV.x+1.0>UV.y-line*0.01
	&&-2.0*abs(cos(wave_speed*TIME))*UV.x+1.0<UV.y
	&& UV.x<0.5
	){
	}else{
		COLOR.a=0.0;
		}
	}
}
