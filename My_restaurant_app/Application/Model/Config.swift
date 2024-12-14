//
//  Config.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//


struct Config: Codable {
    var type: String?
    var version:String?
    var domain:String?
    var api_key:String? = ""
    var api_domain:String?
    var report_domain:String?
    var report_domain_v2:String?
    var realtime_domain:String?
    var current_domain:String?
    var install_app_url:String?
    var aloline_new_feed_content_url_path:String?
    var is_allow_forgot_password:Int?
    var date_time:String?
    var api_chat_tms:String?
    var api_chat_aloline:String?
    var api_upload:String?
    var api_upload_v2:String?
    var api_upload_short:String?
    var api_connection:String?
    var api_log:String?
    var ads_domain:String?
    var chat_domain:String?
    var api_oauth_node:String?
    var api_saler:String?
    var socket_conect_login:String?
    var api_seemt_connection:String?
    var api_join_group:String?
    var is_enable_topup_card:Int?
    var realtime_ip:String?
    
}

