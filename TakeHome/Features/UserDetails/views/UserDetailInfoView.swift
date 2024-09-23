//
//  UserDetailInfoView.swift
//  TakeHome
//
//  Created by Duy Phuong on 23/09/2024.
//

import SwiftUI

struct UserDetailInfoView: View {
  let user: UserEntity
  var userName: String
  var location: String
  
  init(user: UserEntity) {
    self.user = user
    userName = user.login ?? ""
    location = user.location ?? ""
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
        HStack {
          Image(systemName: "scope")
            .frame(width: 24, height: 24)
            .foregroundColor(.black)
          Text(location)
            .font(.subheadline)
            .underline()
            .foregroundStyle(.blue)
        }
        .padding(.top, 1)
        Spacer()
      }
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.white)
        .shadow(color: Color.dropShadow, radius: 5, x: 3, y: 3)
    )
  }
}

struct UserDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
      if let user = CoreDataHelper.getTestUserEntity() {
        UserDetailInfoView(user: user)
      }
    }
}
