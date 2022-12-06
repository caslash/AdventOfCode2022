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
        case "A" : convertedRound.0 = 1 //rock
        case "B" : convertedRound.0 = 2 //paper
        case "C" : convertedRound.0 = 3 //scissors
        default : fatalError("Invalid shape given by opponent")
    }

    switch round.1 {
        case "X" : convertedRound.1 = 1 //loss
        case "Y" : convertedRound.1 = 2 //draw
        case "Z" : convertedRound.1 = 3 //win
        default : fatalError("Invalid outcome")
    }

    if convertedRound.1 == 2 {
        roundScore += 3
        roundScore += convertedRound.0
    } else if convertedRound.1 == 1 {
        roundScore += convertedRound.0 == 1 ? 3 : convertedRound.0 - 1
    } else if convertedRound.1 == 3 {
        roundScore += 6
        roundScore += convertedRound.0 == 3 ? 1 : convertedRound.0 + 1
    }

    return roundScore
}

main()