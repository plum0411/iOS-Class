//
//  SwiftUIView.swift
//  iOS
//
//  Created by 訪客使用者 on 2026/3/16.
//
import SwiftUI

struct BreakfastView: View {
    @State private var inputName: String = ""
    @State private var resultMessage: String = ""
    @State private var isLuxury: Int = 40

    // 菜單：品項名稱 -> 價格
    private let menu: [String: Int] = [
        "漢堡": 50,
        "蛋餅": 35,
        "奶茶": 25,
        "薯條": 40
    ]
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    Text("早餐店目前有這些品項：")
                        .font(.headline)
                    Text("漢堡：50 元\n蛋餅：35 元\n奶茶：25 元\n薯條：40 元")
                }

                Text("今天想吃什麼？")
                    .font(.headline)
                TextField("請輸入餐點名稱，例如：漢堡", text: $inputName)
                    .textFieldStyle(.plain)
                    .overlay(alignment: .bottom) {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 2)
                    }
                    .onSubmit { queryItem() }
                    .padding(8)

                Button("查詢") {
                    queryItem()
                }
                .foregroundStyle(.white)
                .frame(minWidth: 120, maxWidth: .infinity, minHeight: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.black)
                )

                if !resultMessage.isEmpty {
                    Text(resultMessage)
                        .font(.body)
                        .padding(.top, 8)
                }
                Spacer()
            }
            .padding(40)
            .navigationTitle("早餐點餐")
        }
    }

    private func queryItem() {
        // 以精確名稱比對（可先做去空白處理）
        let name = inputName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else {
            resultMessage = "請先輸入餐點名稱"
            return
        }

        if let price = menu[name] {
            // 有這個餐點
            var lines: [String] = []
            lines.append("你點的是 \(name)，價格是 \(price) 元")
            if price >= isLuxury {
                lines.append("這份餐點算豪華早餐！")
            } else {
                lines.append("這份餐點是平價早餐！")
            }
            resultMessage = lines.joined(separator: "\n")
        } else {
            // 沒有這個餐點
            resultMessage = "抱歉，菜單裡沒有這個餐點"
        }
}
}
    
#Preview {
    BreakfastView()
}

