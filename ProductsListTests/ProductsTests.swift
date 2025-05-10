//
//  ProductsTests.swift
//  ProductsListTests
//
//  Created by Yousuf Abdelfattah on 10/05/2025.
//

import XCTest
@testable import ProductsList

final class ProductsTests: XCTestCase {
    
    // MARK: - Properties
    var mockRepository: MockProductsRepository!
    var useCase: GetProductsUseCase!
    let sampleRequest = ProductsRequest(limit: 7)
    
    // MARK: - Setup & Teardown
    override func setUpWithError() throws {
        mockRepository = MockProductsRepository()
        useCase = GetProductsUseCase()
        useCase.productsRepository = mockRepository
    }
    
    override func tearDownWithError() throws {
        mockRepository = nil
        useCase = nil
    }
    
    // MARK: - Success Cases
    func testGetProductsUseCase_execute_shouldReturnProducts_whenAPISuccess() throws {
        // Given
        mockRepository.shouldReturnError = false
        mockRepository.isFromCache = false
        
        let expectation = self.expectation(description: "API Products fetched")
        
        // When
        useCase.execute(productsRequest: sampleRequest) { [weak self] result in
            guard let self = self else { return }
            // Then
            switch result {
                case .success(let (products, isFromCache)):
                    XCTAssertEqual(products.count, self.mockRepository.mockProducts.count)
                    XCTAssertFalse(isFromCache)
                    
                case .failure:
                    XCTFail("Expected success, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetProductsUseCase_execute_shouldReturnProductsFromCache_whenCacheFallback() throws {
        // Given
        mockRepository.shouldReturnError = false
        mockRepository.isFromCache = true
        
        let expectation = self.expectation(description: "Cached products fetched")
        
        // When
        useCase.execute(productsRequest: sampleRequest) { [weak self] result in
            guard let self = self else { return }
            // Then
            switch result {
                case .success(let (products, isFromCache)):
                    XCTAssertEqual(products.count, self.mockRepository.mockProducts.count)
                    XCTAssertTrue(isFromCache)
                    
                case .failure:
                    XCTFail("Expected success with cache fallback, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    // MARK: - Failure Cases
    func testGetProductsUseCase_execute_shouldReturnError_whenFailure() throws {
        // Given
        mockRepository.shouldReturnError = true
        
        let expectation = self.expectation(description: "Failure handled")
        
        // When
        useCase.execute(productsRequest: sampleRequest) { result in
            // Then
            switch result {
                case .success:
                    XCTFail("Expected failure, got success")
                    
                case .failure(let error):
                    XCTAssertNotNil(error)
                    XCTAssertEqual((error as NSError).localizedDescription, "Failed to load products. No cached data available.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    // MARK: - Edge Cases
    func testGetProductsUseCase_execute_shouldHandleEmptyProducts() throws {
        // Given
        mockRepository.shouldReturnError = false
        mockRepository.mockProducts = [] // Simulate empty products
        
        let expectation = self.expectation(description: "Empty products handled")
        
        // When
        useCase.execute(productsRequest: sampleRequest) { result in
            // Then
            switch result {
                case .success(let (products, _)):
                    XCTAssertTrue(products.isEmpty, "Expected empty products")
                    
                case .failure:
                    XCTFail("Expected success with empty products, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetProductsUseCase_execute_shouldHandleLargeNumberOfProducts() throws {
        // Given
        mockRepository.shouldReturnError = false
        mockRepository.mockProducts = Array(repeating: mockRepository.mockProducts.first!, count: 1000)
        
        let expectation = self.expectation(description: "Large number of products handled")
        
        // When
        useCase.execute(productsRequest: sampleRequest) { result in
            // Then
            switch result {
                case .success(let (products, _)):
                    XCTAssertEqual(products.count, 1000, "Expected 1000 products")
                    
                case .failure:
                    XCTFail("Expected success with large number of products, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetProductsUseCase_execute_shouldHandleInvalidData() throws {
        // Given
        mockRepository.shouldReturnError = false
        mockRepository.mockProducts = []
        
        let expectation = self.expectation(description: "Invalid data handled")
        
        // When
        useCase.execute(productsRequest: sampleRequest) { result in
            // Then
            switch result {
                case .success(let (products, _)):
                    XCTAssertTrue(products.isEmpty, "Expected empty products for invalid data")
                    
                case .failure:
                    XCTFail("Expected success with invalid data, got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
}
