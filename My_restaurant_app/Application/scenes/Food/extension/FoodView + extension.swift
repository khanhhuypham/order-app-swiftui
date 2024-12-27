

extension FoodView{
    
    func firstSetup(order:OrderDetail) {
        let enumOfOutStock = 10
        
        var array = [
//            (id:CATEGORY_TYPE.buffet_ticket.rawValue,title:"Vé buffet",isSelected:false),
            (id:CATEGORY_TYPE.food.rawValue,title:"Món ăn",isSelected:false),
            (id:CATEGORY_TYPE.drink.rawValue,title:"Nước uống",isSelected:false),
            (id:CATEGORY_TYPE.other.rawValue,title:"Khác",isSelected:false),
            (id:CATEGORY_TYPE.service.rawValue,title:"Dịch vụ",isSelected:false),
            (id:enumOfOutStock,title:"Hết món",isSelected:false),
            (id:CATEGORY_TYPE.buffet_ticket.rawValue,title:"Buffet",isSelected:false)
        ]
        
        /*
            tab dịch vụ chỉ hiển thị đối với GPBH2 trở lên
            tab buffet chỉ hiển thị đối với GPBH2 trở lên
         */
        if PermissionUtils.GPBH_1 {
            
            array = [
               (id:CATEGORY_TYPE.food.rawValue,title:"Món ăn",isSelected:false),
               (id:CATEGORY_TYPE.drink.rawValue,title:"Nước uống",isSelected:false),
               (id:CATEGORY_TYPE.other.rawValue,title:"Khác",isSelected:false),
           ]
            
            
        }else if PermissionUtils.GPBH_2 || PermissionUtils.GPBH_3{
            
            if !PermissionUtils.is_enale_buffet{
                btnArray.removeAll(where: {$0.id == CATEGORY_TYPE.buffet_ticket.rawValue})
            }
            
                   
            if let buffet = order.buffet{
                array = [
//                    (id:buffet.id,title:buffet.buffet_ticket_name ?? "",isSelected:false),
                    (id:CATEGORY_TYPE.food.rawValue,title:"Món ăn",isSelected:false),
                    (id:CATEGORY_TYPE.drink.rawValue,title:"Nước uống",isSelected:false),
                    (id:CATEGORY_TYPE.other.rawValue,title:"Khác",isSelected:false),
                    (id:CATEGORY_TYPE.service.rawValue,title:"Dịch vụ",isSelected:false),
                    (id:enumOfOutStock,title:"Hết món",isSelected:false),
                    (id:CATEGORY_TYPE.buffet_ticket.rawValue,title:"Buffet",isSelected:false)
                ]
            }else{
            
                array = [
                    (id:CATEGORY_TYPE.food.rawValue,title:"Món ăn",isSelected:false),
                    (id:CATEGORY_TYPE.drink.rawValue,title:"Nước uống",isSelected:false),
                    (id:CATEGORY_TYPE.other.rawValue,title:"Khác",isSelected:false),
                    (id:CATEGORY_TYPE.service.rawValue,title:"Dịch vụ",isSelected:false),
                    (id:enumOfOutStock,title:"Hết món",isSelected:false),
                    (id:CATEGORY_TYPE.buffet_ticket.rawValue,title:"Buffet",isSelected:false)
                ]
            
            }
            if viewModel.APIParameter.is_allow_employee_gift == ACTIVE{
               
                array = [
                    (id:CATEGORY_TYPE.food.rawValue,title:"Món ăn",isSelected:false),
                    (id:CATEGORY_TYPE.drink.rawValue,title:"Nước uống",isSelected:false),
                    (id:CATEGORY_TYPE.other.rawValue,title:"Khác",isSelected:false),
                    (id:CATEGORY_TYPE.service.rawValue,title:"Dịch vụ",isSelected:false),
                    (id:enumOfOutStock,title:"Hết món",isSelected:false),
                ]
                
            }
            
            
            if viewModel.order.table_id == -2{//take away
               
                array = [
                    (id:CATEGORY_TYPE.food.rawValue,title:"Món ăn",isSelected:false),
                    (id:CATEGORY_TYPE.drink.rawValue,title:"Nước uống",isSelected:false),
                    (id:CATEGORY_TYPE.other.rawValue,title:"Khác",isSelected:false),
                    (id:CATEGORY_TYPE.service.rawValue,title:"Dịch vụ",isSelected:false),
                    (id:enumOfOutStock,title:"Hết món",isSelected:false),
                ]
                
            }
            
        }

        if order.booking_status == .status_booking_setup {

            array = [
                (id:CATEGORY_TYPE.drink.rawValue,title:"Nước uống",isSelected:true),
                (id:CATEGORY_TYPE.other.rawValue,title:"Khác",isSelected:false),
                (id:enumOfOutStock,title:"Hết món",isSelected:false),
            ]
        }
        btnArray = array
    }
    
    
    func handleChooseCategory(id:Int){
        var p = viewModel.APIParameter
        p.out_of_stock = false
        p.buffet_ticket_id = nil
        p.key_word = ""
        switch id {
            
            case CATEGORY_TYPE.food.rawValue:
                p.category_type = .food
            
            case CATEGORY_TYPE.drink.rawValue:
                p.category_type = .drink
            
            case CATEGORY_TYPE.other.rawValue:
                p.category_type = .other
            
            case CATEGORY_TYPE.service.rawValue:
                p.category_type = .service
            
            case CATEGORY_TYPE.buffet_ticket.rawValue:
                p.category_type = .buffet_ticket
            
//            case viewModel.order.buffet?.id:
//                if let buffet = viewModel.order.buffet {
//                    p.category_type = .food
//                    p.buffet_ticket_id = buffet.buffet_ticket_id
//                }
//            
//                break
            
            default:
                p.category_type = nil
                p.out_of_stock = true
          
        }

        viewModel.APIParameter = p
        viewModel.getCategories()


    }
    
}
