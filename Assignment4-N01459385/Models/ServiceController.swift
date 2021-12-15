//
//  ServiceController.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-08.
//

import UIKit

class ServiceController {
    let api_key = "&client_id=9E63bBvqoR"
    
    let url_search = "https://api.boardgameatlas.com/api/search?limit=100"
    let search_by_name = "&fuzzy_match=true&name="
    let search_top100 = "&order_by=rank"
    
    let url_by_id = "https://api.boardgameatlas.com/api/search?ids="
    
    let url_video = "https://api.boardgameatlas.com/api/game/videos?pretty=true&game_id="
    
    static var shared = ServiceController()
    
    func getAllBoardgames(handler: @escaping ([Info])->Void){
        let urlString = url_search + search_top100 + api_key
        let urlObj = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: urlObj) { data, apiresponse, error in
            if let error = error {
                print(error)
            }
            else if let correctData = data {
                do{
                    let decoder = JSONDecoder()
                    let resultFromDecoder = try decoder.decode(result.self,from:correctData)
                    handler(resultFromDecoder.games)
                }catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getBoardgamesByName(name:String, handler: @escaping ([Info])->Void){
        var urlString = url_search + search_by_name + name + api_key
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlObj = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: urlObj) { data, apiresponse, error in
            if let error = error {
                print(error)
                handler([Info]())
            }
            else if let correctData = data {
                do{
                    let decoder = JSONDecoder()
                    let resultFromDecoder = try decoder.decode(result.self,from:correctData)
                    handler(resultFromDecoder.games)
                }catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getBoardgamesById(id:String, handler: @escaping ([Info])->Void){
        var urlString = url_by_id + id + api_key
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlObj = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: urlObj) { data, apiresponse, error in
            if let error = error {
                print(error)
                handler([Info]())
            }
            else if let correctData = data {
                do{
                    let decoder = JSONDecoder()
                    let resultFromDecoder = try decoder.decode(result.self,from:correctData)
                    handler(resultFromDecoder.games)
                }catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getVideos(id:String, handler: @escaping ([Video])->Void){
        let urlString = url_video + id + api_key
        let urlObj = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: urlObj) { data, apiresponse, error in
            if let error = error {
                print(error)
            }
            else if let correctData = data {
                do{
                    let decoder = JSONDecoder()
                    let resultFromDecoder = try decoder.decode(videoResult.self,from:correctData)
                    handler(resultFromDecoder.videos)
                }catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getImage(url : String, handler: @escaping (Result<UIImage,Error>)->Void ){
        let urlObj = URL(string: url)!
        
        URLSession.shared.dataTask(with: urlObj) {
            data, apiresponse, error in
            if let error = error {
                print(error)
                handler(.failure(error))
            }
            else if let correct_data = data {
                let img = UIImage(data: correct_data)
                handler(.success(img!))
            }
        }.resume()
    }
}
