//
//  FoodEntity.swift
//  My_restaurant_app
//
//  Created by Pham Khanh Huy on 12/11/25.
//
import Foundation
import CoreData

@objc(CategoryEntity)
public class CategoryEntity: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var workoutType: Int16
    @NSManaged public var date: Date?
    @NSManaged public var type: Int16
    @NSManaged public var count: Int16
}
