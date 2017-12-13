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
