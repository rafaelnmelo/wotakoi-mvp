import XCTest
@testable import Wotakoi

class StringUtilsSpec: XCTestCase {

    func testIsValidEmail() {
        let email = "Wotakoi@gmail.com"
        let value = email.isValidEmail()
        
        XCTAssertTrue(value, "\n\nNão é um email válido\n\n")
        XCTAssert(value == true)
    }
    
    func testRemoveWhiteSpace() {
        let text = " olá mundo "
        let newText = text.removeWhitespace()
        
        XCTAssertTrue(newText == "olámundo", "\n\nNão removeu os espaços\n\n")
    }
    
    func testReplace() {
        let text = "Menino"
        let genderSwap = text.replace(string: "o", replacement: "a")
        
        XCTAssertTrue(genderSwap == "Menina", "\n\nTroca não realizada\n\n")
    }

}
