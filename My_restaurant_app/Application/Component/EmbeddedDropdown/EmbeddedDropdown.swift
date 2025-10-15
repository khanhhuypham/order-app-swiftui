////
////  Untitled.swift
////  TechresOrder
////
////  Created by Pham Khanh Huy on 2/10/25.
////
////
//
//import SwiftUI
//
//struct EmbeddedDropDown: View {
//    @Injected(\.fonts) private var font
//    @Injected(\.colors) private var color
//    @State private var isExpanded = false
//    @State private var searchText = ""
//    @Binding var selectedId: Int?  // Changed to Binding
//    @Binding var selectedIds: [Int]  // Changed to Binding
//    
//
//    let optionArray: [(id: Int,name: String)]
//    let multiSelection: Bool
//    let searchBarHeight: CGFloat
//    let listHeight: CGFloat
//    let isSearchEnabled: Bool
//    let onSelect: (String, Int) -> Void
//    let onDelete: (String, Int) -> Void
//    
//    // MARK: - Computed Properties
//    private var filteredData: [(id: Int, name: String, isSelected: Bool)] {
//        let mappedData = optionArray.map { (id: $0.id, name: $0.name, isSelected: isItemSelected($0.id)) }
//        
//        if searchText.isEmpty {
//            return mappedData
//        }
//        
//        return mappedData.filter { item in
//            item.name.lowercased()
//                .folding(options: .diacriticInsensitive, locale: .current)
//                .contains(searchText.lowercased()
//                    .folding(options: .diacriticInsensitive, locale: .current))
//        }
//    }
//    
//    // MARK: - Init
//    init(
//        selectedId: Binding<Int?> = .constant(nil),  // Accepting Binding for selectedId
//        selectedIds: Binding<[Int]> = .constant([]),
//        optionArray: [(id: Int,name: String)],
//        multiSelection: Bool = true,
//        searchBarHeight: CGFloat = 40,
//        listHeight: CGFloat = 100,
//        isSearchEnabled: Bool = true,
//        onSelect: @escaping (String, Int) -> Void,
//        onDelete: @escaping (String, Int) -> Void
//    ) {
// 
//        self._selectedId = selectedId
//        self._selectedIds = selectedIds
//        
//        self.optionArray = optionArray
//        self.multiSelection = multiSelection
//        self.searchBarHeight = searchBarHeight
//        self.listHeight = listHeight
//        self.isSearchEnabled = isSearchEnabled
//        self.onSelect = onSelect
//        self.onDelete = onDelete
//    }
//    
//    // MARK: - Body
//    var body: some View {
//        VStack(spacing: 8) {
//            // Search Bar
//            HStack(spacing: 0) {
//                if isSearchEnabled {
//                    TextField("Search", text: $searchText)
//                        .font(font.r_12)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .frame(height: searchBarHeight)
//                }
//                    
//                Button(action: {
//                    withAnimation {
//                        isExpanded.toggle()
//                    }
//                }) {
//                    Image(systemName:"chevron.down")
//                        .rotationEffect(.degrees(isExpanded ? 180 : 0))  // Rotate the chevron
//                        .animation(.easeInOut(duration: 0.3), value: isExpanded)  // Smooth animation for rotations
//                        .padding(.horizontal)
//                }
//            }
//        
//            // Dropdown List
//            if isExpanded {
//            
//                if multiSelection{
//                    TagList
//                }
//                
//                VStack{
//                    if filteredData.isEmpty {
//                        Text("Không có dữ liệu").font(font.r_12)
//                    } else {
//                        List(filteredData, id: \.id) { item in
//                            DropdownRow(
//                                item: item,
//                                font:font.r_12
//                            )
//                            .buttonStyle(.plain)
//                            .alignmentGuide(.listRowSeparatorLeading) { d in d[.leading] }
//                            .listRowBackground(Color(.systemGray6))
//                            .onTapGesture {
//                                handleSelection(item)
//                            }
//                        }
//                        .listStyle(.plain)
//                    }
//                }
//                .frame(height: listHeight)
//                .frame(maxWidth: .infinity)
//                .background(Color(.systemGray6))
//                
//               
//            }
//        }.onAppear(perform: {
//            isExpanded = !selectedIds.isEmpty
//      
//        })
//
//    }
//    
//
//
//    private var TagList: some View{
//        let viewArray: [TagView<(some View)>] = selectedIds.map { id in
//            guard let option = optionArray.first(where: { $0.id == id }) else {
//                return (id: 0, name: "", isSelected: false)
//            }
//            
//            return (id: option.id, name: option.name, isSelected: true)
//        }.map { data in
//            TagView(content: {
//                HStack {
//                   Text(data.name).font(font.sb_12)
//                    
//                   Button(action: {
//                       handleSelection(data)
//                   }) {
//                       Image(systemName: "xmark")
//                   }
//                }
//                .foregroundColor(.white)
//                .padding(.all, 8)
//                .background(color.green_matcha)
//                .cornerRadius(7)
//            })
//        }
//
//        return TagListView(viewArray, horizontalSpace: 8, verticalSpace: 8).frame(alignment: .top)
//
//    }
//    
//    // MARK: - Helper Methods
//    private func isItemSelected(_ id: Int) -> Bool {
//        if multiSelection {
//            return selectedIds.contains(id)
//        } else {
//            return selectedId == id
//        }
//    }
//    
//    private func handleSelection(_ item: (id: Int, name: String, isSelected: Bool)) {
//        if multiSelection {
//            var currentIds = selectedIds
//            if currentIds.contains(item.id) {
//              
//                currentIds.removeAll { $0 == item.id }
//                onDelete(item.name, item.id)
//                
//            } else {
//                
//                currentIds.append(item.id)
//                onSelect(item.name, item.id)
//                
//            }
//            selectedIds = currentIds
//        } else {
//            selectedId = item.id
//            isExpanded = false
//        }
//
//    }
//}
//
//// MARK: - DropdownRow
//struct DropdownRow: View {
//    let item: (id: Int, name: String, isSelected: Bool)
//    let font:Font
//
//    var body: some View {
//        HStack {
//            Text(item.name)
//                .font(font)
//                .foregroundColor(.black)
//                .padding(.horizontal, 10)
//            Spacer()
//            
//            if  item.isSelected{
//                Image(systemName: "checkmark")
//                    .foregroundColor(.green)
//                    .padding(.trailing, 10)
//            }
//        }
//    }
//}
