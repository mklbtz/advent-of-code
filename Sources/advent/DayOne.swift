public func dayOneA(_ string: String) -> Int {
    return check(string.map { c in Int(String(c), radix: 10)! })
}

private func check<Ints>(_ numbers: Ints) -> Int where Ints: BidirectionalCollection, Ints.Element == Int {
    guard let first = numbers.first else { return 0 }
    var sum = 0
    if numbers.last == first {
        sum += first
    }
    for index in numbers.indices where numbers.index(after: index) != numbers.endIndex && numbers[index] == numbers[numbers.index(after: index)] {
        sum += numbers[index]
    }
    return sum
}

// private func check<Ints>(head: Int, tail: Ints, sum: Int, first: Int) -> Int
//   where Ints: Collection, Ints.Element == Int {

// }

// private func check<Ints>(head: Int, sum: Int, first: Int) -> Int
//   where Ints: Collection, Ints.Element == Int {

// }

// private func check<Ints>(sum: Int, first: Int) -> Int
//   where Ints: Collection, Ints.Element == Int {

// }
