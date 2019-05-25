//
//  Funciones.swift
//  PokemonGo
//
//  Created by Jhonny Rivera on 5/24/19.
//  Copyright © 2019 Tecsup. All rights reserved.
//

import UIKit
import CoreData

var delegate = (UIApplication.shared.delegate as! AppDelegate)

func agregarPokemon() {
    crearPokemon(xnombre: "Mew", ximagenNombre: "mew")
    crearPokemon(xnombre: "Meowth", ximagenNombre: "meowth")
    crearPokemon(xnombre: "Abra", ximagenNombre: "abra")
    crearPokemon(xnombre: "Bullbasaur", ximagenNombre: "bullbasaur")
    crearPokemon(xnombre: "Dratini", ximagenNombre: "dratini")
    crearPokemon(xnombre: "Eevee", ximagenNombre: "eevee")
    crearPokemon(xnombre: "Mankey", ximagenNombre: "manket")
    crearPokemon(xnombre: "Pikachu", ximagenNombre: "pikachu-2")
    crearPokemon(xnombre: "Psyduck", ximagenNombre: "psyduck")
    crearPokemon(xnombre: "Rattata", ximagenNombre: "rattata")
    crearPokemon(xnombre: "Snorlax", ximagenNombre: "snorlax")
    crearPokemon(xnombre: "Squirtle", ximagenNombre: "squirtle")
    crearPokemon(xnombre: "Venonat", ximagenNombre: "venonat")
    crearPokemon(xnombre: "Weedle", ximagenNombre: "weedle")
    crearPokemon(xnombre: "Zubat", ximagenNombre: "zubat")
    delegate.saveContext()
}

func obtenerPokemonsNoAtrapados() -> [Pokemon] {
    let context = delegate.persistentContainer.viewContext
    let queryConWhere = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    queryConWhere.predicate = NSPredicate(format: "atrapado == %@", NSNumber(booleanLiteral: true))
    
    do{
        let pokemons = try context.fetch(queryConWhere) as [Pokemon]
        return pokemons
        
    }catch { }
    return[]
}

func obtenerPokemonsAtrapados() -> [Pokemon] {
    let context = delegate.persistentContainer.viewContext
    let queryConWhere = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    queryConWhere.predicate = NSPredicate(format: "atrapado == %@", NSNumber(booleanLiteral: true))
    
    do{
        let pokemons = try context.fetch(queryConWhere) as [Pokemon]
        return pokemons
        
    }catch { }
    return[]
}

func crearPokemon(xnombre:String, ximagenNombre:String) {
    let context = delegate.persistentContainer.viewContext
    let pokemon = Pokemon(context: context)
    pokemon.nombre = xnombre
    pokemon.imagen = ximagenNombre
}

func obtenerPokemons() -> [Pokemon] {
    let context = delegate.persistentContainer.viewContext
    
    do{
        let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        
        if pokemons.count == 0 {
            agregarPokemon()
            return obtenerPokemons()
        }
        return pokemons
    }catch{ }
    return[]
}


