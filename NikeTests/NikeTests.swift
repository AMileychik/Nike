//
//  NikeTests.swift
//  NikeTests
//
//  Created by Александр Милейчик on 4/16/25.
//

import XCTest
@testable import Nike
import Foundation

class ShopControllerSpy: IShopController {

    var presenter: IShopPresenterProtocol

    required init(presenter: IShopPresenterProtocol) {
        self.presenter = presenter
    }

    var updateViewCalled = false

    func updateView() {
        updateViewCalled = true
    }

    func startLoading() {}
    func navigateToShopDetailSections(with product: Product) {}
    func navigateToShopListDetailSections(with product: Product) {}
}

class ShopPresenterSpy: IShopPresenterProtocol {

    var view: IShopController?

    var viewDidLoadCalled = false
    var buttonsDidTapCalled = false
    var buttonRemoveRecentlyViewedTapCalled = false

    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func handleButtonTap(_ index: Int) {
        buttonsDidTapCalled = true
    }

    func numberOfSections() -> Int {
        return 0
    }

    func sections(at index: Int) -> ShopSection? {
        return .none
    }

    func selectedButtonType() -> ButtonDataType {
        return .kids
    }

    func removeRecentlyViewed(for buttonType: ButtonDataType) {
        buttonRemoveRecentlyViewedTapCalled = true
    }

    func didSelectProduct(_ product: Product) {}

    func didSelectListCellProduct(_ product: Product) {}
}

class ProductServiceSpy: NetworkServiceProtocol {

    var loadHomeDataVCCalled = false
    var loadShopDataVCCalled = false
    var loadBagDataVCCalled = false
    var loadProfileDataVCCalled = false

    func loadHomeData(completion: @escaping (Result<HomeSectionsResponse, any Error>) -> ()) {
        loadHomeDataVCCalled = true
    }

    func loadShopData(completion: @escaping (Result<ShopSectionsResponse, any Error>) -> ()) {
        loadShopDataVCCalled = true
    }

    func loadBagVCProducts(completion: @escaping (Result<BagSectionsResponse, any Error>) -> ()) {
        loadBagDataVCCalled = true
    }
}

final class ShopTests: XCTestCase {

    func testPresenterCallsView() {

        // Given
        let shopPresenterSpy = ShopPresenterSpy()
        let shopVC = ShopViewController .init(presenter: shopPresenterSpy)
        shopPresenterSpy.view = shopVC

        // When
        let _ = shopVC.view // viewDidLoad()

        // Then
        XCTAssertTrue(shopPresenterSpy.viewDidLoadCalled)
    }

    func testPresenterServiceCallsLoadProducts() {

        // Given
        let productServiceSpy = ProductServiceSpy()
        let shopPresenter = ShopPresenter(shopLoader: productServiceSpy)

        // When
        shopPresenter.viewDidLoad()

        // Then
        XCTAssertTrue(productServiceSpy.loadShopDataVCCalled)
    }

    func testViewControllerCallUpdateView() {

        // Given
        let service = NetworkService()
        let shopPresenter = ShopPresenter.init(shopLoader: service)
        let shopControllerSpy = ShopControllerSpy.init(presenter: shopPresenter)
        shopPresenter.view = shopControllerSpy

        // When
        shopPresenter.viewDidLoad()

        let expectation = expectation(description: "Loading products")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        // Then
            XCTAssertTrue(shopControllerSpy.updateViewCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }

    func testPresenterCallsButtonTap() {

        // Given
        let presenter = ShopPresenterSpy()
        let shopTableViewDataSource = ShopTableViewDataSource(presenter: presenter)

        // When
        shopTableViewDataSource.handleButtonTap(index: 0)

        // Then
        XCTAssertTrue(presenter.buttonsDidTapCalled)
    }

    func testPresenterButtonTapCallsLoadProducts() {

        // Given
        let serviceSpy = ProductServiceSpy()
        let presenter = ShopPresenter(shopLoader: serviceSpy)

        // When
        presenter.handleButtonTap(1)

        print("loadShopVCCalled: \(serviceSpy.loadShopDataVCCalled)") // Отладка

        // Then
        XCTAssertTrue(serviceSpy.loadShopDataVCCalled)
    }

    func testPresenterButtonTapCallsUpdateView() {

        // Given
        let service = NetworkService()
        let presenter = ShopPresenter.init(shopLoader: service)
        let shopControllerSpy = ShopControllerSpy.init(presenter: presenter)
        presenter.view = shopControllerSpy

        // When
        presenter.handleButtonTap(1)

        let expectation = expectation(description: "Loading products")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        // Then
            XCTAssertTrue(shopControllerSpy.updateViewCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
}
