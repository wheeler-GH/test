precision highp float;
varying vec3 v_normal;
uniform vec3 u_light0Color;
varying vec3 v_light0Direction;
uniform float u_shininess;
uniform vec4 u_ambient;
uniform vec4 u_diffuse;
uniform vec4 u_emission;
uniform vec4 u_specular;
uniform float u_transparency;
uniform vec4 u_filterColor;
void main(void) {
vec3 normal = normalize(v_normal);
vec4 color = vec4(0., 0., 0., 0.);
vec4 diffuse = vec4(0., 0., 0., 1.);
vec3 diffuseLight = vec3(0., 0., 0.);
vec4 emission;
vec4 ambient;
vec4 specular;
vec3 specularLight = vec3(0., 0., 0.);
{
float diffuseIntensity;
float specularIntensity;
vec3 l = normalize(v_light0Direction);
vec3 h = normalize(l+vec3(0.,0.,1.));
diffuseIntensity = max(dot(normal,l), 0.);
specularIntensity = pow(max(0.0,dot(normal,h)),u_shininess);
specularLight += u_light0Color * specularIntensity;
diffuseLight += u_light0Color * diffuseIntensity;
}
ambient = u_ambient;
diffuse = u_diffuse;
emission = u_emission;
specular = u_specular;
specular.xyz *= specularLight;
color.xyz += specular.xyz;
diffuse.xyz *= diffuseLight;
color.xyz += diffuse.xyz;
color.xyz += emission.xyz;
color = vec4(color.rgb * diffuse.a, diffuse.a * u_transparency);
color *= u_filterColor;
gl_FragColor = color;
}