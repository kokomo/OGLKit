precision mediump float;

varying lowp vec4 v_Color; 

uniform vec3 u_LightPos;

varying vec3 v_Position;
varying vec3 v_Normal;

void main(void) { 
    
    float distance = length(u_LightPos - v_Position);
 
    // Get a lighting direction vector from the light to the vertex.
    vec3 lightVector = normalize(u_LightPos - v_Position);
     
    // Calculate the dot product of the light vector and vertex normal. If the normal and light vector are
    // pointing in the same direction then it will get max illumination.
    float diffuse = max(dot(v_Normal, lightVector), 0.1);
 
    // Add attenuation.
    diffuse = diffuse * (1.0 / (1.0 + (0.25 * distance * distance)));
 
    // Multiply the color by the diffuse illumination level to get final output color.
    
    gl_FragColor = v_Color * diffuse;

}