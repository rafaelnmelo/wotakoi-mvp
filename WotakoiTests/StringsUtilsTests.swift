//
//  StringsUtilsTests.swift
//  WotakoiTests
//
//  Created by Rafael Melo on 11/04/23.
//  Copyright © 2023 Rafael Nunes. All rights reserved.
//

import Quick
import Nimble
@testable import Wotakoi

class StringUtilsTests: QuickSpec {
     
    override func spec() {
        describe("StringUtils") {
            context("Is Valid Email") {
                it("Valid Email") {
                    let email = "curso@gmail.com"
                    let isValidEmail = email.isValidEmail()
                    expect(isValidEmail).to(beTrue())
                }
                
                it("Invalid Email") {
                    let email = "curso"
                    let isValidEmail = email.isValidEmail()
                    expect(isValidEmail).to(beFalsy())
                }
                
                it("Invalid Email") {
                    let email = "curso"
                    let isValidEmail = email.isValidEmail()
                    expect(isValidEmail) == false
                }
            }
            
            context("Remove White Space") {
                it("With white space") {
                    let text = "Olá mundo"
                    let newText = text.removeWhitespace()
                    expect(newText).to(equal("Olámundo"))
                }
                
                it("Without white space") {
                    let text = "Olámundo"
                    let newText = text.removeWhitespace()
                    expect(newText).to(equal(text))
                }
            }
        }
    }
}
