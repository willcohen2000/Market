//
//  LandingController.swift
//  MarketAPP
//
//  Created by Will Cohen on 10/8/17.
//  Copyright © 2017 Will Cohen. All rights reserved.
//

import UIKit

class LandingController: UIViewController {

    @IBOutlet weak var firstFeatureIndicator: UIImageView!
    @IBOutlet weak var secondFeatureIndicator: UIImageView!
    @IBOutlet weak var thirdFeatureIndicator: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeIndicator(images: [firstFeatureIndicator, secondFeatureIndicator, thirdFeatureIndicator], pageNum: 0)
    }
    
     func changeIndicator(images: [UIImageView], pageNum: Int) {
        let imageDictionary: [Int:UIImageView] = [
            0: firstFeatureIndicator,
            1: secondFeatureIndicator,
            2: thirdFeatureIndicator
        ]
        
        for (image) in images {
            if (imageDictionary[pageNum] == image) {
                imageDictionary[pageNum]?.layer.backgroundColor = UIColor.white.cgColor
                imageDictionary[pageNum]?.layer.cornerRadius = (image.frame.width / 2)
            } else {
                makeCircular(indicator: image)
            }
        }
        
    }
    
    private func makeCircular(indicator: UIImageView) {
        indicator.layer.cornerRadius = (indicator.frame.width / 2)
        indicator.layer.borderWidth = 1.0
        indicator.layer.borderColor = UIColor.white.cgColor
        indicator.backgroundColor = UIColor.clear
    }
    
}

extension LandingController: pageChangePro {
    func pageChanged(_ pageNumber: Int) {
        changeIndicator(images: [firstFeatureIndicator, secondFeatureIndicator, thirdFeatureIndicator], pageNum: pageNumber)
    }
}

extension LandingController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "containerSegue") {
            if let featurePage = segue.destination as? FeatureListPageController {
                featurePage.pageChange = self
            }
        }
    }
}
