shader_type canvas_item;

uniform int pixel_size : hint_range(1, 32) = 4;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void fragment() {
	//texture size gives actual screen resolution
	vec2 screen_res = vec2(textureSize(SCREEN_TEXTURE, 0));
    vec2 uv = SCREEN_UV * screen_res;

    // Snap to nearest "pixel_size" block
    uv = floor(uv / float(pixel_size)) * float(pixel_size);

    // Convert back to normalized UVs
    uv /= screen_res;

    COLOR = texture(SCREEN_TEXTURE, uv);

    //vec2 uv = SCREEN_UV;

    //cast pixel_size to float for math
    //float size = float(pixel_size);

    //snap UVs to pixel blocks
    //uv = floor(uv * size) / size;

    //COLOR = texture(SCREEN_TEXTURE, uv);
}
