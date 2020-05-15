//
//  EmptyState.swift
//  stateMachine
//
//  Created by Jie liang Huang on 2020/5/15.
//  Copyright © 2020 com.jie.stateMachine. All rights reserved.
//

import UIKit
import GameplayKit

class EmptyState: ViewControllerState {

    var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override func didEnter(from previousState: GKState?) {
        view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        let button = UIButton(type: .system)
        emptyView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.addTarget(self, action: #selector(retry), for: .touchUpInside)
        button.setTitle("start", for: .normal)
    }

    override func willExit(to nextState: GKState) {
        emptyView.removeFromSuperview()
    }
}

extension EmptyState {
    @objc func retry() {
        stateMachine?.enter(LoadingState.self)
    }
}
