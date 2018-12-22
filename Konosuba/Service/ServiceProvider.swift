//
//  ServiceProvider.swift
//  Konosuba
//
//  Created by Yusuke Hosonuma on 2018/12/22.
//  Copyright © 2018 Yusuke Hosonuma. All rights reserved.
//

protocol ServiceProviderType {
    var proposalService: ProposalServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    var proposalService: ProposalServiceType = ProposalService()
}
