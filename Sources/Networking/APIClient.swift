import Foundation

typealias URLResponse = Result<(data: Data, response: HTTPURLResponse), Error>

protocol APIClientProtocol {
    func dataTask(_ request: URLRequest) async -> URLResponse
}

final class APIClientURLSession: APIClientProtocol {
    func dataTask(_ request: URLRequest) async -> URLResponse {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw MyError.unknown
            }
            return .success((data: data, response: response))
        } catch(let error) {
            return .failure(error)
        }
    }
}

final class MockAPIClient: APIClientProtocol {
    
    func dataTask(_ request: URLRequest) async -> URLResponse {
        return URLResponse.failure(MyError.unknown)
    }
    
    // FIX ME
    func dataTask(_ request: URLRequest,
                  completionHandler: @escaping (URLResponse) -> Void) {
        
        guard let url = request.url,
              let httpMethod = request.httpMethod
        else {
            completionHandler(.failure(MyError.unknown))
            return
        }
        
        let relativePath = url.relativePath.dropFirst()
        let fileName = "\(httpMethod)_\(relativePath)".lowercased()
        
        guard let pathString = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json"),
              let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8),
              let jsonData = jsonString.data(using: .utf8),
              let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        else {
            fatalError("\(fileName).json not found")
        }
        
        /// Manual delay to mimic an API
        sleep(2)
        
        /// Randomly failing the Mock API
        let responseShouldSucceed = Bool.random()
        
        if responseShouldSucceed {
            completionHandler(.success((jsonData, response)))
        } else {
            completionHandler(.failure(MyError.unknown))
        }
    }
}
