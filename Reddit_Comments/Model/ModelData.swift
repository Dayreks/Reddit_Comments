//
//  ModelData.swift
//  Reddit_Comments
//
//  Created by Bohdan on 29.04.2022.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    
    @Published var commentsParsed: [UIComment] = []
    let emptyData = ParsedData()
    
    init() {
        emptyData.load("https://www.reddit.com/r/Music/comments/u5jfbi.json?limit=25"){ [weak self] commentsData in
            DispatchQueue.main.async {
                self?.commentsParsed = commentsData.comments
            }
        }
    }
    
    func getMoreComments(){
        emptyData.loadChilds(){ [weak self] commentsChildsData in
            DispatchQueue.main.async {
                self?.commentsParsed = commentsChildsData.comments
            }
        }
    }
}

class ParsedData{
    var comments: [UIComment] = []
    var childrenIDs: [String]? = nil
    
    func load(_ link: String, onCompleted: @escaping (ParsedData) -> Void) {
        let urlSession = URLSession(configuration: .default)
        let url = URL(string: link)!
        let _ = urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, let dataList = try? JSONDecoder().decode([CommentsList].self, from: data) else {return }
            self.addComment(dataList[1].data.children)
            onCompleted(self)
        }.resume()
    }
    
    func loadChilds(onCompleted: @escaping (ParsedData) -> Void){
        if (childrenIDs == nil) { return }
        let combinedIDs = childrenIDs?.reduce("", {x,y in x + "," + y})
        guard var additionalIDs = combinedIDs else {return}
        additionalIDs.remove(at: additionalIDs.startIndex)
        
        guard let parent_id = comments.last?.parent_id else {return}
        
        let urlSession = URLSession(configuration: .default)
        let _ = urlSession.dataTask(with: URL(string: "https://www.reddit.com/api/morechildren.json?depth=0&link_id=\(parent_id)&api_type=json&children=\(additionalIDs)")!) { data, response, error in
            guard let data = data, let json = try? JSONDecoder().decode(Json.self, from: data) else { return }
            self.addComment(json.json.data.things)
            onCompleted(self)
        }.resume()
    }
    
    func addComment(_ arrayOfComments: [GeneralChilds]){
        for child in arrayOfComments{
            if(child.comment.children == nil) {
                var tempComment = UIComment()
                tempComment.body = child.comment.body
                guard let time = child.comment.created else {return}
                tempComment.created = ParsedData.convertToNice(time - Date().timeIntervalSince1970)
                tempComment.depth = child.comment.depth
                tempComment.permalink = child.comment.permalink
                tempComment.username = child.comment.username
                tempComment.rating = child.comment.rating
                tempComment.children = child.comment.children
                tempComment.parent_id = child.comment.parent_id
                self.comments.append(tempComment)
                childrenIDs = nil
            } else {
                childrenIDs = child.comment.children
            }
        }
    }
    
    static func convertToNice(_ time: TimeInterval) -> String {
            let formatter = DateComponentsFormatter()
                formatter.allowedUnits = [.day, .hour, .minute, .second]
                formatter.unitsStyle = .abbreviated
                formatter.maximumUnitCount = 1

                return formatter.string(from: time) ?? String(time)
        }
}
