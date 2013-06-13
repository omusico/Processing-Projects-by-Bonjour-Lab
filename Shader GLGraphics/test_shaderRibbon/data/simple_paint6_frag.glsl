
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
  float d = 1.0-distance(gl_FragCoord.x, mouse.x)/(0.1*resolution.x); //distance entre les pîxel et la souris
  //float m = 0.0+1.0*cos( time*2.0*PI + d* 2.0*PI * 1.0);  //variation de couleur
  //float m = sin(time* 2.0*PI);//*cos(d* 2.0*PI * 1.0);
  float d2 = 1.0-distance(mouse.x, origine.x)/resolution.x;
  gl_FragColor = vec4(d, d, d, d2)*texture2D( texture, gl_TexCoord[0].st);		
}