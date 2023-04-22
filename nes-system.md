## NES Components

#### NES is a distributed system, the CPU and PPU has to coordinate for games to not break. 

CPU - Runs the main program loop. Emulate a 6502 Chip

PPU(Picture Processing Unit) - Draw the graphics on the screen. NES used the 2C02 chip. 

APU(Audio Proccessing Unit) - Responsible for sound(5 channels). This is part of the CPU. 

RAM - Both CPU and PPU have a dedicated 2KB RAM. 

Cartridges - Each had 2 ROM chips. "Character ROM" and the "Program ROM". "CHR ROM" has all the assets(graphics, sound,etc..) and is directly connected to the PPU. "PRG ROM" contains all the instructions and is directly connected to the CPU.

GamePad - Represents its state with 8 bits. Each bit representing the state of the button(pressed/not pressed)

## Addressing  
NES uses 16 bit memory addressing. 65536 memory cells

CPU RAM: 2KB (dedicated)
PPU RAM: 2KB (dedicated) 

* 0x0000 to 0x2000 - CPU RAM access
* 0x2000 to 0x4020 - IO registers. Access other components like APU, GamePads, PPU, etc..
* 0x4020 to 0x6000 - MAPPERS(this space is mapped to different components like RAM ,ROM. Catridges have special circuitry to use this feature.) 
* 0x6000 to 0x8000 - Mapped to RAM on cartridges that supported them.
* 0x8000 to 0xFFFF - Mapped to "PRG ROM(program ROM)" containing the CPU instructions. 

## Access Times
* CPU Registers - 2 clock cycles
* RAM(first 255 bytes) - 3 clock cycles
* RAM(beyond first 255 bytes) - 4-7 clock cycles

## Registers 
* PC - Holds the index/address of the current/next instruction s to be executed.
* Stack Pointer - holds the address for the top of the stack
Accumulator - holds the result of memory, arithmetic and logical operations. 
* Index Register X - used as address offset or holding temp values.
* Index Register Y - used as address offset or holding temp values.
* Status Flag Resgister - 7 bits indicating the status of the CPU or the info about the last executed instruction
