//
//  Presenter.swift
//  VIPERLearningProject
//
//  Created by Tatiana Bondarenko on 3/4/23.
//

import Foundation

// Class, Protocol
// Talks to onteractor, router and view

enum NetworkError: Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}

    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>)
}

class CryptoPresenter: AnyPresenter {
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(let _):
            view?.update(with: "Try later...")
        }
    }

    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCryptos()
        }
    }

    var view: AnyView?

    var router: AnyRouter?
}
