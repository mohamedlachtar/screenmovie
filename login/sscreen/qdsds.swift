//
//  qdsds.swift
//  login
//
//  Created by Floki on 11/4/2023.
//

import SwiftUI


        struct qdsds: Identifiable {
            let id = UUID()
            let title: String
            let image: String
        }

        struct PostListView: View {
            let qdsds = [
                qdsds(title: "First Post", image: "post1"),
                qdsds(title: "Second Post", image: "post2"),
                qdsds(title: "Third Post", image: "post3")
            ]

            var body: some View {
                List(qdsds) { qdsds in
                    VStack(alignment: .leading) {
                        Image(qdsds.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipped()
                        Text(qdsds.title)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    


struct qdsds_Previews: PreviewProvider {
    static var previews: some View {
        qdsds()
    }
}
