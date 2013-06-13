
#ifdef GL_ES
precision mediump float;
#endif


uniform sampler2D texture;
uniform vec2 resolution;
uniform vec2 origine;
uniform float time;
uniform vec2 deplacement;

const float Pi = 3.141592653589793;
void main( void ) {

	float r = (1.0-gl_FragCoord.x/resolution.x + gl_FragCoord.y/resolution.y)/2.0;
	float g = sin((gl_FragCoord.x*0.01+time*5.0))*0.5;
	float b = (gl_FragCoord.x/resolution.x + 1.0-gl_FragCoord.y/resolution.y)/2.0;
	
	gl_FragColor = vec4(r, g, b, 1.0)*texture2D( texture, gl_TexCoord[0].st);
}
