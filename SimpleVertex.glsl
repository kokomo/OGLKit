attribute vec4 Position; 
attribute vec4 Normal;

uniform vec4 SourceColor;
 
varying vec4 DestinationColor;
 
uniform mat4 Projection;
uniform mat4 Modelview;


varying float LightIntensity;

uniform vec3 LightDirection;
 
void main(void) { 

    vec4 newPosition = Projection * Modelview * Position;
    vec4 newNormal = Projection * Modelview * Normal;
    
    gl_Position = newPosition;
    
    LightIntensity = max(1.0, dot(newNormal.xyz, vec3(10.0,-10.0,10.0)));
    DestinationColor = SourceColor;

}