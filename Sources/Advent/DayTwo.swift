public typealias Table = [Row]
public typealias Row = [Int?]
public typealias MinMax = (min: Int, max: Int)

public func dayTwoA(_ table: Table) -> Int {
  return checksum(table: table)
}

func checksum(table: Table) -> Int {
  return table.map(checksum).reduce(0, +)
}

func checksum(row: Row) -> Int {
  let actuals = row.flatMap { $0 }
  guard let first = actuals.first else { return 0 }
  let result: MinMax = actuals.reduce((first, first), minmax)
  return result.max - result.min
}

func minmax(_ current: MinMax, _ number: Int) -> MinMax {
  return (
    min: number < current.min ? number : current.min,
    max: number > current.max ? number : current.max
  )
}
