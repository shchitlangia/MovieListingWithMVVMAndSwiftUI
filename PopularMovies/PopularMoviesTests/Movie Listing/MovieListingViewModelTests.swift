//
//  MovieListingViewModelTests.swift
//  PopularMoviesTests
//
//  Created by Shweta Chitlangia on 03/08/23.
//

@testable import PopularMovies
import XCTest

// Naming convention: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Testing structure: Given, When, Then

class MovieListingViewModelTests: XCTestCase {
    var viewModel: MovieListingViewModel!
    var mockAPI: MockMovieListingAPI!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAPI = MockMovieListingAPI()
        viewModel = MovieListingViewModel(movieListingAPI: mockAPI)
    }

    override func tearDownWithError() throws {
        mockAPI = nil
        viewModel = nil
        try super.tearDownWithError()
    }

    func testFetchPopularMoviesSuccess() throws {
        // Given
        let expectedMovies = getMovieList(from: "MockMovieListingValidResponse")
        if let expectedMovies {
            mockAPI.mockMovieListingResponse = .success(expectedMovies)
            
            // When
            viewModel.fetchPopularMovies()
            
            // Then
            XCTAssertTrue(viewModel.isLoading, "isLoading should be true while fetching")
            XCTAssertNil(viewModel.movies, "movies should be nil before the fetch completes")
            
            // Wait for the fetch completion
            let expectation = XCTestExpectation(description: "Fetch Completion")
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 2.0)
            
            XCTAssertFalse(viewModel.isLoading, "isLoading should be false after the fetch completes")
            XCTAssertEqual(viewModel.movies, expectedMovies, "Fetched movies should match expectedMovies")
            XCTAssertEqual(viewModel.movies?.count, 5, "Fetched movies should be 5")
        } else {
            XCTFail("Failed to load test JSON data.")
        }
    }

    func testFetchPopularMoviesFailure() throws {
        // Given
        let expectedError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        mockAPI.mockMovieListingResponse = .failure(APIError.apiError(expectedError))

        // When
        viewModel.fetchPopularMovies()

        // Then
        XCTAssertTrue(viewModel.isLoading, "isLoading should be true while fetching")
        XCTAssertNil(viewModel.movies, "movies should be nil before the fetch completes")

        // Wait for the fetch completion
        let expectation = XCTestExpectation(description: "Fetch Completion")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)

        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after the fetch completes")
        XCTAssertNil(viewModel.movies, "movies should be nil after fetch failure")
    }
    
    func getMovieList(from jsonFileName: String) -> [Movie]? {
        // Load data from the test JSON file
        guard let path = Bundle(for: type(of: self)).path(forResource: jsonFileName, ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            XCTFail("Failed to load test JSON data.")
            return nil
        }
        
        // Decode JSON data into the MovieDetails model
        let movieResponse = try? Utility.jsonDecoder.decode(MovieResponse.self, from: jsonData)
        return movieResponse?.results
    }
}
