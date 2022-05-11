//
//  CommentsList.swift
//  Reddit_Comments
//
//  Created by Bohdan on 29.04.2022.
//

import SwiftUI

struct CommentsTable: View {
    let spaceName = "scroll"
    @EnvironmentObject var modelData: ModelData
    
    @State var wholeSize: CGSize = .zero
    @State var scrollViewSize: CGSize = .zero
    
    var body: some View {
        NavigationView {
            self.commentCollectionView
                .navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var commentCollectionView: some View {
        ScrollView {
            LazyVStack {
                ForEach(modelData.commentsParsed) { comment in
                    NavigationLink(
                        destination: CommentDetails(comment: comment),
                        label: { CommentCell(comment: comment) }
                    )
                }
                Color.clear
                    .frame(width: 0, height: 0, alignment: .bottom)
                    .onAppear {
                        modelData.getMoreComments()
                    }
            }
        }
    }
}

struct CommentsTable_Previews: PreviewProvider {
    static var previews: some View {
        CommentsTable()
            .environmentObject(ModelData(subreddit: "Music", id: "u5jfbi"))
    }
}



