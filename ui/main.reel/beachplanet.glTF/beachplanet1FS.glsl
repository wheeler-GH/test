precision highp float;
varying vec3 v_normal;
uniform float u_shininess;
varying vec2 v_texcoord0;
uniform sampler2D u_ambient;
uniform sampler2D u_diffuse;
uniform vec4 u_emission;
uniform vec4 u_specular;
uniform float u_transparency;
uniform vec4 u_filterColor;
void main(void) {
vec3 normal = normalize(v_normal);
if (gl_FrontFacing == false) normal = -normal;
vec4 color = vec4(0., 0., 0., 0.);
vec4 diffuse = vec4(0., 0., 0., 1.);
vec4 emission;
vec4 ambient;
vec4 specular;
ambient = texture2D(u_ambient, v_texcoord0);
diffuse = texture2D(u_diffuse, v_texcoord0);
emission = u_emission;
specular = u_specular;
diffuse.xyz *= max(dot(normal,vec3(0.,0.,1.)), 0.);
color.xyz += diffuse.xyz;
color.xyz += emission.xyz;
color = vec4(color.rgb * diffuse.a, diffuse.a * u_transparency);
color *= u_filterColor;
gl_FragColor = color;
}
