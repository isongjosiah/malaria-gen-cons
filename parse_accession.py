import sys

def parseFile(filePath:str) -> list[str]:
    accensionNumbers: list[str] = []
    with open(filePath, "r") as file:
        lineArray = file.readlines()
    for line in lineArray:
        linecolumns = line.split("\t")
        accensionNumbers.append(f"{linecolumns[9]}\n")

    return accensionNumbers


if __name__ == "__main__":
    arguments = sys.argv
    if len(arguments) != 2:
        print(f"Usage: parse_excel.py [file]")
        exit()


    with open("result.txt", "w") as file:
        file.writelines(parseFile(arguments[1]))
    