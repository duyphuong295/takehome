//
//  SpinnerView.swift
//  TakeHome
//
//  Created by Duy Phuong on 22/09/2024.
//

import SwiftUI

struct SpinnerView: View {
  var body: some View {
    ProgressView()
      .progressViewStyle(.circular)
      .scaleEffect(2.0, anchor: .center) // Makes the spinner larger
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          // Simulates a delay in content loading
          // Perform transition to the next view here
        }
      }
  }
}

struct SpinnerView_Previews: PreviewProvider {
  static var previews: some View {
    SpinnerView()
  }
}
