//
//  ReusableView.swift
//  Bins
//
//  Created by Julian Weiss on 8/22/17.
//  Copyright © 2017 Julian Weiss. All rights reserved.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String {
        get
        set
    }
}
