//
//  FavoriteMovie.swift
//  iplix
//
//  Created by TEMP on 4/15/20.
//  Copyright © 2020 aldovernando. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteMovie: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var poster_path: String = ""
    @objc dynamic var genre: String = ""
}
