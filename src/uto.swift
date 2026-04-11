import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLError(.unknown))
                }
            }
            task.resume()
        }
    }
}


public class Uto {
    private let api = "https://u.to/api"
    private var headers: [String: String]
    
    public init() {
        self.headers = [
        "Accept":"application/json, text/plain, */*",
        "Host":"u.to",
        "Connection":"keep-alive",
        "Accept-Encoding":"deflate, zstd",
        "Accept-Language":"en-US,en;q=0.9",
        "User-Agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36",
        "Referer":"https://u.to/",
        "Origin":"https://u.to",
        "sec-ch-ua-mobile":"?0",
        "sec-ch-ua-platform":"Linux"
        ]

    }

    public func get_short_link(link: String) async throws -> Any {
        guard let url = URL(string: "\(api)/shorten/") else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = ["url": link]
 
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
    
        let (data, _) = try await URLSession.shared.data(for: request)
        let json = try JSONSerialization.jsonObject(with: data)
    
        return json
    }
}
