//
//  ListUsersView.swift
//  TakeHome
//
//  Created by Duy Phuong on 19/09/2024.
//

import SwiftUI
import CoreData

struct GithubUsersView: View {
  @FetchRequest(
    sortDescriptors: [
      NSSortDescriptor(keyPath: \UserEntity.id, ascending: true)
    ],
    animation: .default
  )
  private var users: FetchedResults<UserEntity>
  @StateObject var viewModel: GithubUsersViewModel
  
  var body: some View {
    NavigationStack {
      UserListView(users: users) {
        if users.isNotEmpty && viewModel.hasMoreUsers {
          HStack(alignment: .center) {
            SpinnerView()
              .frame(maxWidth: 125, minHeight: 125)
            Text(UserInfoString.loadMoreUser.localized)
          }
          .task {
            await viewModel.fetchMoreUsers()
          }
        }
      }
      .task {
        await viewModel.fetchUsers()
      }
      .listStyle(.plain)
      .navigationTitle(UserInfoString.githubUsers.localized)
      .navigationBarTitleDisplayMode(.inline)
      .overlay {
        if viewModel.isLoading && users.isEmpty {
          ProgressView(UserInfoString.findingUsers.localized)
        }
      }
    }
    .navigationViewStyle(.stack)
  }
}

struct ListUsersView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      GithubUsersView(
        viewModel: GithubUsersViewModel(
          userFetcher: UsersFetcherMock(),
          userStore: UserStoreService(
            context: PersistenceController.preview.container.viewContext
          )
        )
      )
      
      GithubUsersView(
        viewModel: GithubUsersViewModel(
          userFetcher: UsersFetcherMock(),
          userStore: UserStoreService(
            context: PersistenceController.preview.container.viewContext
          )
        )
      )
      .preferredColorScheme(.dark)
    }
    .environment(
      \.managedObjectContext,
       PersistenceController.preview.container.viewContext
    )
  }
}
