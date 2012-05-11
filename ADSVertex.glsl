uniform mat4 Projection;
uniform mat4 Modelview;

attribute vec4 Position; 
attribute vec4 Normal;
uniform vec4 SourceColor;
 
varying vec4 v_Color;
varying vec3 v_Position;       // This will be passed into the fragment shader.
varying vec3 v_Normal;         // This will be passed into the fragment shader.

attribute vec2 TexCoordIn;
varying vec2 TexCoordOut;

void main(void) { 

    vec4 newPosition = Projection * Modelview * Position;
    vec4 newNormal = Projection * Modelview * Normal;
    
    v_Normal = newNormal.xyz;
    v_Position = newPosition.xyz;
    
    gl_Position = newPosition;
    
    v_Color = SourceColor;

    TexCoordOut = TexCoordIn;

}