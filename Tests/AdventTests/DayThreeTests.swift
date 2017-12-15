import XCTest
@testable import Advent

class DayThreeTests: XCTestCase {
  typealias Index = Spiral.Index

  func testSpiralIndex() {
    let spiral = Spiral()
    XCTAssertEqual(spiral[0], .origin)
    XCTAssertEqual(spiral[1], Index(x: 1, y: 0))
    XCTAssertEqual(spiral[2], Index(x: 1, y: 1))
    XCTAssertEqual(spiral[3], Index(x: 0, y: 1))
    XCTAssertEqual(spiral[4], Index(x: -1, y: 1))
    XCTAssertEqual(spiral[5], Index(x: -1, y: 0))
    XCTAssertEqual(spiral[6], Index(x: -1, y: -1))
    XCTAssertEqual(spiral[7], Index(x: 0, y: -1))
    XCTAssertEqual(spiral[8], Index(x: 1, y: -1))
    XCTAssertEqual(spiral[9], Spiral.Index(x: 2, y: -1))
  }

  func testPuzzleInput() {
    let output = dayThreeA(265149)
    XCTAssertGreaterThan(output, 0)
    XCTAssertEqual(output, 438)
  }

  func __testPerformanceExample() {
      self.measure {
      }
  }

}
