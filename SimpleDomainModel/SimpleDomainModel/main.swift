//
//  main.swift
//  SimpleDomainModel
//
//  Created by Matt Bond on 10/16/16.
//  Copyright © 2016 Matt Bond. All rights reserved.
//

import Foundation


struct Money {
    
    var amount : Int = 0
    var currency : String = ""
    
    init(amount : Int, currency : String) {
        self.amount = amount
        self.currency = currency
    }
    
    func convert (_ toCurr : String) -> Money {
        if toCurr == "GDP" {
            return Money(amount: self.amount / 2, currency : toCurr)
        } else if toCurr == "EUR" {
            return Money(amount: self.amount * 3 / 2, currency: toCurr)
        } else if toCurr == "CAN" {
            return Money(amount: self.amount * 5 / 4, currency: toCurr)
        } else if toCurr == "USD"{
            return Money(amount: self.amount, currency: toCurr)
        } else {
            return Money(amount: 0, currency: toCurr);
        }
    }
    
    func add (_ other : Money) -> Money {
        let newOther = convert(other.currency)
        return Money(amount: self.amount + newOther.amount, currency: self.currency)
    }
    
    func subtract(_ other: Money) -> Money {
        let newOther = convert(other.currency)
        return Money(amount: self.amount - newOther.amount, currency: self.currency)
    }
}

class Job {
    var title: String
    var type: JobType
    
    enum JobType {
        case salary(Int)
        case hourly(Double)
    }
    
    init(_ title: String,_ type: JobType) {
        self.title = title
        self.type = type
    }
    
    func calculateIncome (_ hours: Int) -> Int {
        switch type {
        case .salary(let perYear):
            return perYear
        case .hourly(let perHour):
            return Int(perHour) * hours
        }
    }
    
    func raise (_ amount: Double) {
        switch type {
        case .salary(let perYear):
            self.type = .salary(perYear + Int(amount))
        case .hourly(let perHour):
            self.type = .hourly(perHour + amount)
        }
    }
}





















