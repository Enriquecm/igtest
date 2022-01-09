//
//  MarketsViewModel.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

class MarketsViewModel {
    weak var coordinator: MarketsCoordinatorProtocol?

    init(coordinator: MarketsCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
