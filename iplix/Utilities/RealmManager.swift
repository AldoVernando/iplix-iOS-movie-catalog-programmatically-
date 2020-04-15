//
//  RealmManager.swift
//  iplix
//
//  Created by TEMP on 4/15/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    let realmInit = try! Realm()
}


// MARK: Functions
extension RealmManager {
    
    
    // save data
    func saveFavMovie(fav: FavoriteMovie) {
        do {
            try realmInit.write {
                realmInit.add(fav)
            }
        } catch {
            print("Error saving \(error)")
        }
    }
    
    
    // delete data
    func deleteFavMovie(fav: FavoriteMovie) {
        do {
            try realmInit.write {
                realmInit.delete(fav)
            }
        } catch {
            print("Error deleting \(error)")
        }
    }
    
}
