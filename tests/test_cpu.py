import sys
sys.path.append("../")
import numpy as np
import unittest
from cpu import CPU

class TestCPU(unittest.TestCase): 
    def setUp(self):
        self.cpu = CPU() 

    def test_LDA_load_value(self):
        """Test LDA(0xA9, Immediate Addressing): check accumulator value == operand"""
        instructions = np.array([hex(0xa9), hex(0x05), hex(0x00)]) 
        self.cpu.execute(instructions)
        self.assertEqual(hex(self.cpu.accumulator), instructions[1])
        return 
    
    def test_LDA_zero_flag_STATUS_REG(self): 
        """Test CPU status by loading 0 into accumulator: check if zero flag is set in status register"""
        instructions = np.array([hex(0xa9), hex(0x00), hex(0x00)]) 
        self.cpu.execute(instructions)
        self.assertEqual(bin(self.cpu.status_reg & 0b0000_0010), bin(0b10))
        return 
    
    def test_BRK_break_flag_STATUS_REG(self): 
        """Test CPU status by executing BRK: check if break flag is set in status reg"""
        instructions = np.array([hex(0x00)]) 
        self.cpu.execute(instructions)
        self.assertEqual(bin(self.cpu.status_reg & 0b0001_0000), bin(0b10000))


if __name__ == "__main__":
    unittest.main()