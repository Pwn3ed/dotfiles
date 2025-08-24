#define FONT_GREEN vec3(0.0, 1.0, 0.0)      // desired font color
#define BLACK_BLEND_THRESHOLD 0.4           // threshold to detect font pixels

void mainImage(out vec4 fragColor, vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;

    // Sample terminal texture
    vec4 terminalColor = texture(iChannel0, uv);

    // Detect font pixels using luminance
    float luminance = dot(terminalColor.rgb, vec3(0.299, 0.587, 0.114));

    // Font color
    vec3 col = FONT_GREEN;

    // Blend font with terminal background like original shader
    float alpha = step(BLACK_BLEND_THRESHOLD, luminance); // only pixels above threshold are font
    vec3 blendedColor = mix(terminalColor.rgb * 1.2, col, alpha);

    fragColor = vec4(blendedColor, terminalColor.a);
}
