import sys
sys.path.append("../")
import numpy as np
import unittest
from cpu import CPU

class TestCPU(unittest.TestCase): 
    def test_lda_load_value(self):
        """Test opcode 0xA9 (Immediate Addressing): Loads value into accumulator"""
        cpu = CPU()
        instructions = np.array([hex(0xa9), hex(0x05), hex(0x00)]) 
        cpu.execute(instructions)
        self.assertEqual(hex(cpu.accumulator), instructions[1])
        return 
    
    def test_lda_zero_flag_status(self): 
        cpu = CPU() 
        instructions = np.array([hex(0xa9), hex(0x00), hex(0x00)]) 
        cpu.execute(instructions)
        # TODO 
        return 

if __name__ == "__main__":
    unittest.main()