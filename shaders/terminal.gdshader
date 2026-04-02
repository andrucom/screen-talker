shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	color *= 3.0;
	
	float size = 0.01;
	float size_step = size * 0.1;
	for (float x = -size; x < size; x += size_step) {
		for (float y = -size; y < size; y += size_step) {
			vec2 uv_offset = vec2(x, y);
			vec2 uv_with_offset = SCREEN_UV + uv_offset;
			uv_with_offset = clamp(vec2(0.0), vec2(1.0), uv_with_offset);
			vec4 color_glow = texture(SCREEN_TEXTURE, uv_with_offset);
			color.rgb += color_glow.rgb * 0.03;
		}
	}
	
	vec4 color_scanlines = color * sin((UV.y + TIME * 0.5) * 500.0);
	color = mix(color, color_scanlines, 0.2);
	color += color_scanlines * 0.3;
	
	COLOR = color;
}