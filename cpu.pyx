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
    cdef np.uint8_t status
    cdef np.uint8_t program_counter

    # just for testing. write proper tests later
    cdef np.ndarray instructions

    def __init__(self):
        self.accumulator = 0
        self.instructions = np.array([hex(0xa9), hex(0xc0), hex(0xaa), hex(0xe8), hex(0x00)])
   
    cdef str fetch(self):
        """ fetch instruction from PRG ROM """ 
        c_i = str(self.instructions[self.program_counter]) 
        return c_i
        
    def execute(self): 
        for i in range(len(self.instructions)): # switch to while loop once "BREAK" is implemented
            c_i = self.fetch()
            self.program_counter += 1
            
            """ TODO : check and execute current instruction """ 

            print(c_i)

