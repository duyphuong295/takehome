//
//  UserInfoRow.swift
//  TakeHome
//
//  Created by Duy Phuong on 21/09/2024.
//

import SwiftUI

struct UserRowView: View {
  let user: UserEntity
  var userName: String
  var userUrl: String
  
  init(user: UserEntity) {
    self.user = user
    userName = user.login ?? ""
    userUrl = user.htmlURL?.absoluteString ?? ""
  }
  
  var body: some View {
    HStack {
      ZStack {
        AsyncImage(url: user.avatarURL) { image in
          image
            .resizable()
        } placeholder: {
          Image(systemName: "person.circle.fill")
            .resizable()
            .overlay {
              if user.avatarURL != nil {
                ProgressView()
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .background(.gray.opacity(0.4))
              }
            }
        }
        .clipShape(Circle())
        .aspectRatio(contentMode: .fit)
        .frame(width: 100, height: 100)
      }
      VStack(alignment: .leading) {
        Text(userName)
          .multilineTextAlignment(.center)
          .font(.headline)
          .padding(.top, 6)
        Divider()
        if let userLink = user.htmlURL {
          Text(userLink.absoluteString)
            .font(.subheadline)
            .underline()
            .foregroundStyle(.blue)
        }
        Spacer()
      }
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.white)
        .shadow(color: Color("drop-shadow"), radius: 5, x: 3, y: 3)
    )
  }
}

struct UserInfoRow_Previews: PreviewProvider {
  static var previews: some View {
    if let user = CoreDataHelper.getTestUserEntity() {
      UserRowView(user: user)
    }
  }
}
