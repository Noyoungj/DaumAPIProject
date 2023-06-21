//
//  MenuCollectionViewCell.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/06/19.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    //MARK: Properties
    static let resueidentifier = "MenuCollectionViewCell"
    var menuName = ["이미지", "동영상", "블로그"]
    
    let viewContent : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let labelMenu : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        viewContent.addSubview(labelMenu)
        labelMenu.snp.makeConstraints { make in
            make.edges.equalTo(viewContent)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
    
    //MARK: Configure
    override var isSelected: Bool {
        willSet {
            if newValue {
                labelMenu.textColor = .black
            } else {
                labelMenu.textColor = .lightGray
            }
        }
    }
    
    func setTitle(_ index: Int) {
        labelMenu.text = self.menuName[index]
    }
}
