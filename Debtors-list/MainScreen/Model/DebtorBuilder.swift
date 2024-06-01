//
//  DebtorBuilder.swift
//  Debtors-list
//
//  Created by Vlad Lytvynets on 18.04.2024.
//

import Foundation

class DebtorBuilder {
    
    private var debtor: Debtor
    
    
    init() {
        self.debtor = Debtor()
    }
    
    
    func setName(_ name: String) -> DebtorBuilder {
        debtor.name = name
        return self
    }
    
    
    func setLastName(_ lastName: String) -> DebtorBuilder {
        debtor.lastName = lastName
        return self
    }
    
    
    func setSum(_ sum: Double) -> DebtorBuilder {
        debtor.sum = sum
        return self
    }
    
    
    
    func setCurrency(_ currency: String) -> DebtorBuilder {
        debtor.currency = currency
        return self
    }
    
    
    func setDate(_ date: String) -> DebtorBuilder {
        debtor.date = date
        return self
    }
    
    
    func setTypeOfDebt(_ givenDebt: Bool) -> DebtorBuilder {
        debtor.givenDebt = givenDebt
        return self
    }
    
    
    func buildDebtor() -> Debtor {
        return debtor
    }
}
