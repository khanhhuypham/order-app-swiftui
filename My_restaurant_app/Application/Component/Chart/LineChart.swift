//
//  LineChart.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 2/10/25.
//


import SwiftUI
import Charts



struct LineChartData {
    let id = UUID()
    let day: String
    let amount: Double
}


struct LineChartView: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    let data: [LineChartData]
       
    var body: some View {
        VStack(alignment: .leading) {
            Text("Line Chart")
                .font(.system(size: 16, weight: .medium))
            
            Chart {
                ForEach(data, id: \.id) { item in
                    
                    LineMark(
                        x: .value("Category", item.day),
                        y: .value("Amount", item.amount)
                    )
                    .foregroundStyle(.blue) // 👈 color of the line
                    .interpolationMethod(.catmullRom) // 👈 smooth the line
                    .lineStyle(.init(lineWidth: 2)) // 👈 thickness of line
                    .symbol { // 👇 defines how data points look
                         Circle()
                             .fill(.blue)
                             .frame(width: 6, height: 6)
                    }
                    
                    AreaMark(
                          x: .value("Category", item.day),
                          y: .value("Amount", item.amount)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(
                        .linearGradient(
                          colors: [.blue.opacity(0.4), .blue.opacity(0.1)],
                          startPoint: .top,
                          endPoint: .bottom
                        )
                    )
            
                }
              
            }
            .chartYAxis {
               AxisMarks(position: .leading) { value in
                   
                   AxisGridLine().foregroundStyle(.gray)

                   AxisValueLabel {
                       if let val = value.as(Double.self) {
                           
                           Text(ChartUtils.stringForValue(val))
                               .font(font.m_10)
                               .foregroundStyle(.gray)
                       }
                   }
               }
            }
            .chartXAxis {
                AxisMarks(values: data.map { $0.day }) { value in
              
                    AxisGridLine().foregroundStyle(.gray)

                    AxisValueLabel{
                        if let time = value.as(String.self) {
                         Text(time)
                             .font(font.m_10)
                             .foregroundStyle(.gray)
                             .rotationEffect(.degrees(-45)) // 👈 rotate 30 degrees
                             .offset(y: 5) // 👈 move down a bit for better alignment
                             .frame(width: 30, alignment: .leading)
                        }
                    }
                }
            }
            .chartPlotStyle { plotArea in
                 plotArea
                     // vertical Y-axis line (left inside plot area)
                     .overlay(alignment: .leading) {
                         Rectangle()
                             .fill(.black)
                             .frame(width: 1.5)
                     }
                     // horizontal X-axis baseline (bottom inside plot area)
                     .overlay(alignment: .bottom) {
                         Rectangle()
                             .fill(.black)
                             .frame(height: 1.5)
                     }
            }
        }
    }
}



#Preview {
    
    let data: [LineChartData] = [
        .init(day: "00:00", amount: 120000),
        .init(day: "03:00", amount: 160000),
        .init(day: "06:00", amount: 90000),
        .init(day: "09:00", amount: 300000),
        .init(day: "12:00", amount: 100000),
        .init(day: "15:00", amount: 200000),
        .init(day: "18:00", amount: 111000),
        .init(day: "21:00", amount: 245000),
    ]
    
    LineChartView(data: data)
        .padding(.top,20)
        .frame(height: 150)
}
