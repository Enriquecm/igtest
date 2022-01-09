//
//  ArticlesViewModel.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

class ArticlesViewModel {
    weak var coordinator: ArticlesCoordinatorProtocol?

    init(coordinator: ArticlesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
