public func dayOneA(_ string: String) -> Int {
    guard string.count > 1 else { return 0 }
    var sum = check(string.dropFirst(), string.dropLast())
    if string.last == string.first {
        sum += Int(string.first!)
    }
    return sum
}

public func dayOneB(_ string: String) -> Int {
    guard string.count > 1 else { return 0 }
    let halfIndex = string.halfIndex
    return check(string[..<halfIndex], string[halfIndex...]) * 2
}

func check(_ lhs: Substring, _ rhs: Substring) -> Int {
    var sum = 0
    for (l, r) in zip(lhs, rhs) where l == r {
        sum += Int(l)
    }
    return sum
}

extension Collection {
    var halfIndex: Index {
        if count.magnitude <= 1 {
            return endIndex
        } else {
            return index(startIndex, offsetBy: count / 2)
        }
    }
}

extension Int {
    init(_ char: Character) {
        self = Int(String(char)) ?? 0
    }
}

