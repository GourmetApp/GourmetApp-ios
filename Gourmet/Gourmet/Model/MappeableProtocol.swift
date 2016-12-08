//
//  MappeableProtocol.swift
//  Gourmet
//
//  Created by David Martinez on 08/12/2016.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation

protocol MappeableProtocol {
    
    associatedtype SOURCE
    associatedtype RESULT
    
    func map(source: SOURCE) -> RESULT?
    
}
