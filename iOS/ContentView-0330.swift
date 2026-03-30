//
//  SwiftUIView.swift
//  iOS
//
//  Created by 訪客使用者 on 2026/3/30.
//

import SwiftUI
// 園遊會點餐小幫手主畫面

// 使用 SwiftUI 建立點餐表單與計算結果
struct OrderView: View {
    // 菜單項目的資料模型（可識別＋可雜湊，方便在清單/Picker 中使用）
    struct MenuItem: Identifiable, Hashable {
        let id = UUID() // 唯一識別碼，供 SwiftUI 識別
        let name: String // 顯示在菜單上的名稱
        let price: Int // 價格（元）
        let description: String // 簡短說明
        let displayName: String // 用於結果文案的展示名稱
    }

    // 今日菜單（靜態資料，實務上可改為從伺服器或本地檔案載入）
    private let menu: [MenuItem] = [
        MenuItem(name: "雞排", price: 80, description: "現炸雞排，最多人買", displayName: "黃金雞排"), // $80
        MenuItem(name: "炒麵", price: 65, description: "一盒份量剛好，便宜又飽", displayName: "古早味炒麵"), // $65
        MenuItem(name: "甜不辣", price: 50, description: "小點心類，很多人會加買", displayName: "香酥甜不辣") // $50
    ]

    // 加購飲料設定
    private let drinkName = "冰紅茶"
    private let drinkPrice = 30 // 飲料單價（元）

    // 使用者輸入狀態（雙向綁定到 UI 控件）
    @State private var customerName: String = "" // 姓名輸入
    @State private var budgetText: String = "" // 預算（文字輸入，稍後轉 Int）
    @State private var selectedItemIndex: Int = 0 // Picker 目前選中的索引
    @State private var quantity: Int = 1 // 份數（Stepper 控制）
    @State private var addDrink: Bool = false // 是否加購飲料（Toggle 控制）

    // 計算後的結果訊息（顯示於畫面）
    @State private var resultMessage: String = ""

    var body: some View {
        // 主要畫面結構：使用 NavigationStack 包住 Form
        NavigationStack {
            // 表單區塊，分段呈現輸入與動作
            Form {
                Section("基本資料") {
                    TextField("請輸入名字", text: $customerName) // 姓名輸入框
                        .textInputAutocapitalization(.never) // 避免自動大寫
                    TextField("請輸入預算（元）", text: $budgetText) // 預算輸入框（只接受數字鍵盤）
                        .keyboardType(.numberPad) // iPhone 上顯示數字鍵盤
                }

                Section("選擇餐點") {
                    // 使用索引作為 selection，搭配 menu.indices
                    Picker("餐點", selection: $selectedItemIndex) {
                        ForEach(menu.indices, id: \.self) { index in    // 依序走過 0,1,2,... (每個都是一個選項)
                            let item = menu[index]                       // 取出對應的餐點
                            Text("\(item.name) - $\(item.price)")        // 顯示餐點名稱與價格
                                .tag(index)                              // 這個選項在 Picker 裡對應到的值就是 index
                        }
                    }.pickerStyle(.segmented) // 分段控制外觀，快速切換
                    Stepper(value: $quantity, in: 1...20) { // 限制份數 1...20
                        Text("份數：\(quantity)")
                    }
                    Toggle("每份加購\(drinkName)（$\(drinkPrice)/份）", isOn: $addDrink) // 是否加購飲料

                    Button(action: { // 觸發計算
                        calculate()
                    }) {
                        HStack(spacing: 8) {
                            Text("計算總金額") // 顯示按鈕文字
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity) // 讓按鈕撐滿可用寬度
                        .padding(12) // 增加可點擊區域
                    }
                    .buttonStyle(.borderedProminent) // 使用系統突顯樣式
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous)) // 圓角外觀
                }

                // 僅在有結果時顯示結果區塊，避免空白佔位
                if !resultMessage.isEmpty {
                    Section("點餐結果") {
                        Text(resultMessage)
                    }
                }

//                Section("今日菜單") {
//                    ForEach(menu) { item in
//                        VStack(alignment: .leading, spacing: 4) {
//                            HStack {
//                                Text(item.name)
//                                Spacer()
//                                Text("$\(item.price)")
//                                    .monospacedDigit()
//                            }
//                            Text(item.description)
//                                .font(.footnote)
//                                .foregroundStyle(.secondary)
//                        }
//                    }
//                    HStack {
//                        Text(drinkName)
//                        Spacer()
//                        Text("$\(drinkPrice)")
//                            .monospacedDigit()
//                    }
//                }
            }
            .navigationTitle("園遊會點餐小幫手")
        }
    }

    // MARK: - Logic
    private func calculate() {
        // 基本驗證：姓名不可空白
        let trimmedName = customerName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { // 若未填寫則回傳提示
            resultMessage = "請先輸入名字"
            return
        }

        // 基本驗證：預算必須為非負整數
        guard let budget = Int(budgetText.trimmingCharacters(in: .whitespacesAndNewlines)), budget >= 0 else { // 解析失敗或為負數則回傳提示並中止
            resultMessage = "請輸入正確的預算（整數金額）"
            return
        }

        // 取得目前選擇的餐點
        let item = menu[selectedItemIndex]

        // 計算單組價格與總價
        let unitPrice = item.price + (addDrink ? drinkPrice : 0)
        let total = unitPrice * quantity

        // 組裝描述文字（是否加購、展示名稱）
        let drinkPart = addDrink ? "，加購\(drinkName)" : ""
        let itemDisplay = item.displayName.isEmpty ? item.name : item.displayName

        // 根據預算判斷足夠或不足，產生對應訊息
        if budget >= total {
            let remain = budget - total
            resultMessage = "\(trimmedName)你好！你點了\(itemDisplay) \(quantity) 份\(drinkPart)，總共 \(total) 元。\n預算足夠，還剩 \(remain) 元。"
        } else {
            let lack = total - budget
            resultMessage = "\(trimmedName)你好！你點了\(itemDisplay) \(quantity) 份\(drinkPart)，總共 \(total) 元。\n你的預算只有 \(budget) 元，不足 \(lack) 元。"
        }
    }
}

// 預覽畫面
#Preview {
    OrderView()
}

