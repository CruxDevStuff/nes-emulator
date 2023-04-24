import sys
sys.path.append("../")
import numpy as np
import unittest
from cpu import CPU

class TestCPU(unittest.TestCase): 
    def setUp(self):
        self.cpu = CPU() 

    def test_lda_load_value(self):
        """Test opcode 0xA9 (Immediate Addressing): Loads value into accumulator"""
        instructions = np.array([hex(0xa9), hex(0x05), hex(0x00)]) 
        self.cpu.execute(instructions)
        self.assertEqual(hex(self.cpu.accumulator), instructions[1])
        return 
    
    def test_lda_zero_flag_status(self): 
        instructions = np.array([hex(0xa9), hex(0x00), hex(0x00)]) 
        self.cpu.execute(instructions)
        self.assertEqual(bin(self.cpu.status_reg & 0b0000_0010), bin(0b10))
        return 

if __name__ == "__main__":
    unittest.main()