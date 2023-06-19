//
//  ViewController.swift
//  DaumSearch
//
//  Created by 노영재 on 2023/05/23.
//

import UIKit

class ViewController: BaseViewController {
    //MARK: Property
    var coordinator : Coordinator?
    
    let textFieldSearch : UITextField = {
        let textField = UITextField()
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .black
        
        textField.leftView = imageView
        textField.leftViewMode = .always
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .gray
        
        textField.rightView = button
        textField.rightViewMode = .always
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        
        return textField
    }()
    
    let collectionViewUpper: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let collectionViewLower: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
    }
    
    //MARK: Configure
    func configure() {
        setTextFieldSearch()
        setUpperCollectionView()
        setLowerCollectionView()
    }
    
    func setTextFieldSearch() {
        self.view.addSubview(textFieldSearch)
        textFieldSearch.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    func setUpperCollectionView() {
        self.collectionViewUpper.delegate = self
        self.collectionViewUpper.dataSource = self
        self.collectionViewUpper.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.resueidentifier)
        
        self.view.addSubview(collectionViewUpper)
        collectionViewUpper.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.textFieldSearch.snp.bottom)
            make.height.equalTo(100)
        }
    }
    
    func setLowerCollectionView() {
        self.collectionViewLower.delegate = self
        self.collectionViewLower.dataSource = self
        self.collectionViewLower.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.resueidentifier)
        
        self.view.addSubview(collectionViewLower)
        collectionViewLower.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.collectionViewUpper.snp.bottom)
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewUpper {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.resueidentifier, for: indexPath) as? MenuCollectionViewCell
            else { return UICollectionViewCell() }
            cell.setTitle(indexPath.row)
            if indexPath.row == 0 {
                cell.isSelected = true
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.resueidentifier, for: indexPath) as? ContentCollectionViewCell
            else { return UICollectionViewCell() }

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewUpper {
            return CGSize(width: 120, height: 90)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.bounds.height)
        }
    }
    
}
