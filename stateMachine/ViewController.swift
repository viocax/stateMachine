//
//  ViewController.swift
//  stateMachine
//
//  Created by Jie liang Huang on 2020/5/15.
//  Copyright © 2020 com.jie.stateMachine. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    var stateMachine: GKStateMachine?

    override func viewDidLoad() {
        super.viewDidLoad()

        stateMachine = GKStateMachine(states: [
            EmptyState(self),
            LoadingState(self, userCase: UserCase("https://randomuser.me/api/?results=5")),
            ErrorState(self),
            DataState(self)
        ])

        stateMachine?.enter(EmptyState.self)
    }
}

class ViewControllerState: GKState {

    unowned let viewController: ViewController

    var view: UIView { viewController.view }

    init(_ viewController: ViewController) {
        self.viewController = viewController
        viewController.view.backgroundColor = .white
    }
}
