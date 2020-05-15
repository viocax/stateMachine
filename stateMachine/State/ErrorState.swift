//
//  ErrorState.swift
//  stateMachine
//
//  Created by Jie liang Huang on 2020/5/15.
//  Copyright © 2020 com.jie.stateMachine. All rights reserved.
//

import Foundation
import GameplayKit

class ErrorState: ViewControllerState, InjectionHandler {
    private var error: Error?
    func inject(object: Error) {
        self.error = object
    }
    override func didEnter(from previousState: GKState?) {
        guard let error = error else {
            return
        }

        let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: { [weak self] _ in
            self?.stateMachine?.enter(EmptyState.self)
        })
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }

    override func willExit(to nextState: GKState) {
        
    }
}
