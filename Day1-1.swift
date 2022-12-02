import Foundation

func main() {
    print(evalElves(getContents(from: "Day1.txt")))
}

func getContents(from file: String) -> [[Int]] {
    var contents: String

    var elves = [[Int]]()

    var elf = [Int]()

    do {
        contents = try String(contentsOfFile: file)
    } catch {
        fatalError("Couldn't get contents of \(file)")
    }

    contents.enumerateLines { (line, _) in
        if !line.isEmpty {
            elf.append(Int(line)!)
        } else {
            elves.append(elf)
            elf = [Int]()
        }
    }

    return elves
}

func evalElves(_ elves: [[Int]]) -> Int {
    var most = 0

    for elf in elves {
        var elfCal = elf.reduce(0, +)
        if elfCal > most {
            most = elfCal
        }
    }

    return most
}

main()