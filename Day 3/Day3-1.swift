import Foundation

func main() {
    print(evalSacks())
}

func getContents(from file: String) -> String {
    var contents: String

    do {
        contents = try String(contentsOfFile: file)
    } catch {
        fatalError("Couldn't get contents of \(file)")
    }

    return contents
}

func getPriority(for letter: Character) -> Int {
    let asciiCode = Int(letter.asciiValue ?? 0)

    switch asciiCode {
        case 65...90 : return asciiCode - 38
        case 97...122 : return asciiCode - 96
        default : return 0
    }
}

func getSacks() -> [([Character], [Character])] {
    let contents = getContents(from: "Day3.txt")
    let sacks = contents.split { $0.isNewline }.map { return Array(String($0)) }
    let sackHalfs = sacks.map { return (Array($0[0..<$0.count / 2]), Array($0[$0.count / 2..<$0.count])) }
    return sackHalfs
}

func evalSacks() -> Int {
    var total = 0

    let sacks = getSacks()

    for sack in sacks {
        let compartmentOne = sack.0
        let compartmentTwo = sack.1.map { return getPriority(for: $0) }

        for item in compartmentOne {
            let itemPrior = getPriority(for: item)
            if compartmentTwo.contains(itemPrior) {
                total += itemPrior
                break
            }
        }
    }

    return total
}

main()