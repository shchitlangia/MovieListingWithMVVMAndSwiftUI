//
//  PopularMoviesUITests.swift
//  PopularMoviesUITests
//
//  Created by Shweta Chitlangia on 02/08/23.
//

import XCTest

final class PopularMoviesUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
    }
    
    func testNavigationTitleIsCorrect() {
        // Ensure that the "Popular Movies" navigation title is visible
        XCTAssertTrue(app.navigationBars["Popular Movies"].exists)
    }
    
    func testTapMovieAndViewDetails() throws {
        let collectionView = app.collectionViews["movieList"]
        
        // Tap on the first movie
        let firstMovieImage = collectionView.cells.element(boundBy: 0).buttons["movieImage"]
        firstMovieImage.tap()
        
        // Verify that the movie details view is displayed
        let movieDetailsView = app.scrollViews["moviedetailsView"]
        XCTAssertTrue(movieDetailsView.exists)
        
        // Verify if the rating and genre exist in the movie details
        let ratingExists = movieDetailsView.staticTexts["rating"].exists
        XCTAssertTrue(ratingExists)
        
        let genreExists = movieDetailsView.staticTexts["genre"].exists
        XCTAssertTrue(genreExists)
        
        // Navigate back to the movie list
        app.navigationBars["Barbie"].buttons["Popular Movies"].tap()
        
        // Verify that we're back on the movie list
        XCTAssertTrue(collectionView.exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
