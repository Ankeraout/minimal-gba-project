from typing import List
import sys

def main(args: List[str]) -> int:
    if(len(args) != 2):
        print("Usage:")
        print("    python3 {:s} <file name>".format(args[0]))
        return 1

    fd = open(args[1], "rb")
    header = bytearray(fd.read(0xc0))
    fd.close()

    checksum = 0x00

    for i in range(0xa0, 0xbd):
        checksum -= header[i]
        checksum &= 0xff

    checksum -= 0x19
    checksum &= 0xff

    header[0xbd] = checksum

    fd = open(args[1], "r+b")
    fd.write(header)
    fd.close()

    return 0

if(__name__ == "__main__"):
    exit(main(sys.argv))