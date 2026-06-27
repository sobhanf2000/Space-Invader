shader_type canvas_item;

uniform float hit_flash : hint_range(0.0, 1.0) = 0.0;
uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    vec3 final_color = mix(tex.rgb, flash_color.rgb, hit_flash);

    COLOR = vec4(final_color, tex.a);
}