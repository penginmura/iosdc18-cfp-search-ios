//
//  ListViewReactor.swift
//  Konosuba
//
//  Created by Yusuke Hosonuma on 2018/12/09.
//  Copyright © 2018 Yusuke Hosonuma. All rights reserved.
//

import Alamofire
import ReactorKit
import RxSwift

final class ListViewReactor: Reactor {
    enum Action {
        case initialView
        case refresh
    }

    enum Mutation {
        case updateList([Proposal])
        case setLoading(Bool)
    }

    struct State {
        var proposals: [Proposal]
        var isLoading: Bool
    }

    let initialState: State
    let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        initialState = State(proposals: [], isLoading: false)
        self.provider = provider
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .initialView, .refresh:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                provider.proposalService.fetch().map { Mutation.updateList($0) },
                Observable.just(Mutation.setLoading(false)),
            ])
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .updateList(items):
            state.proposals = items
        case let .setLoading(loading):
            state.isLoading = loading
        }
        return state
    }
}
