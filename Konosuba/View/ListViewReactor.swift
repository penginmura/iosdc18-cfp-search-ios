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

    init() {
        initialState = State(proposals: [], isLoading: false)
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                search().map { Mutation.updateList($0) },
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

    func search() -> Observable<[Proposal]> {
        let url = URL(string: "https://iosdc-cfps.penginmura.tech/api/v1/proposals")!
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data -> [Proposal] in
                let proposals = try JSONDecoder().decode(ProposalList.self, from: data)
                return proposals
            }
        // TODO: エラー処理
    }
}
