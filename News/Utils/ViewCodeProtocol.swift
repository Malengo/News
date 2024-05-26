//
//  ViewCodeProtocol.swift
//  News
//
//  Created by Malengo on 26/05/24.
//

import UIKit

protocol ViewCodeProtocol: UIView {
    func buildViewHierachy()
    func setupConstraints()
    func addictionalConfiguration()
}

extension ViewCodeProtocol {
    func setupView() {
        buildViewHierachy()
        setupConstraints()
        addictionalConfiguration()
    }
}
