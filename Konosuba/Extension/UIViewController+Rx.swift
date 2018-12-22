//
//  UIViewController+Rx.swift
//  Konosuba
//
//  Created by Yusuke Hosonuma on 2018/12/22.
//  Copyright © 2018 Yusuke Hosonuma. All rights reserved.
//

import RxCocoa
import RxSwift

// 参考：
// https://qiita.com/sgr-ksmt/items/e259e00f5c0a2f3109ff

extension Reactive where Base: UIViewController {
    var viewWillAppear: Observable<Void> {
        return sentMessage(#selector(base.viewWillAppear(_:)))
            .map { _ in () }
            .share(replay: 1)
    }
}
