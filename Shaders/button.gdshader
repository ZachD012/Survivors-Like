shader_type canvas_item;

uniform float blur_strength : hint_range(0.1, 20.0) = 0.01;
uniform float blur_boost : hint_range(1.0, 10.0) = 0.01;
uniform vec4 tint_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform bool is_hovered = false;

void fragment() {
    vec2 resolution = vec2(textureSize(TEXTURE, 0));
    vec2 uv = UV;

    // Base texture
    vec4 base = texture(TEXTURE, uv);
    vec4 color = base;

    if (is_hovered) {
        // Blur pass
        vec4 blurred = vec4(0.0);
        float total = 0.0;
        int radius = int(blur_strength);

        for (int x = -radius; x <= radius; x++) {
            for (int y = -radius; y <= radius; y++) {
                vec2 offset = vec2(float(x), float(y)) / resolution;
                float weight = exp(-(float(x * x + y * y)) / (2.0 * blur_strength * blur_strength));
                blurred += texture(TEXTURE, uv + offset) * weight;
                total += weight;
            }
        }

        blurred /= total;

        // Compute "glow only" = blurred minus base
        vec4 glow = max(blurred - base, vec4(0.0)) * blur_boost * tint_color;

        // Combine base + glow
        color = base + glow;
    }

    COLOR = color;
}