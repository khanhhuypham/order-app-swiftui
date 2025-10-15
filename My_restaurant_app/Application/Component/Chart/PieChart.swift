//
//  PieChartView.swift
//  TechresOrder
//
//  Created by Pham Khanh Huy on 2/10/25.
//


import SwiftUI
import Charts



struct PieChartData:Identifiable {
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



struct PieChart: View {
    let data: [PieChartData]
    var addLegend:Bool = true
        
    var body: some View {
        
        if addLegend{
            chart.chartLegend(position: .trailing, alignment: .center, spacing: 12)
        }else{
            chart.chartLegend(.hidden)
        }

        
    }
    
    @ViewBuilder
    private var chart:some View{
        if #available(iOS 17.0, *) {
            Chart(data) { item in
                SectorMark(
                    angle: .value("Amount", item.y),
                    innerRadius: .ratio(0.6),  // 👈 makes it a donut
                    angularInset: 2
                )
                .cornerRadius(2)
                .foregroundStyle(item.color ?? .blue)
                .annotation(position: .overlay, alignment: .center) {
                    Text("").font(.caption)
                }
            }
            .frame(height: 200)
            .scaledToFit()
            .chartBackground { proxy in
                // Optional: Show total in center
                let total = data.reduce(0) { $0 + $1.y }
                Text(String(format: "Total\n%@", Int(total).toString))
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .position(
                        x: proxy.plotSize.width / 2,
                        y: proxy.plotSize.height / 2
                    )
            }
        }
    }
    
}



struct Pie: View {
    @State var slices: [(Double, Color)]
    var innerRatio: CGFloat = 0.6
    var centerText: String? = nil// 👈 optional text in the middle
    
    var body: some View {
        ZStack {
            // Donut drawing
            Canvas { context, size in
                let total = slices.reduce(0) { $0 + $1.0 }
                context.translateBy(x: size.width / 2, y: size.height / 2)
                var pieContext = context
                pieContext.rotate(by: .degrees(-90))
                
                let outerRadius = min(size.width, size.height) * 0.48
                let innerRadius = outerRadius * innerRatio
                var startAngle = Angle.zero
                
                for (value, color) in slices {
                    let angle = Angle(degrees: 360 * (value / total))
                    let endAngle = startAngle + angle
                    
                    let path = Path { p in
                        p.addArc(center: .zero,
                                 radius: outerRadius,
                                 startAngle: startAngle,
                                 endAngle: endAngle,
                                 clockwise: false)
                        p.addArc(center: .zero,
                                 radius: innerRadius,
                                 startAngle: endAngle,
                                 endAngle: startAngle,
                                 clockwise: true)
                        p.closeSubpath()
                    }
                    
                    pieContext.fill(path, with: .color(color))
                    startAngle = endAngle
                }
            }
            .aspectRatio(1, contentMode: .fit)
            
            // Center text
            if let text = centerText {
                Text(text)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.green)
            }
        }
    }
}


#Preview{
    PieChart(data:[
        .init(x: "00:00", y: 120000),
        .init(x: "01:00", y: 160000),
        .init(x: "02:00", y: 90000),
        .init(x: "03:00", y: 300000),
        .init(x: "04:00", y: 120000),
        .init(x: "05:00", y: 160000),
        .init(x: "06:00", y: 90000),
        .init(x: "07:00", y: 300000),
        .init(x: "08:00", y: 120000),
        .init(x: "09:00", y: 160000),
        .init(x: "10:00", y: 90000),
        .init(x: "11:00", y: 300000),
        .init(x: "12:00", y: 120000),
        .init(x: "13:00", y: 160000),
        .init(x: "14:00", y: 90000),
        .init(x: "15:00", y: 300000),
    ])
}
