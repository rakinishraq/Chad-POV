shader_type canvas_item;

void fragment() {
    float alpha = texture(TEXTURE, UV).a;
    COLOR.a = step(0.1, alpha);
}