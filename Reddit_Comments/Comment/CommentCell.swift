//
//  CommentCell.swift
//  Reddit_Comments
//
//  Created by Bohdan on 29.04.2022.
//

import SwiftUI

struct CommentCell: View {
    let comment: UIComment
    
    var body: some View {
        if let username = comment.username, let created = comment.created, let body = comment.body,
           let rating = comment.rating {
            VStack(alignment: .leading, spacing: 8){
                HStack {
                    Text("/ios")
                        .bold()
                        .italic()
                    Text(username)
                        .bold()
                        .italic()
                    Spacer()
                    Text("\(created)")
                        .bold()
                }
                Text(body)
                    .lineLimit(2)
                HStack {
                    Group {
                        Text("Rating: ")
                            .bold()
                            .font(.title3)
                        Text("\(rating)")
                            .bold()
                            .font(.title3)
                    }
                    Spacer()
                }
            }
            .frame(height: 100)
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
        }
    }
    
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(comment: UIComment.testCase)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
