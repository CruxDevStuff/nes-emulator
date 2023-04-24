import cython
import pyximport; pyximport.install()
from cpu import CPU
import numpy as np

instructions = np.array([hex(0xa9), hex(0x00), hex(0xaa), hex(0xe8), hex(0x00)])

cpu = CPU()
cpu.execute(instructions)