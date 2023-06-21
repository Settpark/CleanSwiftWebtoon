//
//  WebtoonHomeRouter.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/06/21.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol WebtoonHomeRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol WebtoonHomeDataPassing
{
  var dataStore: WebtoonHomeDataStore? { get }
}

class WebtoonHomeRouter: NSObject, WebtoonHomeRoutingLogic, WebtoonHomeDataPassing
{
  weak var viewController: WebtoonHomeViewController?
  var dataStore: WebtoonHomeDataStore?
  
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
  
  //func navigateToSomewhere(source: WebtoonHomeViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: WebtoonHomeDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
