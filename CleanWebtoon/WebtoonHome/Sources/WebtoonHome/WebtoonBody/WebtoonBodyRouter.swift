//
//  WebtoonBodyRouter.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/28.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol WebtoonBodyRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol WebtoonBodyDataPassing {
    var dataStore: WebtoonBodyDataStore? { get }
}

class WebtoonBodyRouter: NSObject, WebtoonBodyRoutingLogic, WebtoonBodyDataPassing {
    weak var viewController: WebtoonBodyViewController?
    var dataStore: WebtoonBodyDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: WebtoonBodyViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: WebtoonBodyDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}