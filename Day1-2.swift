import Foundation

func main() {
    print(getTopThreeElves(evalElves(getContents(from: "Day1.txt"))))
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

func evalElves(_ elves: [[Int]]) -> [Int] {
    return elves.map { $0.reduce(0, +) }
}

func getTopThreeElves(_ elfTotals: [Int]) -> Int {
    var sortedElves = elfTotals.sorted { $0 > $1 }

    print(sortedElves)

    var topThree = sortedElves[0..<3]

    return topThree.reduce(0, +)
}

main()