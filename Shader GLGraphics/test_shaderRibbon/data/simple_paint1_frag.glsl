
#ifdef GL_ES
precision mediump float;
#endif


uniform sampler2D texture;
uniform vec2 resolution;
uniform vec2 origine;
uniform float time;
uniform vec2 deplacement;

const float Pi = 3.141592653589793;



float sinApprox(float x) {
    x = Pi + (2.0 * Pi) * floor(x / (2.0 * Pi)) - x;
    return (4.0 / Pi) * x - (4.0 / Pi / Pi) * x * abs(x);
}

float cosApprox(float x) {
    return sinApprox(x + 0.5 * Pi);
}


void main()
{
	vec2 center = 0.5*resolution;
	//float d = 1.0-distance(gl_FragCoord.xy, origine.xy)/resolution.x; //distance entre les pîxel et de l'origine du vecteur
	//float d2 = 1.0-distance(gl_FragCoord.xy, center.xy)/resolution.x; //distance entre les pîxel et le centre
	//float m = 0.3+0.5*cos( time*2.0*PI + d* 2.0*PI * 2.0);  //variation de couleur
	float d = 1.0-distance(gl_FragCoord.xy, origine.xy)/(0.5*resolution.x); //distance entre les pîxel et la souris
	float d2 = 0.5-distance(gl_FragCoord.xy,  center.xy)/resolution.x;

	vec2 p=(2.0*gl_FragCoord.xy-resolution)/max(resolution.x,resolution.y);
	for(int i=1;i<50;i++)
	{
		vec2 newp=p;
		newp.x+=0.6/float(i)*sin(float(i)*p.y+time+0.3*float(i))+1.0;
		newp.y+=0.6/float(i)*sin(float(i)*p.x+time+0.3*float(i+10))-1.4;
		p=newp;
	}
	vec3 col=vec3(0.5*sin(3.0*p.x)+0.5,0.5*sin(3.0*p.y)+0.5,sin(p.x+p.y));
	
	gl_FragColor = vec4(col, 1.0)*texture2D( texture, gl_TexCoord[0].st); //outputColor R-V-B-Alpha
}
