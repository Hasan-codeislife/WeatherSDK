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
    
    func getFileName(from urlRequest: URLRequest) -> String? {
        
        guard let url = urlRequest.url,
              let httpMethod = urlRequest.httpMethod else {
            return nil
        }
        
        let component = url.lastPathComponent.split(separator: "?")
        guard let firstWord = component.first?.description else {
            return nil
        }
        let fileName = "\(httpMethod)_\(firstWord)".lowercased()
        return fileName
    }
    
    func dataTask(_ request: URLRequest) async -> URLResponse {
        
        guard let url = request.url,
              let fileName = getFileName(from: request)
        else {
            return URLResponse.failure(MyError.apiResponseError)
        }
        guard let pathString = Bundle.module.url(forResource: fileName, withExtension: "json").self
        else {
            return URLResponse.failure(MyError.unknown)
        }
        
        // Mimic API delay
        sleep(2)
        
        do {
            let jsonData = try Data(contentsOf: pathString)
            if let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) {
                return .success((data: jsonData, response: response))
            }
        } catch {
            return URLResponse.failure(MyError.apiResponseError)
        }
        return URLResponse.failure(MyError.unknown)
    }
}
