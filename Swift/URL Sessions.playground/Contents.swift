import UIKit
import Foundation


struct Post : Decodable, Encodable{
    let id : Int
    let title: String
    let body: String
    
}

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")



func addPost(){
    
    let params = [
        "title": "This is title",
        "body": "This is body"
    ]
    
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("Application/json", forHTTPHeaderField: "Content-type")
    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    
    let _ = URLSession.shared.dataTask(with: request){ data, response, error in
        
        if let error =  error {
            print(error.localizedDescription)
        }else{
            let res =  try? JSONSerialization.jsonObject(with: data!, options: [])
            print(res!)
        }
        
    }.resume()
}

func getPosts() {
      guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let _ = URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let error = error {print("Error - \(error)")}
            else{
                guard let data = data else {return}
                do{
                    let jsonResponse = try JSONSerialization.jsonObject(with: data)
                    print(jsonResponse)
                }catch{
                    print("Error Thrown")
                }
            }
            
        }.resume()
  }

func createPost() {
    let newPost = Post(id: 101, title: "This is Title", body: "This is body")
    
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try? JSONEncoder().encode(newPost)
    
    let _ = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("The error was: \(error.localizedDescription)")
        } else {
            let post = try? JSONDecoder().decode(Post.self, from: data!)
            print("The ID is: \(String(describing: post?.id))")
            print("The title is: \(String(describing: post?.title))")
            print("The body is: \(String(describing: post?.body))")
        }
    }.resume()
}

//addPost()
//getPosts()
createPost()

//struct Resource<T> {
//    let url: URL
//    // Other properties and methods
//}
//
//class NetworkManager {
//    func load<T>(resource: Resource<T>, withCompletion completion: @escaping (T?) -> Void) {
//        let task = URLSession.shared.dataTask(with: resource.url) { [weak self] (data, _ , _) -> Void in
//            guard let data = data else {
//                DispatchQueue.main.async { completion(nil) }
//                return
//            }
//            // Use the Resource struct to parse data
//        }
//        task.resume()
//    }
//}
