//
//  ArticleDetailViewModel.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 09/01/22.
//

import Foundation

class ArticleDetailViewModel {
    private weak var coordinator: ArticleDetailCoordinatorProtocol?

    let report: Report

    init(coordinator: ArticleDetailCoordinatorProtocol, report: Report) {
        self.coordinator = coordinator
        self.report = report
    }
}
