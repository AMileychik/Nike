//
//  File.swift
//
//
//  Created by Александр Милейчик on 1/3/26.
//

import Foundation

/*
 
 Home feature
 
 Focusing on the Home feature, I applied MVVM, dependency injection, factory pattern and coordinators.
 
 Let me show you everything in code.
 
 1. HomeViewController
 
 So HomeViewController is the entry point to the Home feature and very thin, because it’s responsible only for:
 
 - Handling the view lifecycle.
 - Displaying UI state updates.
 - Forwarding user interactions to responsible components:
 `ContentView`, `ViewModel`, `Binder`, `Coordinator.
 
 Also it uses Generic ContentView which allowes replace different Views such as TableView or CollectionView or mock container при этом using protocols making VC agnostic (to what???)
 In addition I use BaseViewController который берет на себя инфраструктуру layout + lifecycle делая HomeVC тонким
 
 All UI Dependencies are injected via Init for bette tesybility and ....
 
 All UI Dependencies создаются централизовано в фабрике  HomeUIComponentsFactory что дает преимущества .....
 
 дальше идет весь необходимый функционал для UI Dependencies
 
 
 */
