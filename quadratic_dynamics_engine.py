import numpy as np
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] (DYNAMICS) %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)
logger = logging.getLogger('MandelbrotEngine')

class QuadraticMapOrchestrator:
    def __init__(self, c: complex = -0.7 + 0.27015j):
        self.c = c

    def iterate_map(self, x_0: complex = 0.0, max_iter: int = 100, threshold: float = 4.0):
        logger.info(f"Initializing complex quadratic map x = x^2 + c with c = {self.c}")
        x = x_0
        orbit = [x]
        
        for i in range(max_iter):
            x = x**2 + self.c
            orbit.append(x)
            if abs(x) > threshold:
                logger.info(f"Orbit escaped to infinity at iteration {i + 1} (Magnitude: {abs(x):.4f})")
                return False, orbit
                
        logger.info(f"Orbit remained bounded after {max_iter} iterations. Terminal magnitude: {abs(x):.4f}")
        return True, orbit

if __name__ == '__main__':
    engine = QuadraticMapOrchestrator()
    bounded, final_orbit = engine.run = engine.iterate_map()
    print(f"\n[SOVEREIGN DYNAMICS TELEMETRY] Final Orbit State: {final_orbit[-1]}")