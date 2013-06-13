
#ifdef GL_ES
precision mediump float;
#endif


uniform sampler2D texture;
uniform vec2 resolution;
uniform vec2 origine;
uniform float time;
uniform vec2 deplacement;

const float Pi = 3.141592653589793;


void main() {

	vec2 p = gl_FragCoord.xy/resolution.xy;
	float z = smoothstep(-0.5, 0.5, cos(time*5.0)*0.005);

	gl_FragColor = vec4(p.x, p.y, z, 1.0)*texture2D( texture, gl_TexCoord[0].st); ;

}
	
