#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 uv_Coord;
layout (location = 3) in vec4 jointIndex;
layout (location = 4) in vec4 jointIndex2;
layout (location = 5) in vec4 weights;
layout (location = 6) in vec4 weights2;

uniform mat4 JointGlobalBindInverse[65];
uniform mat4 Animation[65];

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform float signal;

out vec3 worldNormal;
out vec2 TexCoord;
out vec3 worldPos;

void main()
{
int jointIndex_x = int(jointIndex.x);
int jointIndex_y = int(jointIndex.y);
int jointIndex_z = int(jointIndex.z);
int jointIndex_w = int(jointIndex.w);
int jointIndex2_x = int(jointIndex2.x);
int jointIndex2_y = int(jointIndex2.y);
int jointIndex2_z = int(jointIndex2.z);
int jointIndex2_w = int(jointIndex2.w);

mat4 skinningModel;

if(signal==0.0){
skinningModel = model;
}
else{
skinningModel  = (weights.x*Animation[jointIndex_x]*JointGlobalBindInverse[jointIndex_x] + weights.y*Animation[jointIndex_y]*JointGlobalBindInverse[jointIndex_y] + weights.z*Animation[jointIndex_z]*JointGlobalBindInverse[jointIndex_z] + weights.w*Animation[jointIndex_w]*JointGlobalBindInverse[jointIndex_w] + weights2.x*Animation[jointIndex2_x]*JointGlobalBindInverse[jointIndex2_x] + weights2.y*Animation[jointIndex2_y]*JointGlobalBindInverse[jointIndex2_y] + weights2.z*Animation[jointIndex2_z]*JointGlobalBindInverse[jointIndex2_z] + weights2.w*Animation[jointIndex2_w]*JointGlobalBindInverse[jointIndex2_w]);
}
gl_Position = projection * view * skinningModel * vec4(aPos, 1.0);
worldNormal = mat3(transpose(inverse(skinningModel))) * aNormal;
TexCoord = uv_Coord;
worldPos = vec3(skinningModel * vec4(aPos, 1.0));
}
