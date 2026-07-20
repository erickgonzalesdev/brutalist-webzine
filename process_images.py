#!/usr/bin/env python3
"""
1. Remove white/checkerboard background from PNGs (make it transparent)
2. Generate pixel-accurate meander ascii-art contour maps
"""
import sys
from PIL import Image

def remove_bg(path, out_path, bg_threshold=210):
    img = Image.open(path).convert("RGBA")
    pixels = img.load()
    w, h = img.size
    for y in range(h):
        for x in range(w):
            r, g, b, a = pixels[x, y]
            if r > bg_threshold and g > bg_threshold and b > bg_threshold:
                pixels[x, y] = (r, g, b, 0)
    img.save(out_path)
    print(f"Saved: {out_path} ({w}x{h})")

def gen_contour(path, name, cols=24, rows=24, bg_threshold=210):
    img = Image.open(path).convert("RGBA")
    w, h = img.size
    pixels = img.load()

    lines = []
    for row in range(rows):
        line = ""
        for col in range(cols):
            hits = 0
            for dr in [0.25, 0.5, 0.75]:
                for dc in [0.25, 0.5, 0.75]:
                    px = min(int((col + dc) * w / cols), w - 1)
                    py = min(int((row + dr) * h / rows), h - 1)
                    r, g, b, a = pixels[px, py]
                    if a > 30:
                        hits += 1
            line += "#" if hits >= 5 else " "
        lines.append(line)

    print(f"\n#let contour-{name} = meander.contour.ascii-art(")
    print("  ```")
    for line in lines:
        print(line)
    print("  ```")
    print(")")

if __name__ == "__main__":
    images = [
        ("47-472115_counter-strike-png-transparent-png.png",   "soldiers.png", "soldiers"),
        ("cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDI0LTAzL3Jhd3BpeGVsX29mZmljZV8yMl9waG90b19vZl93ZWFwb25faXNvbGF0ZWRfb25fY2xlYXJfd2hpdGVfYmFja19mMDYwNTg1Ni0zNGU1LTQ1OWQtYjNkOS1hOWNkMjQ0ZjE1ODBfMS5wbmc.png", "rifle.png",    "rifle"),
        ("cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTExL3Jhd3BpeGVsX29mZmljZV8yNF9waG90b19vZl90b3lfYmxhY2tfaGFuZGd1bl9pc29sYXRlZF93aGl0ZV9iYV9hZmQ5MmZhNC1lZTM5LTQyZGItYjM4NC1lM2YzOWU0MTUxNDMucG5n.png", "handgun.png",  "handgun"),
    ]
    for src, dst, name in images:
        remove_bg(src, dst)
        # Crop to content bounding box so contour grid aligns with figure exactly
        img = Image.open(dst).convert("RGBA")
        bbox = img.getbbox()
        if bbox:
            img = img.crop(bbox)
            img.save(dst)
            print(f"Cropped {dst} to {img.size}")
        gen_contour(dst, name)
