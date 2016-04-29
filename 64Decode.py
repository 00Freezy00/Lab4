def initLookUpTable():
    alphabetLookup = {"A": 0, "Q": 16, "g": 32, "w": 48,
                      "B": 1, "R": 17, "h": 33, "x": 49,
                      "C": 2, "S": 18, "i": 34, "y": 50,
                      "D": 3, "T": 19, "j": 35, "z": 51,
                      "E": 4, "U": 20, "k": 36, "0": 52,
                      "F": 5, "V": 21, "l": 37, "1": 53,
                      "G": 6, "W": 22, "m": 38, "2": 54,
                      "H": 7, "X": 23, "n": 39, "3": 55,
                      "I": 8, "Y": 24, "o": 40, "4": 56,
                      "J": 9, "Z": 25, "p": 41, "5": 57,
                      "K": 10, "a": 26, "q": 42, "6": 58,
                      "L": 11, "b": 27, "r": 43, "7": 59,
                      "M": 12, "c": 28, "s": 44, "8": 60,
                      "N": 13, "d": 29, "t": 45, "9": 61,
                      "O": 14, "e": 30, "u": 46, "+": 62,
                      "P": 15, "f": 31, "v": 47, "/": 63}
    return alphabetLookup


def intToBinary(aNumber):
    if aNumber == 0:
        return "0"
    result = ""
    while aNumber != 0:
        remainder = aNumber % 2
        result += str(remainder)
        aNumber = (aNumber - remainder) // 2
    return result[::-1].zfill(6)


def Decode64(aList):
    alphabetLookup = initLookUpTable()
    bList = []
    for i in range(len(aList)):
        bList.append(intToBinary(alphabetLookup[aList[i]]))
    result = ""
    # Byte 0
    masked = mask(bList[1], "110000")
    temp1 = shiftright(masked, 4)
    temp2 = shiftleft(bList[0],2)
    print(str(int(temp1)+int(temp2)).zfill(8))
    # Byte 1
    temp1 = mask(bList[1], "001111")
    temp2 = shiftright(bList[2], 2)
    temp1 = shiftleft(temp1,4)
    print(str(int(temp1) + int(temp2)).zfill(8))
    # Byte 3
    masked = mask(bList[2], "000011")
    masked = shiftleft(masked, 6)
    print(str(int(masked) + int(bList[3])).zfill(8))
    return result


def mask(aBinary, mask):
    result = ""
    for i in range(len(aBinary)):
        result += str(int(aBinary[i]) * int((mask[i])))
    return result


def shiftright(aBinary, n):
    return aBinary[:-n]


def shiftleft(aBinary, n):
    for i in range(n):
        aBinary+="0"
    return aBinary

Decode64(["J", "3", "M", "p"])
