shader_type canvas_item;

uniform vec4 shine_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float speed = 1.5;
uniform float width = 0.15;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    float pos = fract(TIME * speed);

    float shine = smoothstep(pos - width, pos, UV.x)
                - smoothstep(pos, pos + width, UV.x);

    vec3 color = tex.rgb + shine * shine_color.rgb * 2.0;

    COLOR = vec4(color, tex.a);
}