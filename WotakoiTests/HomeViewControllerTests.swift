import XCTest
@testable import Wotakoi

class HomeViewControllerTests: XCTestCase {
    
    var sut: HomeViewController?
    
    override func setUpWithError() throws {
        let sb = UIStoryboard(name: "HomeViewController", bundle: nil)
        sut = sb.instantiateViewController(identifier: "HomeViewController!") as? HomeViewController
        sut?.loadView()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testEmptyTableView() {
        let isHidden = sut?.tableView.isHidden
        let list = sut?.presenter?.numberOfModelsRows()
        if list == 0 {
            XCTAssertEqual(isHidden, true)
        } else {
            XCTAssertEqual(isHidden, false)
        }
    }
}
