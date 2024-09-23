//
//  UserDetailsView.swift
//  TakeHome
//
//  Created by Duy Phuong on 21/09/2024.
//

import SwiftUI

struct UserDetailsView: View {
  @StateObject var viewModel: UserDetailsViewModel
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    ScrollView {
      LazyVStack(alignment: .leading) {
        UserDetailInfoView(user: viewModel.userEntity)
        HStack {
          Spacer()
          FollowView(
            icon: "person.2.circle",
            count: Int(viewModel.userEntity.followers),
            text: UserInfoString.follower.localized)
          Spacer()
          FollowView(
            icon: "medal.fill",
            count: Int(viewModel.userEntity.following),
            text: UserInfoString.following.localized)
          Spacer()
        }
        .padding()
        Text(UserInfoString.blog.localized)
          .font(.headline)
          .padding(.bottom, 1)
        if let blogLink = viewModel.userEntity.htmlURL {
          Link(blogLink.absoluteString, destination: blogLink)
            .font(.subheadline)
            .underline()
            .foregroundStyle(.blue)
        }
      }
      .padding()
    }
    .task {
      await viewModel.fetchUserDetails()
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          dismiss()
        } label: {
          HStack {
            Image(systemName: "arrow.backward")
              .foregroundColor(.black)
          }
        }
      }
    }
    .navigationTitle(UserInfoString.userDetails.localized)
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct UserDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    if let user = CoreDataHelper.getTestUserEntity() {
      NavigationStack {
        UserDetailsView(
          viewModel: UserDetailsViewModel(
            userEntity: user,
            userFetcher: UsersFetcherMock(),
            userStore: UserStoreService(
              context: PersistenceController.preview.container.viewContext)
          )
        )
      }
    }
  }
}
