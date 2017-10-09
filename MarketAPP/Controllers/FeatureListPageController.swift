//
//  FeatureListPageController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

protocol pageChangePro {
    func pageChanged(_ pageNumber: Int)
}

class FeatureListPageController: UIPageViewController {

    lazy var featureList: [UIViewController] = {
        let storyboardObject = UIStoryboard(name: "Main", bundle: nil)
        let firstFeature = storyboardObject.instantiateViewController(withIdentifier: "firstFeature") as! FirstFeatureController
        firstFeature.delegate = self
        let secondFeature = storyboardObject.instantiateViewController(withIdentifier: "secondFeature") as! SecondFeatureController
        secondFeature.delegate = self
        let thirdFeature = storyboardObject.instantiateViewController(withIdentifier: "thirdFeature") as! ThirdFeatureController
        thirdFeature.delegate = self
        return [firstFeature, secondFeature, thirdFeature]
    }()
    
    var pageChange: pageChangePro!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        if let firstVC = featureList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }

}

extension FeatureListPageController: firstFeatureActivatedProtocol, secondFeatureActivatedProtocol, thirdFeatureActivatedProtocol {
    
    func firstFeatureActivated() {
        pageChange.pageChanged(0)
    }
    
    func secondFeatureActivated() {
        pageChange.pageChanged(1)
    }
    
    func thirdFeatureActivated() {
        pageChange.pageChanged(2)
    }
    
}

extension FeatureListPageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if (viewController == featureList[0]) {
            return nil
        } else if (viewController == featureList[1]) {
            return featureList[0]
        } else if (viewController == featureList[2]) {
            return featureList[1]
        } else {
            return nil
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if (viewController == featureList[0]) {
            return featureList[1]
        } else if (viewController == featureList[1]) {
            return featureList[2]
        } else {
            return nil
        }
    }
    
}
