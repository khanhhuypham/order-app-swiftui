//
//  BarChart.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 8/10/25.
//
import SwiftUI
import Charts


struct BarChartData:Identifiable {
    let id = UUID()
    let x: String
    let y: Double
    var color: Color? = nil
    
    init(x: String, y: Double) {
        self.x = x
        self.y = y
    }
    
    init(x: String, y: Double,color: Color? = nil) {
        self.x = x
        self.y = y
        self.color = color
    }
}




struct BarChart: View {
    @Injected(\.fonts) private var font
    @Injected(\.colors) private var color
    let data: [BarChartData]
    var scrollabel: Bool = false
    var visibleColumn:Int? = nil
    
    var body: some View {

        if scrollabel, #available(iOS 17.0, *) {
            chart
                .chartScrollableAxes(.horizontal)
                .chartXVisibleDomain(length: visibleColumn ?? 5)
        } else {
            chart
        }
       
        
    }
    
    
    private var chart:some View{
        Chart(data) { item in
            BarMark(
                x: .value("Category", item.x),
                y: .value("Value", item.y)
            )
            .foregroundStyle(item.color ?? .blue)
            // For giving cornerRadius
            //            .clipShape(RoundedRectangle(cornerRadius: 5))
            .annotation(position: .top, content: {
                VStack {
                    Text(ChartUtils.stringForValue(item.y))
                        .font(font.m_9)
                        .foregroundColor(.black)
                    
                }
            })
            
        }
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisGridLine().foregroundStyle(.gray)
                
                // Labels
                AxisValueLabel {
                    if let val = value.as(Double.self) {
                        Text(ChartUtils.stringForValue(val))
                            .font(font.m_10)
                            .foregroundColor(Color.gray)
                    }
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: data.map { $0.x }) { value in
                
                AxisGridLine().foregroundStyle(.gray)
                
                AxisValueLabel {
                    if let label = value.as(String.self) {
                        Text(label)
                            .font(font.m_10)
                            .foregroundColor(.gray)
                            .rotationEffect(.degrees(-45)) // 👈 rotate 30 degrees
                            .offset(y: 15) // 👈 move down a bit for better alignment
//                            .padding(.top,10)
                            .frame(width: 60, alignment: .leading)
                    }
                }
            }
        }
        .chartLegend(position: .top, alignment: .leading) {
            Text("Monthly Sales")
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
#Preview {
    
    let data: [BarChartData] = [
        .init(x: "Phạm Khánh Huy", y: 120000),
        .init(x: "Phạm Hữu Quyền", y: 160000),
        .init(x: "Nguyễn Thị Thanh Thuý", y: 90000),
        .init(x: "Châu Huỳnh Hồng Phúc", y: 300000),
        .init(x: "04:00", y: 100000),
       

    ]
    
    BarChart(data: data)
        .padding(.top,20)
        .frame(height: 180)
}
