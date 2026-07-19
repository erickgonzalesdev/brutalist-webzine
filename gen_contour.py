#!/usr/bin/env python3
"""
Read a PNG's alpha channel and output a meander ascii-art contour map.
Usage: python3 gen_contour.py <image.png> <cols> <rows> [alpha_threshold]
"""
import sys
from PIL import Image

def gen_contour(path, cols=20, rows=20, threshold=30):
    img = Image.open(path).convert("RGBA")
    w, h = img.size
    pixels = img.load()

    # Check if image has real alpha or baked-in white background
    corners = [(0,0),(w-1,0),(0,h-1),(w-1,h-1)]
    has_alpha = any(pixels[x,y][3] < 200 for x,y in corners)

    lines = []
    for row in range(rows):
        line = ""
        for col in range(cols):
            # Sample a small cluster of points per cell for accuracy
            hits = 0
            samples = 0
            for dr in [0.3, 0.5, 0.7]:
                for dc in [0.3, 0.5, 0.7]:
                    px = int((col + dc) * w / cols)
                    py = int((row + dr) * h / rows)
                    px = min(px, w-1)
                    py = min(py, h-1)
                    r, g, b, a = pixels[px, py]
                    samples += 1
                    if has_alpha:
                        if a > threshold:
                            hits += 1
                    else:
                        # White/near-white = background, anything else = figure
                        if not (r > 210 and g > 210 and b > 210):
                            hits += 1
            line += "#" if hits > samples // 2 else " "
        lines.append(line)

    # Print as a Typst raw block
    print("meander.contour.ascii-art(")
    print("  ```")
    for line in lines:
        print(line)
    print("  ```")
    print(")")

if __name__ == "__main__":
    path = sys.argv[1]
    cols = int(sys.argv[2]) if len(sys.argv) > 2 else 20
    rows = int(sys.argv[3]) if len(sys.argv) > 3 else 20
    threshold = int(sys.argv[4]) if len(sys.argv) > 4 else 30
    gen_contour(path, cols, rows, threshold)
