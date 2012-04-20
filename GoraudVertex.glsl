uniform mat4 Projection;
uniform mat4 Modelview;
 
attribute vec4 a_Position;     // Per-vertex position information we will pass in.
uniform vec4 u_Color;        // Per-vertex color information we will pass in.
attribute vec4 a_Normal;       // Per-vertex normal information we will pass in.
 
varying vec4 v_Position;       // This will be passed into the fragment shader.
varying vec4 v_Color;          // This will be passed into the fragment shader.
varying vec4 v_Normal;         // This will be passed into the fragment shader.
 
// The entry point for our vertex shader.
void main()
{
    // Transform the vertex into eye space.
    
    vec4 newPosition = Projection * Modelview * a_Position;
    vec4 newNormal = Projection * Modelview * a_Normal;
    
    v_Position = newPosition;
 
    // Pass through the color.
    v_Color = u_Color;
 
    // Transform the normal's orientation into eye space.
    v_Normal = newNormal;
 
    // gl_Position is a special variable used to store the final position.
    // Multiply the vertex by the matrix to get the final point in normalized screen coordinates.
    gl_Position = newPosition;
}