"""
Project LUCY x DeepSeekN: robdoe.com Vector QR Code Generator
Encodes https://robdoe.com into an immaculate vector SVG matrix.
"""

import sys
import os
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(levelname)s] (QR-GEN) %(message)s')
logger = logging.getLogger("LucyQRGen")

def generate_svg_qr():
    try:
        import qrcode
        import qrcode.image.svg
    except ImportError:
        logger.info("Installing required qrcode package...")
        import subprocess
        subprocess.check_call([sys.executable, "-m", "pip", "install", "qrcode[svg]", "pillow"], stdout=subprocess.DEVNULL)
        import qrcode
        import qrcode.image.svg

    target_url = "https://robdoe.com"
    logger.info(f"Encoding sovereign domain into vector matrix: {target_url}")

    factory = qrcode.image.svg.SvgPathImage
    img = qrcode.make(target_url, image_factory=factory)
    
    svg_path = "lucy_sovereign_qr.svg"
    img.save(svg_path)
    logger.info(f"Vector QR code successfully updated and saved to {svg_path}")
    return svg_path

if __name__ == '__main__':
    generate_svg_qr()