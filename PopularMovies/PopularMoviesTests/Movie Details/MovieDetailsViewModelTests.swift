//
//  MovieDetailsViewModelTests.swift
//  PopularMoviesTests
//
//  Created by Shweta Chitlangia on 03/08/23.
//

import Foundation
@testable import PopularMovies
import XCTest

class MovieDetailsViewModelTests: XCTestCase {
    // ... Your existing test cases ...
    
    var mockMovieDetailsAPI: MockMovieDetailsAPI!
    var viewModel: MovieDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        mockMovieDetailsAPI = MockMovieDetailsAPI(movieId: 123)
        viewModel = MovieDetailsViewModel(movieDetailsAPI: mockMovieDetailsAPI)
    }
    
    override func tearDown() {
        mockMovieDetailsAPI = nil
        viewModel = nil
    }
    
    func testFetchMovieDetailsSuccess() {
        // Create a mock movie details API and set the mock response
        if let movieDetails = getMovieDetails(from: "MockMovieDetailsValidResponse") {
            mockMovieDetailsAPI.mockMovieDetailsResponse = .success(movieDetails)
            
            // Call the fetchMovieDetails method
            viewModel.fetchMovieDetails()
            
            // Wait for the fetch completion
            let expectation = XCTestExpectation(description: "Fetch Completion")
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 2.0)
            
            // Assert the fetched movie details
            XCTAssertEqual(viewModel.selectedMovie, movieDetails)
            XCTAssertFalse(viewModel.isLoading)
        } else {
            XCTFail("Failed to load test JSON data.")
        }
    }
    
    func testFetchMovieDetailsFailure() {
        // Set the mock movie details response for the API to a failure
        mockMovieDetailsAPI.mockMovieDetailsResponse = .failure(.apiError(NSError(domain: "TestError", code: 500, userInfo: nil)))
        
        // Call the fetchMovieDetails method
        viewModel.fetchMovieDetails()
        
        // Wait for the fetch completion
        let expectation = XCTestExpectation(description: "Fetch Completion")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
        // Assert that selectedMovie is nil and isLoading is false
        XCTAssertNil(viewModel.selectedMovie)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func getMovieDetails(from jsonFileName: String) -> Movie? {
        // Load data from the test JSON file
        guard let path = Bundle(for: type(of: self)).path(forResource: jsonFileName, ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            XCTFail("Failed to load test JSON data.")
            return nil
        }
        
        // Decode JSON data into the MovieDetails model
        let decoder = Utility.jsonDecoder
        return try? decoder.decode(Movie.self, from: jsonData)
    }
}
