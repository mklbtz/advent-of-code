func dayThreeA(_ iterations: Int) -> Int {
  // Example spiral starts counting at one, but mine starts at zero.
  let index = Spiral()[iterations - 1]
  return abs(index.x) + abs(index.y) // get "Manhattan Distance"
}

struct Spiral {
  subscript(number: Int) -> Index {
    return (0..<number).reduce(Index.origin) { i, _ in index(after: i)}
  }

  var indices: AnySequence<Index> {
    return AnySequence(sequence(first: Spiral.Index.origin, next: index(after:)))
  }

  func index(after i: Index) -> Index {
    return i.movingForward()
  }

  func index(before i: Index) -> Index {
    return i.movingBackward()
  }

  enum Direction {
    case up, down, left, right
  }

  struct Index {
    var x: Int
    var y: Int

    static var origin: Spiral.Index = Spiral.Index(x: 0, y: 0)

    func movingForward() -> Index {
      return moving(forward)
    }

    func movingBackward() -> Index {
      return moving(backward)
    }

    private func moving(_ direction: Direction) -> Index {
      switch direction {
      case .up:
        return Index(x: x, y: y + 1)
      case .down:
        return Index(x: x, y: y - 1)
      case .left:
        return Index(x: x - 1, y: y)
      case .right:
        return Index(x: x + 1, y: y)
      }
    }

    var forward: Direction {
      guard self != .origin else { return .right }

      if x <= y && -x < y {
        return .left
      } else if x <= -y && x < y {
        return .down
      } else if x >= y && x < -y {
        return .right
      } else if -x < y && x > y {
        return .up
      } else if -x == y {
        return .right // moves into next layer of spiral
      } else {
        fatalError("This should be exhaustive!")
      }
    }

    var backward: Direction {
      guard self != .origin else { fatalError("Nowhere else to go!") }

      if x <= y && -x < y {
        return .up
      } else if x <= -y && x < y {
        return .left
      } else if x >= y && x < -y {
        return .down
      } else if -x < y && x > y {
        return .right
      } else if -x == y {
        return .left // moves into previous layer of spiral
      } else {
        fatalError("This should be exhaustive!")
      }
    }
  }
}

extension Spiral.Index: Equatable {
  static func ==(lhs: Spiral.Index, rhs: Spiral.Index) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }
}
