R"(
#version 330 core

layout (location = 0) in vec4 position;
layout (location = 1) in vec2 uv;
layout (location = 2) in vec4 color;

uniform mat4 ml_matrix = mat4(1.0);

out DATA {
	vec4 position;
	vec2 uv;
	vec4 color;
} vs_out;

void main() {
	gl_Position = ml_matrix * position;
	vs_out.position = ml_matrix * position;
	vs_out.uv = uv;
	vs_out.color = color;
}
)"