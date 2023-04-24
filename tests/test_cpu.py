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
        self.assertEqual(self.cpu.reg_status & 0b0100_0000, 0b00)
        return 
    
    def test_LDA_negative_flag_STATUS_REG(self): 
        """Test CPU status by loading a value with its 7'th bit set into accumulator: check if negative flag is set in status register"""
        instructions = np.array([hex(0xa9), hex(0xc0), hex(0x00)]) 
        self.cpu.execute(instructions)
        #self.assertEqual(bin(self.cpu.reg_status & 0b0000_0010), bin(0b01))
        self.assertEqual(bin(self.cpu.reg_status & 0b0100_0000), bin(0b0100_0000))
        return 

    def test_LDA_zero_flag_STATUS_REG(self): 
        """Test CPU status by loading 0 into accumulator: check if zero flag is set in status register"""
        instructions = np.array([hex(0xa9), hex(0x00), hex(0x00)]) 
        self.cpu.execute(instructions)
        self.assertEqual(bin(self.cpu.reg_status & 0b0000_0010), bin(0b10))
        return 
    
    def test_BRK_break_flag_STATUS_REG(self): 
        """Test CPU status by executing BRK: check if break flag is set in status reg"""
        instructions = np.array([hex(0x00)]) 
        self.cpu.execute(instructions)
        self.assertEqual(bin(self.cpu.reg_status & 0b0001_0000), bin(0b10000))

    def test_TAX_load_value(self):
        """Test TAX(0xaa, Implied addressing): check register X == accumulator"""
        instructions = np.array([hex(0xa9), hex(0xB), hex(0xaa), hex(0x00)]) 
        self.cpu.execute(instructions)
        self.assertEqual(hex(self.cpu.reg_x), hex(self.cpu.accumulator))
        return 

    def test_INX_load_value(self):
        """Test INX(0xe8, Implied addressing): check current register X == previous register X + 1"""
        instructions = np.array([hex(0xa9), hex(0xB), hex(0xaa), hex(0xe8), hex(0x00)]) 
        self.cpu.execute(instructions)
        self.assertEqual(hex(self.cpu.reg_x), hex(int(instructions[1], 16)+1))
        return 
if __name__ == "__main__":
    unittest.main()