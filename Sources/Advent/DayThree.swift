func dayThreeA(_ offsetPlusOne: Int) -> Int {
  // Example spiral starts counting at one, but mine starts at zero.
  let index = Spiral.Index(offset: offsetPlusOne - 1)
  return abs(index.x) + abs(index.y) // get "Manhattan Distance"
}



struct Spiral {
  struct Index {
    var x: Int
    var y: Int

    static var origin: Index = Index(x: 0, y: 0)

    enum Direction {
      case north, south, west, east
    }

    enum Diagonal {
      case northEast, northWest, southEast, southWest
    }

    enum Sector {
      case origin
      case wedge(Direction)
      case diagonal(Diagonal)
    }
  }
}



extension Spiral {
  var indices: AnySequence<Index> {
    return AnySequence(sequence(first: Spiral.Index.origin, next: index(after:)))
  }

  func index(after i: Index) -> Index {
    return i.movingForward()
  }

  func index(before i: Index) -> Index {
    return i.movingBackward()
  }
}



extension Spiral.Index {
  init(offset: Int) {
    self = (0..<offset).reduce(.origin) { i, _ in i.movingForward() }
  }

  func movingForward() -> Spiral.Index {
    return moving(forward)
  }

  func movingBackward() -> Spiral.Index {
    return moving(backward)
  }

  private func moving(_ direction: Direction) -> Spiral.Index {
    switch direction {
    case .north:
      return Spiral.Index(x: x, y: y + 1)
    case .south:
      return Spiral.Index(x: x, y: y - 1)
    case .west:
      return Spiral.Index(x: x - 1, y: y)
    case .east:
      return Spiral.Index(x: x + 1, y: y)
    }
  }

  var sector: Sector {
    return .init(x: x, y: y)
  }

  var forward: Direction {
    switch sector {
    case .origin,
         .wedge(.south),
         .diagonal(.southWest),
         .diagonal(.southEast): // move into next layer of spiral
      return .east
    case .wedge(.east):
      return .north
    case .wedge(.north), .diagonal(.northEast):
      return .west
    case .wedge(.west), .diagonal(.northWest):
      return .south
    }
  }

  var backward: Direction {
    switch sector {
    case .origin:
      fatalError("No index before origin")
    case .wedge(.north):
      return .east
    case .wedge(.west):
      return .north
    case .wedge(.south):
      return .west
    case .wedge(.east) where x - 1 == -y:
      return .west // move into previous layer of spiral
    case .wedge(.east):
      return .south
    case .diagonal(.northEast):
      return .south
    case .diagonal(.northWest):
      return .east
    case .diagonal(.southWest):
      return .north
    case .diagonal(.southEast):
      return .west
    }
  }
}



extension Spiral.Index: Equatable {
  static func ==(lhs: Spiral.Index, rhs: Spiral.Index) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
  }
}



extension Spiral.Index.Sector {
  init(x: Int, y: Int) {
    if x == 0 , y == 0 {
      self = .origin
    } else if x < y && -x < y {
      self = .wedge(.north)
    } else if x < -y && x < y {
      self = .wedge(.west)
    } else if x > y && x < -y {
      self = .wedge(.south)
    } else if -x < y && x > y {
      self = .wedge(.east)
    } else if x == y && x > 0 {
      self = .diagonal(.northEast)
    } else if -x == y && x < 0 {
      self = .diagonal(.northWest)
    } else if x == y && x < 0 {
      self = .diagonal(.southWest)
    } else if -x == y && x > 0 {
      self = .diagonal(.southEast)
    } else {
      fatalError("This should be exhaustive!")
    }
  }
}



extension Spiral.Index.Diagonal: Equatable {}

extension Spiral.Index.Direction: Equatable {}

extension Spiral.Index.Sector: Equatable {
  static func ==(lhs: Spiral.Index.Sector, rhs: Spiral.Index.Sector) -> Bool {
    switch (lhs, rhs) {
    case (.origin, .origin):
      return true
    case (.diagonal(let ld), .diagonal(let rd)) where ld == rd:
      return true
    case (.wedge(let lw), .wedge(let rw)) where lw == rw:
      return true
    case (.origin, _), (.diagonal, _), (.wedge, _):
      return false
    }
  }
}
