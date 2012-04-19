varying lowp vec4 DestinationColor; 
varying highp float LightIntensity;

void main(void) { 
	gl_FragColor = vec4((DestinationColor * LightIntensity * 0.2).rgb, 1.0);
//    gl_FragColor = DestinationColor; 
}