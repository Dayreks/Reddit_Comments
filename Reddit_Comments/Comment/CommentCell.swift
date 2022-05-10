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
        VStack(alignment: .leading, spacing: 8){
            HStack {
                Text("/ios")
                    .bold()
                    .italic()
                Text(comment.username!)
                    .bold()
                    .italic()
                Spacer()
                Text("\(comment.created!)")
                    .bold()
            }
            Text(comment.body!)
                .lineLimit(2)
            HStack {
                Group {
                    Text("Rating: ")
                        .bold()
                        .font(.title3)
                    Text("\(comment.rating!)")
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

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(comment: UIComment.testCase)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
