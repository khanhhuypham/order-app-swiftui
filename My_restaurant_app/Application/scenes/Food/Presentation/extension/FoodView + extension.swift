

extension FoodView{
    
    func firstSetup(order:OrderDetail) {
        let enumOfOutStock = 10
        
        var array = [
            (id:FOOD_CATEGORY.buffet_ticket.rawValue,title:"Vé buffet",isSelected:false),
            (id:FOOD_CATEGORY.food.rawValue,title:"Món ăn",isSelected:false),
            (id:FOOD_CATEGORY.drink.rawValue,title:"Nước uống",isSelected:false),
            (id:FOOD_CATEGORY.other.rawValue,title:"Khác",isSelected:false),
            (id:FOOD_CATEGORY.service.rawValue,title:"Dịch vụ",isSelected:false),
            (id:enumOfOutStock,title:"Hết món",isSelected:false),
            (id:FOOD_CATEGORY.buffet_ticket.rawValue,title:"Buffet",isSelected:false)
        ]
        

        /*
            tab dịch vụ chỉ hiển thị đối với GPBH2 trở lên
            tab buffet chỉ hiển thị đối với GPBH2 trở lên
         */
        if PermissionUtils.GPBH_1 {
            
            array = [
               (id:FOOD_CATEGORY.food.rawValue,title:"Món ăn",isSelected:false),
               (id:FOOD_CATEGORY.drink.rawValue,title:"Nước uống",isSelected:false),
               (id:FOOD_CATEGORY.other.rawValue,title:"Khác",isSelected:false),
           ]
            
            
        }else if PermissionUtils.GPBH_2 || PermissionUtils.GPBH_3{
            

            if !PermissionUtils.is_enale_buffet{
                btnArray.removeAll(where: {$0.id == FOOD_CATEGORY.buffet_ticket.rawValue})
            }
            
                   
            if let buffet = order.buffet{
           
                array = [
                    (id:buffet.id,title:buffet.buffet_ticket_name ?? "",isSelected:false),
                    (id:FOOD_CATEGORY.food.rawValue,title:"Món ăn",isSelected:false),
                    (id:FOOD_CATEGORY.drink.rawValue,title:"Nước uống",isSelected:false),
                    (id:FOOD_CATEGORY.other.rawValue,title:"Khác",isSelected:false),
                    (id:FOOD_CATEGORY.service.rawValue,title:"Dịch vụ",isSelected:false),
                    (id:enumOfOutStock,title:"Hết món",isSelected:false),
                    (id:FOOD_CATEGORY.buffet_ticket.rawValue,title:"Buffet",isSelected:false)
                ]
            }else{
            
                array = [
                    (id:FOOD_CATEGORY.food.rawValue,title:"Món ăn",isSelected:false),
                    (id:FOOD_CATEGORY.drink.rawValue,title:"Nước uống",isSelected:false),
                    (id:FOOD_CATEGORY.other.rawValue,title:"Khác",isSelected:false),
                    (id:FOOD_CATEGORY.service.rawValue,title:"Dịch vụ",isSelected:false),
                    (id:enumOfOutStock,title:"Hết món",isSelected:false),
                    (id:FOOD_CATEGORY.buffet_ticket.rawValue,title:"Buffet",isSelected:false)
                ]
            
            }
            if viewModel.APIParameter.isAllowEmployeeGift == ACTIVE{
               
                array = [
                    (id:FOOD_CATEGORY.food.rawValue,title:"Món ăn",isSelected:false),
                    (id:FOOD_CATEGORY.drink.rawValue,title:"Nước uống",isSelected:false),
                    (id:FOOD_CATEGORY.other.rawValue,title:"Khác",isSelected:false),
                    (id:FOOD_CATEGORY.service.rawValue,title:"Dịch vụ",isSelected:false),
                    (id:enumOfOutStock,title:"Hết món",isSelected:false),
                ]
                
            }
            
            
            if viewModel.order.table_id == -2{//take away
               
                
                array = [
                    (id:FOOD_CATEGORY.food.rawValue,title:"Món ăn",isSelected:false),
                    (id:FOOD_CATEGORY.drink.rawValue,title:"Nước uống",isSelected:false),
                    (id:FOOD_CATEGORY.other.rawValue,title:"Khác",isSelected:false),
                    (id:FOOD_CATEGORY.service.rawValue,title:"Dịch vụ",isSelected:false),
                    (id:enumOfOutStock,title:"Hết món",isSelected:false),
                ]
                
            }
            
        }

        if order.booking_status == .status_booking_setup {

            array = [
                (id:FOOD_CATEGORY.drink.rawValue,title:"Nước uống",isSelected:true),
                (id:FOOD_CATEGORY.other.rawValue,title:"Khác",isSelected:false),
                (id:enumOfOutStock,title:"Hết món",isSelected:false),
            ]
        }
        
        btnArray = array
       
    }
    
    
    func handleChooseCategory(id:Int){
        var p = viewModel.APIParameter
        p.isOutStock = ALL
        p.buffetTicketId = nil
        p.keyWord = ""
        switch id {
            case FOOD_CATEGORY.all.rawValue:
                p.categoryType = .all
            
            case FOOD_CATEGORY.food.rawValue:
                p.categoryType = .food
            
            case FOOD_CATEGORY.drink.rawValue:
                p.categoryType = .drink
            
            case FOOD_CATEGORY.other.rawValue:
                p.categoryType = .other
            
            case FOOD_CATEGORY.service.rawValue:
                p.categoryType = .service
            
            case FOOD_CATEGORY.buffet_ticket.rawValue:
                p.categoryType = .buffet_ticket
            
            case viewModel.order.buffet?.id:
                if let buffet = viewModel.order.buffet {
                    p.categoryType = .food
                    p.buffetTicketId = buffet.buffet_ticket_id
                    
                }
            
                break
            
            default:
                p.categoryType = .all
                p.isOutStock = ACTIVE
          
            
        }
        viewModel.APIParameter = p
        Task{
            await self.viewModel.getCategories()
        }

    }
    
}
