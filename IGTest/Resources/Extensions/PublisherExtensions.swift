//
//  PublisherExtensions.swift
//  IGTest
//
//  Created by Enrique Melgarejo on 11/01/22.
//

import Combine
import Foundation

extension Publisher {
    /// Handle fetch status. `True` if it is fetching and `False` if it finish successfully, with error or cancelled
    func observeFetchStatus<S: Subject>(
        with booleanSubject: S
    ) -> Publishers.HandleEvents<Self> where S.Output == Bool, S.Failure == Never {
        return handleEvents(receiveSubscription: { _ in
            booleanSubject.send(true)
        }, receiveCompletion: { _ in
            booleanSubject.send(false)
        }, receiveCancel: {
            booleanSubject.send(false)
        })
    }
}
