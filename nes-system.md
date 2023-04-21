# NES Components

#### NES is a distributed system, the CPU and PPU has to coordinate for games to not break. 

CPU - Runs the main program loop. Emulate a 6502 Chip

PPU(Picture Processing Unit) - Draw the graphics on the screen. NES used the 2C02 chip. 

APU(Audio Proccessing Unit) - Responsible for sound(5 channels). This is part of the CPU. 

RAM - Both CPU and PPU have a dedicated 2KB RAM. 

Cartridges - Each had 2 ROM chips. "Character ROM" and the "Program ROM". "CHR ROM" has all the assets(graphics, sound,etc..) and is directly connected to the PPU. "PRG ROM" contains all the instructions and is directly connected to the CPU.

GamePad - Represents its state with 8 bits. Each bit representing the state of the button(pressed/not pressed)
