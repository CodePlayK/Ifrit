shader_type canvas_item;
uniform float wave_speed =2.0;
uniform float line = 2.0;
uniform vec4 color:source_color;

void fragment() {

	if((
	(
	2.0*abs(cos(wave_speed*TIME))*(UV.x-1.0)>UV.y-1.0-line*0.01&&	
	2.0*abs(cos(wave_speed*TIME))*(UV.x-1.0)<UV.y-1.0&&
	UV.x>0.5&&
	UV.x<0.9)
	||
	(
	-2.0*abs(cos(wave_speed*TIME))*UV.x+1.0>UV.y-line*0.01&&
	-2.0*abs(cos(wave_speed*TIME))*UV.x+1.0<UV.y&&
	UV.x<0.5&&UV.x>0.1)
	)||
	(
	(UV.x-0.5)*(UV.x-0.5)+(UV.y-1.0)*(UV.y-1.0)<.25&&
	2.0*abs(cos(wave_speed*TIME))*(UV.x-1.0)<UV.y-1.0&&
	-2.0*abs(cos(wave_speed*TIME))*UV.x+1.0<UV.y&&
	UV.x>0.1&&
	UV.x<0.9
	)
	)
	{
		COLOR=color;
	}else{
		COLOR.a=0.0;
	}
	
	
}





