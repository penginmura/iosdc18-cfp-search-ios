//
//  ProposalService.swift
//  Konosuba
//
//  Created by Yusuke Hosonuma on 2018/12/22.
//  Copyright © 2018 Yusuke Hosonuma. All rights reserved.
//

import RxSwift

protocol ProposalServiceType {
    func fetch() -> Observable<[Proposal]>
}

final class ProposalService: ProposalServiceType {
    func fetch() -> Observable<[Proposal]> {
        let url = URL(string: "https://iosdc-cfps.penginmura.tech/api/v1/proposals")!
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data -> [Proposal] in
                let proposals = try JSONDecoder().decode(ProposalList.self, from: data)
                return proposals
            }
        // TODO: エラー処理
    }
}
