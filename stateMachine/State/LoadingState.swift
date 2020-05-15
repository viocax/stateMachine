//
//  LoadingState.swift
//  stateMachine
//
//  Created by Jie liang Huang on 2020/5/15.
//  Copyright © 2020 com.jie.stateMachine. All rights reserved.
//

import Foundation
import Combine
import GameplayKit

class LoadingState: ViewControllerState {

    enum ErrorCase: Error {
        case noData, missURL, someError(Error)
    }
    private var cannel: Set<AnyCancellable> = Set<AnyCancellable>()

    private var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    private var userCase: UserCase?

    convenience init(_ viewController: UIViewController, userCase: UserCase) {
        self.init(viewController)
        self.userCase = userCase
    }

    override func didEnter(from previousState: GKState?) {
        view.addSubview(indicatorView)
        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorView.startAnimating()

        do {
            let task = try userCase?.fetchData(Models<[Info]>.self)
            task?.sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.stateMachine?.state(forClass: ErrorState.self)?.inject(object: error)
                        self?.stateMachine?.enter(ErrorState.self)
                    }
                }
            }, receiveValue: { [weak self] (model) in
                DispatchQueue.main.async {
                    self?.stateMachine?.state(forClass: DataState.self)?.inject(object: model.results)
                    self?.stateMachine?.enter(DataState.self)
                }
            }).store(in: &cannel)
        } catch {
            stateMachine?.state(forClass: ErrorState.self)?.inject(object: error)
            stateMachine?.enter(ErrorState.self)
        }
    }

    override func willExit(to nextState: GKState) {
        self.indicatorView.stopAnimating()
        self.indicatorView.removeFromSuperview()
    }
}
