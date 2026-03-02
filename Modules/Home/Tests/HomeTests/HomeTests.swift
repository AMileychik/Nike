import XCTest
import Combine
@testable import Home
@testable import AppDomain
@testable import AppInterface
@testable import Services

final class HomeTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []

    // MARK: - ViewModel loadProducts Success
    
    func testLoadProductsSuccess() async throws {
        let mockUseCase = MockUseCase()
        mockUseCase.response = HomeSectionsResponse(from: ["TestSection"])
        let viewModel = HomeViewModel(useCase: mockUseCase)

        let expectation = expectation(description: "State changes to loaded")

        viewModel.statePublisher
            .dropFirst() // skip initial
            .sink { state in
                if case .loaded = state { expectation.fulfill() }
            }
            .store(in: &cancellables)

        viewModel.loadProducts()

        await fulfillment(of: [expectation], timeout: 1.0)
        

        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.section(at: 0)?.title, "TestSection")
    }

    // MARK: - ViewModel loadProducts Failure
    func testLoadProductsFailure() async throws {
        let mockUseCase = MockUseCase()
        mockUseCase.shouldThrow = true
        let viewModel = await HomeViewModel(useCase: mockUseCase)

        let expectation = expectation(description: "State changes to error")

        await viewModel.statePublisher
            .dropFirst()
            .sink { state in
                if case .error = state { expectation.fulfill() }
            }
            .store(in: &cancellables)

        await viewModel.loadProducts()
        await fulfillment(of: [expectation], timeout: 1.0)
    }

    // MARK: - EffectHandler tests
    @MainActor func testEffectHandler() {
        let mockRouter = MockRouter()
        let viewModel = HomeViewModel(useCase: MockUseCase())
        let effectHandler = EffectHandler(output: viewModel, router: mockRouter)
        effectHandler.bind()

        // comingSoon effect
        viewModel.sendEvent(.barButtonDidTap)
        XCTAssertTrue(mockRouter.didShowComingSoon)

        // topPick effect
        let dummyModel = "model"
        viewModel.sendEvent(.homeTopPicksDidTap(dummyModel))

        if case let .topPick(model) = mockRouter.detailData {
            XCTAssertEqual(model, dummyModel)
        } else {
            XCTFail("Expected topPick effect")
        }
    }

    // MARK: - StateHandler tests
    @MainActor func testStateHandler() {
        let mockScreen = MockHomeScreen()
        let viewModel = HomeViewModel(useCase: MockUseCase())
        let stateHandler = StateHandler(output: viewModel, homeScreen: mockScreen)
        stateHandler.bind()

        // loading state
        viewModel.state = .loading
        XCTAssertTrue(mockScreen.didStartLoading)

        // loaded state
        viewModel.state = .loaded
        XCTAssertTrue(mockScreen.didStopLoading)
        XCTAssertTrue(mockScreen.didStopRefreshing)
        XCTAssertTrue(mockScreen.didReloadTable)

        // error state
        viewModel.state = .error("Test error")
        XCTAssertTrue(mockScreen.didStopLoading)
        XCTAssertTrue(mockScreen.didStopRefreshing)
    }

    override func tearDown() {
        cancellables.removeAll()
    }
}

// MARK: - MockUseCase

final class MockUseCase: NetvorkServiceUseCaseProtocol {
    var response: HomeSectionsResponse?
    var shouldThrow = false

    func execute() async throws -> HomeSectionsResponse {
        if shouldThrow {
            throw NetworkError.statusCode
        }
        return response ?? HomeSectionsResponse(
            topPicksHeader: Header(title: "Top Picks", subtitleLabel: "1", buttonTitle: "2"),
            topPicks: [],
            promo: [],
            newFromNikeHeader: Header(title: "New From Nike", subtitleLabel: "1", buttonTitle: "2"),
            newFromNike: [],
            nikeTrainingHeader: Header(title: "Nike Training", subtitleLabel: "1", buttonTitle: "2"),
            nikeTraining: [],
            storiesForYou: [],
            nikeSwiftAndStrideHeader: Header(title: "Nike Swift & Stride", subtitleLabel: "1", buttonTitle: "2"),
            nikeSwiftAndStride: [],
            thankYou: []
        )
    }
}

// MARK: - MockHomeScreen

final class MockHomeScreen: HomeViewDisplayingProtocol {
    var didStartLoading = false
    var didStopLoading = false
    var didStopRefreshing = false
    var didReloadTable = false

    func reloadTable() { didReloadTable = true }
    func startLoadingIndicator() { didStartLoading = true }
    func stopLoadingIndicator() { didStopLoading = true }
    func attachRefreshControl() {}
    func stopRefreshing() { didStopRefreshing = true }
}

// MARK: - MockRouter

final class MockRouter: HomeCoordinatorProtocol {
    var detailData: DetailData?
    var didShowComingSoon = false

    func showDetail(data: DetailData) { detailData = data }
    func showComingSoon() { didShowComingSoon = true }
}
