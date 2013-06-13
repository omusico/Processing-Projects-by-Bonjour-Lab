//blendMode Algorythme create by Robert Menzel (@renderpipeline) 
//Link : http://renderingpipeline.com/2012/06/photoshop-blendmodi-glsl/

uniform sampler2D offscreen1; //sampler2D is texture in GPU
uniform sampler2D offscreen2; //sampler2D is texture in GPU
uniform int choice;

void main()
{
	vec4 texColor = texture2D(offscreen1, gl_TexCoord[0].xy);
	vec4 texMask = texture2D(offscreen2, gl_TexCoord[0].xy);
	vec4 blendMode;

	if (texColor.r < 0.5) {
    		blendMode = 2.0 * texColor * texMask;
		} else {
    		blendMode = vec4(1.0) - 2.0 * (vec4(1.0) - texMask) * (vec4(1.0) - texColor);
		}
		if (texColor.g < 0.5) {
    		blendMode = 2.0 * texColor * texMask;
		} else {
    		blendMode = vec4(1.0) - 2.0 * (vec4(1.0) - texMask) * (vec4(1.0) - texColor);
		}
		if (texColor.b < 0.5) {
    		blendMode = 2.0 * texColor * texMask;
		} else {
    		blendMode = vec4(1.0) - 2.0 * (vec4(1.0) - texMask) * (vec4(1.0) - texColor);
		}
		if (texColor.a < 0.5) {
    		blendMode = 2.0 * texColor * texMask;
		} else {
    		blendMode = vec4(1.0) - 2.0 * (vec4(1.0) - texMask) * (vec4(1.0) - texColor);
		}
	
	gl_FragColor = blendMode;
}