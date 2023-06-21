//
//  ContentCollectionViewCell.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/06/19.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    //MARK: Property
    static let resueidentifier = "ContentCollectionViewCell"
    private let viewColor : [UIColor] = [.blue, .red, .brown]
    
    let viewContent : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configure
    func setIndexView(_ index: Int) {
        viewContent.backgroundColor = viewColor[index]
    }
}
