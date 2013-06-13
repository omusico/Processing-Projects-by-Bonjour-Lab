
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

	vec2 p = ( gl_FragCoord.xy / resolution.xy ) * .5 * sin(time);	

	float f = 5.*pow(p.x,3.)-8.*pow(p.y,2.)+3.*p.x-p.y;
	
	float color;
	color = sqrt(f);

	gl_FragColor = vec4( vec3( 0.1, color * 0.5, sin( color + time / 3.0 ) ), 1.0 )*texture2D( texture, gl_TexCoord[0].st); ;

}
	
