import Foundation

func main() {
    print(getPriorityTotal())
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

func getSacks() -> [[Character]] {
    let contents = getContents(from: "Day3.txt")
    let sacks = contents.split { $0.isNewline }.map { return Array(String($0)) }
    return sacks
}

func getSackGroups() -> [([Character], [Character], [Character])] {
    var sacks = getSacks()
    var groups = [([Character], [Character], [Character])]()

    while(sacks.count > 0) {
        let group = (sacks[0], sacks[1], sacks[2])
        groups.append(group)
        sacks.removeFirst(3)
    }

    return groups
}

func getBadges() -> [Character] {
    let groups = getSackGroups()

    var badges = [Character]()

    for group in groups {
        for item in group.0 {
            if group.1.contains(item) && group.2.contains(item) {
                badges.append(item)
                break
            }
        }
    }

    return badges
}

func getPriorityTotal() -> Int {
    let badges = getBadges()
    var total = 0

    for badge in badges {
        total += getPriority(for: badge)
    }

    return total
}

main()