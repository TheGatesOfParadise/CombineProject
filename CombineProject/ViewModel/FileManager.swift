import Combine
import Foundation
///If extension, then the usage is
////Bundle.main.readFile(file: fileName)
/*
extension Bundle{
  // Part 1
    func readFile(file: String) -> AnyPublisher<Data, Error> {
        self.url(forResource: file, withExtension: nil)
            .publisher
            .tryMap{ string in
                guard let data = try? Data(contentsOf: string) else {
                    fatalError("Failed to load \(file) from bundle.")
                }
                return data
            }
            .mapError { error in
                return error
            }.eraseToAnyPublisher()
    }
      // Part 2
    func decodeable<T: Decodable>(fileName: String) -> AnyPublisher<T, Error> {
        readFile(file: fileName)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
        
    }
}
*/



class FileManager {
    
    static let shared = FileManager()
    
    private init() {
        
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func getData<T: Decodable>(fileName: String, type: T.Type) -> Future<[T], Error> {
        return Future<[T], Error> { [weak self] promise in
          /*  guard let self = self, let fileName = fileName else {
                return promise(.failure(NetworkError.invalidURL))
            }  */
            print("fileName is \(fileName)")
            ///if use Bundle's extension, uncomment beginging code
            //Bundle.main.readFile(file: fileName)
            Bundle.main.url(forResource: fileName, withExtension: nil)
                .publisher
                .tryMap{ string in
                    guard let data = try? Data(contentsOf: string) else {
                        fatalError("Failed to load \(fileName) from bundle.")
                    }
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self!.cancellables)
        }
        
        
    }
    
    
}


