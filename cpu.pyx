import cython
import numpy as np 
cimport numpy as np
import ctypes

np.import_array()

"""
Emulate:
    Fetch
    Decode
    Execute
    (Repeat) 
"""

cdef class CPU: 
    cdef np.uint8_t accumulator 
    cdef np.uint8_t status_reg
    cdef np.uint8_t program_counter
    cdef dict opcodes_map 

    # just for testing. write proper tests later
    cdef np.ndarray instructions

    def __init__(self):
        self.accumulator = 0
        self.program_counter = 0
        self.instructions = np.array([hex(0xa9), hex(0xc0), hex(0xaa), hex(0xe8), hex(0x00)])
        self.status_reg = 0b0000_0000 # use only be 7 bits
        self.opcodes_map = { 
            "0xa9": self.LDA, 
            "0x0": self.BRK
        }
   
    cdef str fetch(self):
        """ fetch instruction from PRG ROM """ 
        c_i = str(self.instructions[self.program_counter]) 
        return c_i

    def LDA(self):
        self.accumulator = int(self.instructions[self.program_counter], 16)

        """ update status register """

        # set zero flag
        if (self.accumulator == 0): 
            self.status_reg = self.status_reg | 0b0000_0010
        else: 
            self.status_reg = self.status_reg & 0b1111_1101

        # set negative flag 
        if (self.accumulator & 0b1000_0000 != 0):
            self.status_reg = self.status_reg | 0b1000_0000
        else:
            self.status_reg = self.status_reg & 0b0111_1111

        #print(f"Status Bit {bin(self.status_reg)}")
        return  

    def BRK(self): 
        """ update status register """ 
        self.status_reg = self.status_reg | 0b0000_1000
        return 

    def execute(self): 
        for i in range(len(self.instructions)):
            c_i = hex(int(self.fetch(), 16))

            self.program_counter += 1

            op = self.opcodes_map.get(c_i, lambda: "Invalid Opcode")()

            print(c_i)


