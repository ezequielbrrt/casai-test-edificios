//
//  main.swift
//  test_casai_ios
//
//  Created by Ezequiel Barreto on 03/12/20.
//

import Foundation

/*
 
 El equipo de operaciones de Casai necesita un programa que sea capaz de decir cuántos departamentos disponibles quedan en el edificio cada que un departamento es ocupado. El sistema debe poder registrar el número de edificios que tiene Casai. Además, se debe poder registrar que un departamento está ocupado.

 BONUS: Existe una regla, ningún departamento puede ser ocupado si está debajo de uno ya ocupado.
 
 */

class Departamento {
    let id: Int
    var disponible: Bool
    
    init(id: Int, disponible: Bool) {
        self.id = id
        self.disponible = disponible
    }
}

struct Edificio {
    let id: String
    let departamentos: [Departamento]
    
    func getDepartamentosDisponibles() -> Int {
        departamentos.filter { $0.disponible == true }.count
    }
    
    func ocuparDepartamento() -> Int? {
        if let departamentoDisponible = (departamentos.first { $0.disponible == true }), verificarDepartamentoArribaEstaDisponible(withDepartamentoId: departamentoDisponible.id) {
            departamentoDisponible.disponible = false
        }
        return getDepartamentosDisponibles()
    }
}

extension Edificio {
    private func verificarDepartamentoArribaEstaDisponible(withDepartamentoId id: Int) -> Bool {
        if (id + 1) <= departamentos.count {
            return departamentos[id].disponible
        }
        return true
    }
}

struct Administrador {
    let edificios: [Edificio]
    
    func obtenerNumeroEdificios() -> Int {
        self.edificios.count
    }
}


let admin = Administrador(edificios: [Edificio(id: "1", departamentos: [Departamento(id: 1, disponible: false),
                                                                        Departamento(id: 2, disponible: false),
                                                                        Departamento(id: 3, disponible: true),
                                                                        Departamento(id: 4, disponible: false)])])
let edificio = admin.edificios.first
let numDisponibles = edificio?.ocuparDepartamento()
print(numDisponibles)
