
#ifdef GL_ES
precision mediump float;
#endif


uniform sampler2D texture;
uniform vec2 resolution;
uniform vec2 origine;
uniform float time;
uniform vec2 deplacement;
uniform vec2 fin;
uniform float place;

const float Pi = 3.141592653589793;

void main() {	
  float d2 = 1.0-distance(gl_FragCoord.xy, fin.xy)/resolution.x;
  float d = place;
  gl_FragColor = vec4(1.0, 1.0, 1.0, d)*texture2D( texture, gl_TexCoord[0].st);		
}