import Foundation

func main() {
    print(play())
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

func getRounds() -> [(String, String)] {
    let contents = getContents(from: "Day2.txt")

    return contents.split { $0.isNewline }.map { return $0.split { $0.isWhitespace } }.map { return (String($0[0]), String($0[1])) }
}

func play() -> Int {
    let rounds = getRounds()
    var totalScore = 0
    
    for round in rounds {
        totalScore += getScoreFromRound(round)
    }

    return totalScore
}

func getScoreFromRound(_ round: (String, String)) -> Int {
    var convertedRound = (Int(), Int())

    var roundScore = 0

    switch round.0 {
        case "A" : convertedRound.0 = 1
        case "B" : convertedRound.0 = 2
        case "C" : convertedRound.0 = 3
        default : fatalError("Invalid shape given by opponent")
    }

    switch round.1 {
        case "X" : convertedRound.1 = 1
        case "Y" : convertedRound.1 = 2
        case "Z" : convertedRound.1 = 3
        default : fatalError("Invalid shape given by player")
    }

    roundScore += convertedRound.1

    if convertedRound.0 == convertedRound.1 {
        roundScore += 3
    } else if convertedRound.0 == 1 && convertedRound.1 == 2 
    || convertedRound.0 == 2 && convertedRound.1 == 3
    || convertedRound.0 == 3 && convertedRound.1 == 1 {
        roundScore += 6
    }
    
    return roundScore
}

main()