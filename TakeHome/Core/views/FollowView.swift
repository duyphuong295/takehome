//
//  FollowView.swift
//  TakeHome
//
//  Created by Duy Phuong on 22/09/2024.
//

import SwiftUI

struct FollowView: View {
  let icon: String
  let count: Int
  let text: String
  var number: String {
    switch count {
    case 0...100:
      return "\(count)"
    case 101...1_000:
      return "100+"
    case 1_001...10_000:
      return "1000+"
    case 10_001...100_000:
      return "10.000+"
    case 100_001...1_000_000:
      return "100.000+"
    default:
      return "unknown"
    }
  }
  
  var body: some View {
    VStack {
      Image(systemName: icon)
        .resizable()
        .frame(width: 30, height: 30)
      Text(number)
        .font(.headline)
        .fontWeight(.semibold)
      Text(text)
        .font(.subheadline)
    }
  }
}

struct FollowView_Previews: PreviewProvider {
  static var previews: some View {
    FollowView(icon: "person.2.circle", count: 200, text: UserInfoString.follower.localized)
  }
}
