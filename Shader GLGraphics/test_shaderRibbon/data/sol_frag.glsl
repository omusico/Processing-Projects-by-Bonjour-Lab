uniform sampler2D tex;
uniform vec2 resolution;

void main()
{
	vec2 center = 0.5*resolution;
	float d = 1.0-distance(gl_FragCoord.xy, center.xy)/(1.0*resolution.x);
	//gl_FragColor = vec4(d, d, d, 1); //outputColor
	gl_FragColor = texture2D(tex, gl_TexCoord[0].st)*d; //outputColor R-V-B-Alpha
}