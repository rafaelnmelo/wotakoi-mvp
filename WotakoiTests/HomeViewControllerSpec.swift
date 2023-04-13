import Quick
import Nimble
@testable import Wotakoi

class HomeViewControllerSpec: QuickSpec {
    override func spec() {
        describe("HomeViewController") {
            
            var sut: HomeViewController!
            
            beforeEach {
                sut = HomeViewController()
            }
            
            context("BaseViewController") {
                it("Verify heritage") {
                    expect(sut).to(beAKindOf(BaseViewController.self))
                }
            }
            
            context("HomePresenterDelegate") {
                it("Verify heritage") {
                    expect(sut).to(beAKindOf(HomePresenterDelegate.self))
                }
            }
        }
    }
}
