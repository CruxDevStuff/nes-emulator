import cython
import numpy as np 
cimport numpy as np

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

    def __init__(self):
        super().__init__()
        self.accumulator = 0
        self
    
    def execute(self): 
        print(self.accumulator)
        return 1
