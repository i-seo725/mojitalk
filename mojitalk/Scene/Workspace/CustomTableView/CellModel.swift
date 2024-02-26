//
//  CellModel.swift
//  mojitalk
//
//  Created by 이은서 on 2/26/24.
//

import Foundation
import RxDataSources

struct CellModel {
    enum CellImage: String {
        case hashtagThick
        case hashtagThin
        case plusIcon
    }
    
    var text: String
    var image: CellImage
    
    init(text: String, image: CellImage) {
        self.text = text
        self.image = image
    }
}

struct CustomSection {
    var header: String
    var items: [Item]
}

extension CustomSection: SectionModelType {
    typealias Item = CellModel
    
    init(original: CustomSection, items: [CellModel]) {
        self = original
        self.items = items
    }
}
