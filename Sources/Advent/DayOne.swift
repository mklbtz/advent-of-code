public func dayOneA(_ string: String) -> Int {
    guard string.count > 1 else { return 0 }
    let first = string.first!
    var sum = 0
    if string.last == first {
        sum += Int(String(first))!
    }
    for index in string.indices.dropFirst()
    where string[index] == string[string.index(before: index)] {
            sum += Int(String(string[index]))!
    }
    return sum
}

public func dayOneB(_ string: String) -> Int {
    guard string.count > 1 else { return 0 }
    var sum = 0
    let halfIndex = string.halfIndex
    for (c, r) in zip(string[..<halfIndex], string[halfIndex...]) where c == r {
        let num = Int(String(c))!
        sum += num
    }
    return sum * 2
}
    

extension Collection {
    public var halfIndex: Index {
        if count.magnitude <= 1 {
            return endIndex
        } else {
            return index(startIndex, offsetBy: count / 2)
        }
    }
}
