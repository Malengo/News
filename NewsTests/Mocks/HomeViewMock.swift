//
//  HomeViewMock.swift
//  NewsTests
//
//  Created by Malengo on 04/06/24.
//

import UIKit
@testable import News

class HomeViewMock: UIView, HomeViewProtocol
{
    var searchBar: UISearchBar = UISearchBar()
    
    var collection: UICollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
    
    var categoryCollectionView: UICollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
    
    var wasBuildViewHierachyCalled = false
    var wasSetupConstraintCalled = false
    var wasAddictionalConfigurationCalled = false
    func buildViewHierachy() {
        wasBuildViewHierachyCalled = true
    }
    
    func setupConstraints() {
        wasSetupConstraintCalled = true
    }
    
    func addictionalConfiguration() {
        wasAddictionalConfigurationCalled = true
    }
    
    
}
