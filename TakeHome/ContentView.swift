//
//  ContentView.swift
//  TakeHome
//
//  Created by Duy Phuong on 19/09/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  var body: some View {
    VStack {
      GithubUsersView(
        viewModel:
          GithubUsersViewModel(
            isLoading: false,
            userFetcher: FetchUsersService(
              requestManager: RequestManager()
            ),
            userStore: UserStoreService(context: viewContext))
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
