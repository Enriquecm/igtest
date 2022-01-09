//
//  ArticleDetailViewModel.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

class ArticleDetailViewModel {
    weak var coordinator: ArticleDetailCoordinatorProtocol?

    init(coordinator: ArticleDetailCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
