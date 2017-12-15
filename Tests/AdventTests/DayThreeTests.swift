import XCTest
@testable import Advent

class DayThreeTests: XCTestCase {
  func testPartAPuzzleInput() {
    let output = dayThreeA(265149)
    XCTAssertGreaterThan(output, 0)
    XCTAssertEqual(output, 438)
  }
}

class SpiralIndexTests: XCTestCase {
  typealias Index = Spiral.Index

  func offset(_ offset: Int, equals other: Index, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(Index(offset: offset), other, file: file, line: line)
  }

  func offset<T>(_ offset: Int, _ keyPath: KeyPath<Index, T>, equals other: T, file: StaticString = #file, line: UInt = #line)
  where T: Equatable {
    XCTAssertEqual(Index(offset: offset)[keyPath: keyPath], other, file: file, line: line)
  }

  func offset<T>(_ offset: Int, func keyPath: KeyPath<Index, () -> T>, equals other: T, file: StaticString = #file, line: UInt = #line)
  where T: Equatable {
    XCTAssertEqual(Index(offset: offset)[keyPath: keyPath](), other, file: file, line: line)
  }

  func testOffsetInitializer() {
    offset(0, equals: .origin)
    offset(1, equals: Index(x: 1, y: 0))
    offset(2, equals: Index(x: 1, y: 1))
    offset(3, equals: Index(x: 0, y: 1))
    offset(4, equals: Index(x: -1, y: 1))
    offset(5, equals: Index(x: -1, y: 0))
    offset(6, equals: Index(x: -1, y: -1))
    offset(7, equals: Index(x: 0, y: -1))
    offset(8, equals: Index(x: 1, y: -1))
    offset(9, equals: Index(x: 2, y: -1))
  }

  func testSector() {
    offset(0, \.sector, equals: .origin)
    offset(1, \.sector, equals: .wedge(.east))
    offset(2, \.sector, equals: .diagonal(.northEast))
    offset(3, \.sector, equals: .wedge(.north))
    offset(4, \.sector, equals: .diagonal(.northWest))
    offset(5, \.sector, equals: .wedge(.west))
    offset(6, \.sector, equals: .diagonal(.southWest))
    offset(7, \.sector, equals: .wedge(.south))
    offset(8, \.sector, equals: .diagonal(.southEast))
    offset(9, \.sector, equals: .wedge(.east))
  }

  func testForward() {
    offset(0, \.forward, equals: .east)
    offset(1, \.forward, equals: .north)
    offset(2, \.forward, equals: .west)
    offset(3, \.forward, equals: .west)
    offset(4, \.forward, equals: .south)
    offset(5, \.forward, equals: .south)
    offset(6, \.forward, equals: .east)
    offset(7, \.forward, equals: .east)
    offset(8, \.forward, equals: .east)
    offset(9, \.forward, equals: .north)
  }

  func testBackward() {
    offset(1, \.backward, equals: .west)
    offset(2, \.backward, equals: .south)
    offset(3, \.backward, equals: .east)
    offset(4, \.backward, equals: .east)
    offset(5, \.backward, equals: .north)
    offset(6, \.backward, equals: .north)
    offset(7, \.backward, equals: .west)
    offset(8, \.backward, equals: .west)
    offset(9, \.backward, equals: .west)
  }
}
