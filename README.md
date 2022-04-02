# Minimal GBA project
This repository contains a minimal GameBoy Advance development project.

## Why does this project exist?
This project was created because I love minimalism, therefore I was extremely
frustrated when I read that I needed to install DevkitARM in order to develop
GBA homebrews, instead of simply using the GNU toolchain with the
**arm-none-eabi** target.
This project does exactly that. It compiles using only the following
dependencies:
- GNU GCC (C language only?) (**arm-none-eabi** target)
- GNU Binutils (**arm-none-eabi** target)
- GNU Make
- Python 3

## How to use this project?
This section will describe the steps to create your own project based on this
repository.

### Project structure
- **(DIR) bin**: Output directory. The generated ROM file will be placed inside
this directory.
    - **rom.elf**: The ROM in ELF format. It is used as an intermediate file.
    - **rom.gba**: The ROM in GBA format. This is the ROM that you can load in
        your emulator or your linker.
- **(DIR) obj**: Object directory. The intermediate compilation files will be
placed inside this directory.
- **(DIR) src**: Source directory. It contains the source code of the project.
    - **boot.S**: Contains the ROM header.
    - **common.h**: Contains some definitions that are useful for the project.
    - **crt0.c**: Contains the startup code for the ROM.
    - **gba.ld**: Contains the linker script used by the linker to create the
        ROM file.
    - **main.c**: Contains the *main()* function.
- **.gitignore**: Defines the files that *git* shall ignore.
- **header.py**: Small Python 3 script that computes the ROM header checksums.
- **Makefile**: GNU Makefile script used for compiling the ROM.
- **README.md**: A small guide for this project.

### Configuration
1. If you are using GitHub, fork this repository.
2. Clone the forked repository or this repository using `git clone`.
3. Edit the `src/boot.S` file and change the following values according to your
project:
    - gameTitle: This is a **12-byte** string indicating the title of your
    game/ROM. Make sure you maintain the exact size of 12 bytes. This string is
    made of 12 upper-case ASCII characters. If the title of your game is shorter
    than 12 characters, pad this string with spaces until it is 12 characters
    long.
    - gameCode: This is a **4-byte** upper-case ASCII string indicating the
    code of your game. I am not really sure of the meaning of this field, so I
    guess that you can put whatever you want in it.
    - makerCode: This is a **2-byte** upper-case ASCII string indicating the
    code of the maker of your game. Again, I am not really sure what to put in
    this field so you are free to put your own value.
4. If this is not done yet, install the dependencies on your system.

### Compiling
This project is compiled using **GNU Make**, with standard targets.
- In order to clean the project (remove intermediate and output binaries), use
    the `make clean` command.
- In order to compile the ROM, use the `make` command.

### Development tips
#### Macro definitions
Note that you might want to execute some code in other memory zones than ROM,
such as IWRAM, because these memory zones are faster than the ROM itself. This
is why some macros are defined in the `common.h` file to allow you to do so.
Here are the defined macros inside it:
- `M_IWRAM_INITIALIZED_VAR`: This macro designates an initialized variable that
    you would like to put in IWRAM.
- `M_IWRAM_CONST_VAR`: This macro designates a constant variable that you would
    like to put in IWRAM.
- `M_IWRAM_UNINITIALIZED_VAR`: This macro designates an uninitialized variable
    that you would like to put in IWRAM.
- `M_IWRAM_FUNCTION`: This macro designates a function that you would like to
    put in IWRAM.
- `M_EWRAM_INITIALIZED_VAR`: This macro designates an initialized variable that
    you would like to put in EWRAM.
- `M_EWRAM_CONST_VAR`: This macro designates a constant variable that you would
    like to put in EWRAM.
- `M_EWRAM_UNINITIALIZED_VAR`: This macro designates an uninitialized variable
    that you would like to put in EWRAM.
- `M_EWRAM_FUNCTION`: This macro designates a function that you would like to
    put in EWRAM.

#### Example
Here is an example of a function that will be placed in IWRAM:
```c
M_IWRAM_FUNCTION void myIwramFunction(void) {
    // Function code
}
```

#### Default behavior
- Functions are placed in the `.text` section, which is located in ROM.
- Constants are placed in the `.rodata` section, which is located in ROM.
- Initialized variables are placed in the `.data` section, which is located in
    EWRAM.
- Uninitialized variables are placed in the `.bss` section, which is located in
    EWRAM.
