public typealias Table = [Row]
public typealias Row = [Int?]
public typealias MinMax = (min: Int, max: Int)

public func dayTwoA(_ table: Table) -> Int {
  return checksum(table: table) { row in
    let result = row.flatMap { $0 }.minMax() ?? (0, 0)
    return result.max - result.min
  }
}

public func dayTwoB(_ table: Table) -> Int {
  return checksum(table: table) { row in
    row.flatMap { $0 }.firstEvenDivision() ?? 0
  }
}

func checksum(table: Table, method: (Row) -> Int) -> Int {
  return table.map(method).reduce(0, +)
}

extension Collection where Element: Comparable {
  func minMax() -> (min: Element, max: Element)? {
    guard let first = self.first else { return nil }
    return reduce((min: first, max: first)) { r, c in
      (
        min: c < r.min ? c : r.min,
        max: c > r.max ? c : r.max
      )
    }
  }
}

extension Collection where Element: BinaryInteger {
  func firstEvenDivision() -> Element? {
    for i in indices {
      let a = self[i]
      for b in self[index(after: i)...] {
        if a % b == 0 {
          return a / b
        } else if b % a == 0 {
          return b / a
        }
      }
    }
    return nil
  }
}
