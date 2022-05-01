#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texMap;
uniform vec3 ambientColor;
uniform float fogIntensity;

varying vec4 vertColor;
varying vec4 vertTexCoord;

varying vec3 lightDir;

void main() {
  vec2 st = vertTexCoord.st;
  vec4 texColor = texture2D(texMap, st);
  vec4 color = vertColor;

  gl_FragColor = mix(color * texColor, vec4(ambientColor, 1.0), pow(gl_FragCoord.z, fogIntensity));
}
