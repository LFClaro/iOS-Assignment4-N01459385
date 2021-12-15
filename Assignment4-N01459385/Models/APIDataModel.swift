//
//  APIDataModel.swift
//  Assignment4-N01459385
//
//  Created by Luiz Fernando Reis on 2021-12-08.
//

import Foundation

struct result : Codable {
    public var games : [Info]
}

struct Info : Codable {
    var id : String
    var name : String
    var rank : Int?
    var price : String
    var price_ca : String
    var year_published : Int?
    var min_players : Int?
    var max_players : Int?
    var min_playtime : Int?
    var max_playtime : Int?
    var min_age : Int?
    var description : String
    var rules_url : String?
    var images : ImageDetails
    var description_preview : String
}

struct ImageDetails : Codable {
    var thumb : String?
    var small : String?
    var medium : String?
    var large : String?
    var original : String?
}

struct videoResult : Codable {
    public var videos : [Video]
}

struct Video : Codable {
    var title : String
    var channel_name : String
    var url : String
    var thumb_url : String?
    var image_url : String?
}
