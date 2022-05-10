//
//  CommentDetails.swift
//  Reddit_Comments
//
//  Created by Bohdan on 29.04.2022.
//

import SwiftUI

struct CommentDetails: View {
    let comment: UIComment
    
    var body: some View {
        if let username = comment.username, let time = comment.created,
           let body = comment.body, let rating = comment.rating {
            VStack {
                VStack(alignment: .leading, spacing: 16){
                    Group {
                        HStack {
                            Text("/r")
                            Text("/" + username)
                            Spacer()
                            Text("\(time)")
                        }
                        .font(.subheadline)
                        
                        Text(body)
                            .multilineTextAlignment(.leading)
                        HStack(){
                            Text("Rating:")
                            Text("\(rating)")
                            Spacer()
                        }
                    }
                }
                .padding(8)
                .overlay(
                       RoundedRectangle(cornerRadius: 16)
                           .stroke(Color.blue, lineWidth: 1)
                   )
                
                Button(action: share, label:{
                    ZStack{
                        Circle()
                            .frame(height: 60)
                            .foregroundColor(Color.accentColor)
                        Text("Share")
                            .foregroundColor(Color.white)
                            .font(.headline)
                            .bold()
                    }
                })
            }
        } else {
            Text("Missing info")
        }
    }
    
    func share(){
        guard let link = comment.permalink else {return}
        let activityController = UIActivityViewController(activityItems: [("https://www.reddit.com" + link)], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

struct CommentDetails_Previews: PreviewProvider {
    static var previews: some View {
        CommentDetails(comment: UIComment.testCase)
    }
}
