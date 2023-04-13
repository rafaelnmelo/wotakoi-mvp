import XCTest
@testable import Wotakoi

class StringUtilsTests: XCTestCase {

    func getSpecialLimit(balance: Double) -> Double {
        if balance < 100 {
            return balance + 10
        } else if balance > 500 {
            return balance + 1000
        }
        
        return balance
    }
        
    func testGetSpecialBalance100() {
        let specialBalance = getSpecialLimit(balance: 99)
        
        XCTAssertEqual(specialBalance, 109, "O saldo menor que 100, deve retornar o saldo + 10")
    }
    
    func testGetSpecialBalance900() {
        let specialBalance = getSpecialLimit(balance: 900)
        
        XCTAssertEqual(specialBalance, 1900, "O saldo maior que 500, deve retornar o saldo + 1000")
        XCTAssertGreaterThan(specialBalance, 900)
    }
    
    func testGetSpecialBalance400() {
        let specialBalance = getSpecialLimit(balance: 400)
        
        XCTAssertEqual(specialBalance, 400, "O saldo menor que 500 e maior que 100, deve retornar o saldo")
    }
    
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

