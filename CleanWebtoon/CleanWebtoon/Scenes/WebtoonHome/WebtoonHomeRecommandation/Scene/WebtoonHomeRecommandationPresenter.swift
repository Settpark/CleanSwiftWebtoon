//
//  WebtoonHomeRecommandationPresenter.swift
//  CleanWebtoon
//
//  Created by temp_name on 2023/08/16.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WebtoonHomeRecommandationPresentationLogic
{
  func presentSomething(response: WebtoonHomeRecommandation.RecommandationWebtoonModel.Response)
}

class WebtoonHomeRecommandationPresenter: WebtoonHomeRecommandationPresentationLogic
{
  weak var viewController: WebtoonHomeRecommandationDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: WebtoonHomeRecommandation.RecommandationWebtoonModel.Response)
  {
//    let viewModel = WebtoonHomeRecommandation.Something.ViewModel()
//    viewController?.displaySomething(viewModel: viewModel)
  }
}