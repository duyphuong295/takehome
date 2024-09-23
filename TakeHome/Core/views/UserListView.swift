//
//  UserListView.swift
//  TakeHome
//
//  Created by Duy Phuong on 22/09/2024.
//

import SwiftUI

struct UserListView<Content, Data>: View
where Content: View,
      Data: RandomAccessCollection,
      Data.Element: UserEntity {
  let users: Data
  let footer: Content
  @Environment(\.managedObjectContext) private var viewContext
  
  init(users: Data, @ViewBuilder footer: () -> Content) {
    self.users = users
    self.footer = footer()
  }
  
  init(users: Data) where Content == EmptyView {
    self.init(users: users) {
      EmptyView()
    }
  }
  
  var body: some View {
    List {
      ForEach(users) { user in
        let model = UserDetailsViewModel(
          userEntity: user,
          userFetcher: FetchUsersService(
            requestManager: RequestManager()
          ),
          userStore: UserStoreService(
            context: viewContext)
        )
        NavigationLink(destination: UserDetailsView(viewModel: model)) {
          UserRowView(user: user)
        }
      }
      
      footer
    }
    .listRowSeparator(.hidden)
    .listStyle(.plain)
  }
}

struct UserListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      UserListView(users: CoreDataHelper.getTestUserEntities() ?? [])
    }
    
    NavigationStack {
      UserListView(users: []) {
        Text("This is a footer")
      }
    }
  }
}
