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
    cdef readonly np.uint8_t accumulator 
    cdef readonly np.uint8_t reg_status 
    cdef readonly np.uint8_t reg_x

    cdef np.uint8_t program_counter
    cdef dict opcodes_map 

    # just for testing. write proper tests later
    cdef np.ndarray instructions

    def __init__(self):
        self.accumulator = 0
        self.program_counter = 0
        self.reg_x = 0
        self.reg_status = 0b0000_0000 # use only be 7 bits
        self.opcodes_map = { 
            "0xa9": self.LDA, 
            "0x0": self.BRK,
            "0xaa": self.TAX, 
            "0xe8": self.INX
        }
   
    cpdef str fetch(self):
        """ fetch instruction from PRG ROM """ 
        c_i = str(self.instructions[self.program_counter]) 
        return c_i
    
    def debug_reg_status(self):
        print(f"PC: {self.program_counter} , STATUS: {bin(self.reg_status)}")
        return 

    cpdef LDA(self):
        self.accumulator = int(self.instructions[self.program_counter+1], 16)
        self.program_counter +=1

        """ update status register """
        # set zero flag
        if (self.accumulator == 0): 
            self.reg_status = self.reg_status | 0b0000_0010
        else: 
            self.reg_status = self.reg_status & 0b1111_1101

        # set negative flag 
        if (self.accumulator & 0b0100_0000 != 0):
            self.reg_status = self.reg_status | 0b0100_0000
        else:
            self.reg_status = self.reg_status & 0b1011_1111

        return 1
    
    cpdef TAX(self): 
        self.reg_x = self.accumulator

        """ update status register """
        # set zero flag
        if (self.reg_x == 0): 
            self.reg_status = self.reg_status | 0b0000_0010
        else: 
            self.reg_status = self.reg_status & 0b1111_1101

        # set negative flag 
        if (self.reg_x & 0b0100_0000 != 0):
            self.reg_status = self.reg_status | 0b0100_0000
        else:
            self.reg_status = self.reg_status & 0b1011_1111

        return 1


    cpdef INX(self):
        self.reg_x += 1
        
        """ update status register """
        # set zero flag
        if (self.reg_x == 0): 
            self.reg_status = self.reg_status | 0b0000_0010
        else: 
            self.reg_status = self.reg_status & 0b1111_1101

        # set negative flag 
        if (self.reg_x & 0b0100_0000 != 0):
            self.reg_status = self.reg_status | 0b0100_0000
        else:
            self.reg_status = self.reg_status & 0b1011_1111

        return 1


    cpdef BRK(self): 
        """ update status register """ 
        self.reg_status = self.reg_status | 0b0001_0000
        return 1

    def execute(self, instructions): 
        self.instructions = instructions

        while (True):
            c_i = hex(int(self.fetch(), 16))

            op = self.opcodes_map.get(c_i, lambda: "Invalid Opcode")()

            # self.debug_reg_status()

            """ exit if end of instrutions """
            if (self.program_counter+1 == len(self.instructions)):
                break

            self.program_counter += 1



