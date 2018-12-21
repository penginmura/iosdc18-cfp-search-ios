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
            return search()
                .map { Mutation.updateList($0) } // TODO: 通信中のインジケータを表示したい
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .updateList(items):
            state.proposals = items
        }
        return state
    }

    func search() -> Observable<[Proposal]> {
        let url = URL(string: "https://iosdc-cfps.penginmura.tech/api.json")!
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data -> [Proposal] in
                let proposals = try JSONDecoder().decode(ProposalList.self, from: data)
                return proposals
            }
        // TODO: エラー処理
    }
}
