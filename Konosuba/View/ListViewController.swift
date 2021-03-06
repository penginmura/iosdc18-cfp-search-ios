//
//  ViewController.swift
//  Konosuba
//
//  Created by Yusuke Hosonuma on 2018/12/08.
//  Copyright © 2018 Yusuke Hosonuma. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift
import SVProgressHUD
import UIKit

final class ListViewController: UIViewController, StoryboardView {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var refreshButton: UIBarButtonItem!

    var disposeBag = DisposeBag()

    func bind(reactor: ListViewReactor) {
        // Action
        rx.viewWillAppear
            .map { Reactor.Action.initialView }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        refreshButton.rx.tap
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // State
        reactor.state.map { $0.proposals }
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { _, proposal, cell in
                cell.textLabel?.text = proposal.title
                cell.detailTextLabel?.text = proposal.user
            }
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.isLoading }
            .bind(to: SVProgressHUD.rx.visible)
            .disposed(by: disposeBag)
    }
}
