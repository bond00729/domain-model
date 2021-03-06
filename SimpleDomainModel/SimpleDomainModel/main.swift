//
//  main.swift
//  SimpleDomainModel
//
//  Created by Matt Bond on 10/16/16.
//  Copyright © 2016 Matt Bond. All rights reserved.
//

import Foundation

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
} 

struct Money {
    
    var amount : Int = 0
    var currency : String = ""
    
    init(amount : Int, currency : String) {
        self.amount = amount
        self.currency = currency
    }
    
    func convert (_ toCurr : String) -> Money {
        if toCurr == "GBP" {
            if self.currency == "USD" {
                return Money(amount: self.amount / 2, currency : toCurr)
            } else if self.currency == "EUR" {
                return Money(amount: self.amount * 3, currency : toCurr)
            } else if self.currency == "CAN" {
                return Money(amount: self.amount * 5 / 2, currency : toCurr)
            } else if self.currency == "GBP" {
                return Money(amount: self.amount, currency : toCurr)
            }
        } else if toCurr == "EUR" {
            if self.currency == "USD" {
                return Money(amount: self.amount * 3 / 2, currency : toCurr)
            } else if self.currency == "GBP" {
                return Money(amount: self.amount / 3, currency : toCurr)
            } else if self.currency == "CAN" {
                return Money(amount: self.amount * 5 / 6, currency : toCurr)
            } else if self.currency == "EUR" {
                return Money(amount: self.amount, currency : toCurr)
            }
        } else if toCurr == "CAN" {
            if self.currency == "USD" {
                return Money(amount: self.amount * 5 / 4, currency : toCurr)
            } else if self.currency == "EUR" {
                return Money(amount: self.amount * 2 / 5, currency : toCurr)
            } else if self.currency == "GBP" {
                return Money(amount: self.amount * 6 / 5, currency : toCurr)
            } else if self.currency == "CAN" {
                return Money(amount: self.amount, currency : toCurr)
            }
        } else if toCurr == "USD"{
            if self.currency == "GBP" {
                return Money(amount: self.amount * 2, currency : toCurr)
            } else if self.currency == "EUR" {
                return Money(amount: self.amount * 2 / 3, currency: toCurr)
            } else if self.currency == "CAN" {
                return Money(amount: self.amount * 4 / 5, currency: toCurr)
            } else if self.currency == "USD" {
                return Money(amount: self.amount, currency: toCurr)
            }
        }
        return Money(amount: 0, currency: toCurr)
    }
    
    func add (_ other : Money) -> Money {
        let newSelf = self.convert(other.currency)
        return Money(amount: newSelf.amount + other.amount, currency: other.currency)
    }
    
    func subtract (_ other : Money) -> Money {
        let newSelf = self.convert(other.currency)
        return Money(amount: newSelf.amount - other.amount, currency: other.currency)
    }
}

class Job {
    var title: String
    var type: JobType
    
    enum JobType {
        case Salary(Int)
        case Hourly(Double)
    }
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    
    func calculateIncome (_ hours: Int) -> Int {
        switch type {
        case .Salary(let perYear):
            return perYear
        case .Hourly(let perHour):
            return Int(perHour) * hours
        }
    }
    
    func raise (_ amount: Double) {
        switch type {
        case .Salary(let perYear):
            self.type = .Salary(perYear + Int(amount))
        case .Hourly(let perHour):
            self.type = .Hourly(perHour + amount)
        }
    }
}

class Person {
    var firstName: String
    var lastName: String
    var age: Int
    var job: Job? {
        set (newJob){
            if self.age > 15 {
                self.job = newJob
            }
        }
        get {
            return self.job
        }
    }
    var spouse: Person? {
        set (newSpouse){
            if self.age > 17 {
                self.spouse = newSpouse
            }
        }
        get {
            return self.spouse
        }
    }
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        if age < 16 {
            self.job = nil
        }
        if age < 18 {
            self.spouse = nil
        }
    }
    
    func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job?.title) spouse:\(spouse)]"
    }
}


class Family {
    var family: [Person] = []
    
    init(spouse1: Person, spouse2: Person) {
        family.append(spouse1)
        family.append(spouse2)
        if spouse1.age >= 21 || spouse2.age >= 20 {
            if spouse1.spouse == nil && spouse2.spouse == nil  {
                spouse1.spouse = spouse2
                spouse2.spouse = spouse1
            }
        }
    }
    
    func householdIncome () -> Int {
        var totalIncome: Int = 0;
        if family.count > 0 {
            for index in 0...family.count - 1 {
                let person = family[index]
                totalIncome += (person.job?.calculateIncome(1))!
            }
        }
        return totalIncome
    }
    
    func haveChild (_ child: Person) -> Bool {
        if (family.count > 2) {
            return false;
        } else {
            family.append(child)
            return true;
        }
    }
}






























