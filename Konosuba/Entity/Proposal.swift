//
//  Proposal.swift
//  Konosuba
//
//  Created by Yusuke Hosonuma on 2018/12/09.
//  Copyright © 2018 Yusuke Hosonuma. All rights reserved.
//

typealias ProposalList = [Proposal]

struct Proposal: Codable {
    let title: String
    let user: String
    enum CodingKeys: String, CodingKey {
        case title
        case user
    }
}
