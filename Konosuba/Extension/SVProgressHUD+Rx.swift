//
//  SVProgressHUD+Rx.swift
//  Konosuba
//
//  Created by Yusuke Hosonuma on 2018/12/10.
//  Copyright © 2018 Yusuke Hosonuma. All rights reserved.
//

import RxSwift
import SVProgressHUD

// TODO: もっと効率的なやりかたある気がする

extension Reactive where Base: SVProgressHUD {
    static var visible: SVProgressHUDObserver {
        return SVProgressHUDObserver.shared
    }
}

class SVProgressHUDObserver: ObserverType {
    static let shared = SVProgressHUDObserver()

    func on(_ event: Event<Bool>) {
        switch event {
        case let .next(visible):
            if visible {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        case .error:
            break
        case .completed:
            break
        }
    }
}
