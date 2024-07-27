shader_type canvas_item;

uniform vec4 behind_color = vec4(1.0, 0.0, 0.0, 1.0); // Цвет, если спрайт находится позади другого

void vertex() {
	// COLOR = vec4(0.0, 0.0, 0.0, 1.0);
}

void fragment() {

    if (FRAGCOORD.z < 0.0) { 
        COLOR = behind_color;
    }
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
