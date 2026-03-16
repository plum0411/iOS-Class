//
//  SwiftUIView.swift
//  iOS
//
//  Created by 訪客使用者 on 2026/3/16.
//
import SwiftUI

struct LoginContentView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        ZStack {
            // Background image covering safe areas
            if verticalSizeClass == .compact{
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
            }
            else{
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
            }

            // Main content
            VStack(spacing: 16) {
                // Title
                Text("Instant Developer")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.indigo)

                // Subtitle
                Text("Get help from experts in 15 minutes")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                // Images row
                HStack(spacing: 16) {
                    Image("student")
                        .resizable()
                        .scaledToFit()
                    Image("tutor")
                        .resizable()
                        .scaledToFit()
                }
                .frame(height: 140)

                // Hint text
                Text("Need help with coding problem? Register!")
                    .foregroundStyle(.white)

                Spacer(minLength: 20)

                // Buttons group
                HSignUpButtonGroup0316(
                    onSignUp: { print("Sign Up button tapped") },
                    onLogIn: { print("Log In button tapped") }
                )
            }
            .padding()
        }
    }
}
//struct LoginContentViewLeft: View {
//    var body: some View {
//        ZStack {
//            // Background image covering safe areas
//            Image("background")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//
//            // Main content
//            VStack(spacing: 16) {
//                // Title
//                Text("Instant Developer")
//                    .font(.system(size: 36, weight: .bold, design: .rounded))
//                    .foregroundStyle(.indigo)
//
//                // Subtitle
//                Text("Get help from experts in 15 minutes")
//                    .font(.title3)
//                    .foregroundStyle(.white)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal, 30)
//
//                // Images row
//                HStack(spacing: 16) {
//                    Image("student")
//                        .resizable()
//                        .scaledToFit()
//                    Image("tutor")
//                        .resizable()
//                        .scaledToFit()
//                }
//                .frame(height: 140)
//
//                // Hint text
//                Text("Need help with coding problem? Register!")
//                    .foregroundStyle(.white)
//
//                Spacer(minLength: 20)
//
//                // Buttons group
//                HSignUpButtonGroup0316(
//                    onSignUp: { print("Sign Up button tapped") },
//                    onLogIn: { print("Log In button tapped") }
//                )
//            }
//            .padding()
//        }
//    }
//}

// MARK: - Reusable Components

struct HSignUpButtonGroup0316: View {
    var onSignUp: () -> Void
    var onLogIn: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            PrimaryButton0316(title: "Sign Up", backgroundColor: .indigo, action: onSignUp)
            PrimaryButton0316(title: "Log In", backgroundColor: .gray, action: onLogIn)
        }
    }
}

struct PrimaryButton0316: View {
    let title: String
    let backgroundColor: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundStyle(.white)
                .frame(width: 140, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(backgroundColor)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LoginContentView()
}

#Preview("MainView(Landscape)",traits:.landscapeLeft) {
//    LoginContentViewLeft()
    LoginContentView()
}

