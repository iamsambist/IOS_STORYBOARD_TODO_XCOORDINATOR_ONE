//
//  AppCoordinator.swift
//  ProjectOneWithXco
//
//  Created by MacBook Two on 13/12/2024.
//

import Foundation
import XCoordinator

enum AppRoutes : Route {
    case home(message : String? = nil)
    case entry
    case task(message : String)
    case pop
}

class AppCoordinator : NavigationCoordinator<AppRoutes>{

    init() {
        super .init(initialRoute: .home())
    }
    
    override func prepareTransition(for route: AppRoutes) -> NavigationTransition {
     
          switch route {
          case .home(let message):
              let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
              guard let homeViewController = storyboard.instantiateViewController(withIdentifier: "view") as? ViewController else {
                  fatalError("ViewController could not be instantiated from storyboard.")
              }
              homeViewController.onAddItemTapped = { [weak self] in
                  self?.trigger(.entry)
              }
              homeViewController.showTask = { newTask in
                  self.trigger(.task(message: newTask))
                  
              }
              if let message = message {
                  homeViewController.message = message
                  
              }
              return .push(homeViewController)

          case .entry:
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              guard let entryViewController = storyboard.instantiateViewController(withIdentifier: "entry") as? EntryViewController else {
                  fatalError("ViewController could not be instantiated from storyboard.")
              }
              entryViewController.onSaveTaskAction = { [weak self] newTask in
                  guard let self = self else { return }
                       // Access the previous view controller in the stack
                       if let navigationController = self.rootViewController as? UINavigationController,
                          let homeViewController = navigationController.viewControllers.last(where: { $0 is ViewController }) as? ViewController {
                           // Set the message property
                           homeViewController.message = newTask
                       }
              
                  self.trigger(.pop)
                  
              }
              return .push(entryViewController)
              
          case .pop:
              return .pop()
              
          case .task(let message):
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              guard let taskViewController = storyboard.instantiateViewController(withIdentifier: "task") as? TaskViewController else {
                  fatalError("ViewController could not be instantiated from storyboard.")
              }
              taskViewController.message = message
              taskViewController.deleteButtonTapped = { deletedTask in
                  if let navigationController = self.rootViewController as? UINavigationController,
                     let homeViewController = navigationController.viewControllers.last(where: { $0 is ViewController }) as? ViewController {
                      // Set the message property
                      homeViewController.deleteTaskFlag = true
                      homeViewController.deleteTaskValue = deletedTask
                  }
                  self.trigger(.pop)
              }
              
              return .push(taskViewController)
              
              

          }
      }
}
