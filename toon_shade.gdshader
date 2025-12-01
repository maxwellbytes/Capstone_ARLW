shader_type spatial;
render_mode diffuse_burley, specular_disabled;

uniform int shade_levels : hint_range(2, 8) = 4;
uniform vec4 base_color : source_color = vec4(1.0);
uniform sampler2D albedo_texture;
uniform bool use_texture = false;

// small ambient fallback (tune in inspector)
uniform vec3 ambient_color : source_color = vec3(0.06);

// rim settings
uniform float rim_strength : hint_range(0.0, 1.0) = 0.25;
uniform float rim_exponent : hint_range(1.0, 8.0) = 3.0;

void fragment() {
    // set the material's albedo (keeps your Base/texture)
    vec3 albedo = base_color.rgb;
    if (use_texture) {
        albedo *= texture(albedo_texture, UV).rgb;
    }
    ALBEDO = albedo;
}

// light() runs per light; DIFFUSE_LIGHT and SPECULAR_LIGHT are the outputs
void light() {
    // --- accumulate this light's diffuse contribution (no ALBEDO mul here) ---
    float NdotL = max(dot(NORMAL, LIGHT), 0.0);
    float diff = NdotL * ATTENUATION;                // include light attenuation
    DIFFUSE_LIGHT += diff * LIGHT_COLOR;             // accumulate light color/intensity

    // --- optional rim (view-dependent), add into accumulated light ---
    float rim = pow(1.0 - clamp(dot(NORMAL, VIEW), 0.0, 1.0), rim_exponent) * rim_strength;
    // you can gate rim to lit areas with step(...) if desired:
    float lit_mask = step(0.0, NdotL); // 1 when lit, 0 when backfacing (tweak if needed)
    DIFFUSE_LIGHT += vec3(rim * lit_mask);

    // --- now compute quantized final brightness from the *accumulated* light ---
    vec3 total_light = clamp(DIFFUSE_LIGHT + ambient_color, 0.0, 1.0);

    // use luminance so color is preserved, but bands are based on brightness
    float lum = dot(total_light, vec3(0.299, 0.587, 0.114));
    float levels = float(max(shade_levels, 2));
    float q = floor(lum * levels) / (levels - 1.0);

    // Write the final quantized result into SPECULAR_LIGHT *as* the output,
    // then subtract the normal (unquantized) diffuse that would otherwise be added.
    // The engine composes final_color = ALBEDO * DIFFUSE_LIGHT + SPECULAR_LIGHT,
    // so by setting SPECULAR_LIGHT = ALBEDO * q - ALBEDO * DIFFUSE_LIGHT,
    // final_color becomes ALBEDO * q (i.e. quantized lighting of your albedo).
    SPECULAR_LIGHT = ALBEDO * vec3(q);
    SPECULAR_LIGHT -= ALBEDO * DIFFUSE_LIGHT;
}
