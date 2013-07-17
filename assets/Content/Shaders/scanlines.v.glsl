#version 110
uniform mat4 viewMatrix;
uniform mat4 transformMatrix;
uniform vec2 textureSize;
attribute vec3 position;
attribute vec2 texcoord;
varying vec2 vTexcoord;
varying vec2 vTextureSize;
void main()
{
	gl_Position = viewMatrix * transformMatrix *vec4(position,1);
	vTexcoord = texcoord/textureSize;	
	vTextureSize = textureSize;
}


