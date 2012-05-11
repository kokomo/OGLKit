precision mediump float;

varying lowp vec4 v_Color; 

uniform vec3 u_LightPos;

varying vec3 v_Position;
varying vec3 v_Normal;

varying lowp vec2 TexCoordOut;
uniform sampler2D Texture;

void main(void) { 

    vec3 lightVector = u_LightPos; //normalize(u_LightPos - v_Position);

    float diff = max(0.0, dot(normalize(v_Normal), normalize(lightVector)));

    float diffuse = max(dot(v_Normal, lightVector), 0.25) * 0.1; //.2

    gl_FragColor = diff * (diffuse * texture2D(Texture, TexCoordOut));
    gl_FragColor += (texture2D(Texture, TexCoordOut) * 0.45); //.15 //gl_FragColor += (v_Color * texture2D(Texture, TexCoordOut) * 0.45); //.15


    vec3 vReflection = normalize(reflect(-normalize(lightVector),normalize(v_Normal)));
 
    float spec = max(0.0, dot(normalize(v_Normal), vReflection));

    if (diff != 0.0) {
        float fSpec = pow(spec, 64.0);
        gl_FragColor.rgb += vec3(fSpec, fSpec, fSpec);
    }

}