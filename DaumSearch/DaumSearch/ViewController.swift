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
    var direction = 0
    
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
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let viewHighlight : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
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
        setHighlightView()
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
        let firstIndex = IndexPath(item: 0, section: 0)
        collectionViewUpper.selectItem(at: firstIndex, animated: false, scrollPosition: .right)
        
        self.view.addSubview(collectionViewUpper)
        collectionViewUpper.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.textFieldSearch.snp.bottom)
            make.height.equalTo(100)
        }
    }
    func setHighlightView() {
        self.view.addSubview(viewHighlight)
        viewHighlight.snp.makeConstraints { make in
            make.leading.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(self.view).multipliedBy(0.33)
            make.bottom.equalTo(collectionViewLower.snp.top)
            make.height.equalTo(5)
        }
    }
    func setLowerCollectionView() {
        self.collectionViewLower.delegate = self
        self.collectionViewLower.dataSource = self
        self.collectionViewLower.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.resueidentifier)
        self.collectionViewLower.isPagingEnabled = true
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
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.resueidentifier, for: indexPath) as? ContentCollectionViewCell
            else { return UICollectionViewCell() }
            
            cell.setIndexView(indexPath.row)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewUpper {
            return CGSize(width: collectionView.frame.width/3, height: 90)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewUpper {
            guard let cell = collectionViewUpper.cellForItem(at: indexPath) as? MenuCollectionViewCell else { return }
            
            //updateConstranint의 경우, 기존 설정해놨던 constraint와 같은 곳에서만 조절 가능.
            //ex. leading을 view 기준으로 해놨다면 update도 view 기준으로만 설정 가능.
            self.viewHighlight.snp.remakeConstraints { make in
                make.leading.trailing.equalTo(cell)
                make.bottom.equalTo(self.collectionViewLower.snp.top)
                make.height.equalTo(5)
            }
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
            collectionViewLower.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension ViewController {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == collectionViewLower {
            let index = Int(targetContentOffset.pointee.x / collectionViewLower.frame.width)
            let indextPath = IndexPath(item: index, section: 0)
            
            collectionViewUpper.selectItem(at: indextPath, animated: true, scrollPosition: .bottom)
            collectionView(collectionViewUpper, didSelectItemAt: indextPath)
            
            if direction > 0 {
                collectionViewUpper.scrollToItem(at: indextPath, at: .centeredHorizontally, animated: true)
            } else {
                collectionViewUpper.scrollToItem(at: indextPath, at: .left, animated: true)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
        
        if velocity.x < 0 {
            direction = -1
        } else if velocity.x > 0 {
            direction = 1
        }
    }
}
