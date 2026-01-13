#!/usr/bin/env python3
"""
Generate white-on-transparent notification PNGs for Android drawable densities.

Usage:
  python generate_notification_icons.py --input path/to/logo.png

This script:
- Loads the input image (logo with any background)
- Extracts a white (light) mask from the image
- Renders a white silhouette on transparent background
- Produces PNGs for mdpi/hdpi/xhdpi/xxhdpi/xxxhdpi under
  android/app/src/main/res/drawable-*/ic_stat_jibli.png

Requires: Pillow (install with `pip install pillow`)
"""

import os
import argparse
from PIL import Image, ImageOps

# Target sizes for notification small icon (24dp base)
SIZES = {
    'drawable-mdpi': 24,
    'drawable-hdpi': 36,
    'drawable-xhdpi': 48,
    'drawable-xxhdpi': 72,
    'drawable-xxxhdpi': 96,
}

OUT_BASE = os.path.join('android', 'app', 'src', 'main', 'res')


def make_white_silhouette(img: Image.Image) -> Image.Image:
    img = img.convert('RGBA')
    # Create grayscale image and use it to build a mask for light areas
    gray = img.convert('L')
    # Invert if background is white: we want light parts (logo) as mask
    # Use adaptive threshold: pixels brighter than 128 considered foreground
    mask = gray.point(lambda p: 255 if p > 128 else 0)

    # Trim to bounding box of mask to remove excess transparent border
    bbox = mask.getbbox()
    if bbox:
        img = img.crop(bbox)
        mask = mask.crop(bbox)

    # Create a white image with alpha from mask
    white = Image.new('RGBA', img.size, (255, 255, 255, 0))
    white_pixels = Image.new('RGBA', img.size, (255, 255, 255, 255))
    white.paste(white_pixels, (0, 0), mask)
    return white


def save_scaled(white_img: Image.Image, size: int, out_path: str):
    # Create square canvas of required size and paste centered scaled image
    src_w, src_h = white_img.size
    # compute scale preserving aspect ratio
    scale = min((size / src_w), (size / src_h))
    new_w = max(1, int(src_w * scale))
    new_h = max(1, int(src_h * scale))
    resized = white_img.resize((new_w, new_h), Image.LANCZOS)

    canvas = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    offset = ((size - new_w) // 2, (size - new_h) // 2)
    canvas.paste(resized, offset, resized)
    # Ensure directories exist
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    canvas.save(out_path, format='PNG')


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--input', '-i', required=True, help='Path to source logo image')
    args = p.parse_args()

    src = args.input
    if not os.path.exists(src):
        print('Input file not found:', src)
        return

    img = Image.open(src)
    white = make_white_silhouette(img)

    for folder, size in SIZES.items():
        out_dir = os.path.join(OUT_BASE, folder)
        out_path = os.path.join(out_dir, 'ic_stat_jibli.png')
        save_scaled(white, size, out_path)
        print('Wrote', out_path, 'size', size)

    print('\nDone. Now build your app and test notifications.')


if __name__ == '__main__':
    main()
