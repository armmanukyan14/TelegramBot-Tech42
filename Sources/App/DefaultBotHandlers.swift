//
//  DefaultBotHandlers.swift
//  
//
//  Created by Arman Manukyan on 06.06.22.
//

import Foundation
import Vapor
import telegram_vapor_bot

final class DefaultBotHandlers {

    static func addHandlers(app: Vapor.Application, bot: TGBotPrtcl) {
        defaultHandler(app: app, bot: bot)
        commandStartHandler(app: app, bot: bot)
        commandSiteHandler(app: app, bot: bot)
        commanCoursesHandler(app: app, bot: bot)
        commanFAQHandler(app: app, bot: bot)
        commandPMHandler(app: app, bot: bot)
        commandRegisterPMHandler(app: app, bot: bot)
        commandiOSHandler(app: app, bot: bot)
        commandRegisteriOSHandler(app: app, bot: bot)
        commandQAHandler(app: app, bot: bot)
        commandFAQ1Handler(app: app, bot: bot)
        commandFAQ2Handler(app: app, bot: bot)
        commandFAQ3Handler(app: app, bot: bot)
    }

    // MARK: - Default
    
    /// add handler for all messages unless command "/ping"
    private static func defaultHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGMessageHandler(filters: (.all &&
                                                 !.command.names(["/About"]) &&
                                                 !.command.names(["/Courses"]) &&
                                                 !.command.names(["/FAQ"]) &&
                                                 !.command.names(["/start"]) &&
                                                 !.command.names(["/QA"]) &&
                                                 !.command.names(["/register_for_QA"]) &&
                                                 !.command.names(["/PM"]) &&
                                                 !.command.names(["/register_for_PM"]) &&
                                                 !.command.names(["/iOS"]) &&
                                                 !.command.names(["/register_for_iOS"]) &&
                                                 !.command.names(["/1"]) &&
                                                 !.command.names(["/2"]) &&
                                                 !.command.names(["/3"]) &&
                                                 !.command.names(["/4"]) &&
                                                 !.command.names(["/5"])
                                                )) { update, bot in
            let params: TGSendMessageParams = .init(chatId: .chat(update.message!.chat.id), text: "Please select from menu")
            try bot.sendMessage(params: params)
        }
        bot.connection.dispatcher.add(handler)
    }
    
    // MARK: - Start
    
    /// add handler for command "/show_buttons" - show message with buttons
        private static func commandStartHandler(app: Vapor.Application, bot: TGBotPrtcl) {
            let handler = TGCommandHandler(commands: ["/start"]) { update, bot in
                guard let userId = update.message?.from?.id else { fatalError("user id not found") }

                let keyboard = [
                    [TGKeyboardButton(text: "/About ℹ️")],
                    [TGKeyboardButton(text: "/Courses 📚")],
                    [TGKeyboardButton(text: "/FAQ❔")]
                ]

                let replyKeyboardMarkup = TGReplyKeyboardMarkup(keyboard: keyboard, resizeKeyboard: true, oneTimeKeyboard: false, inputFieldPlaceholder: "Type something like /About", selective: false)
                
                let params: TGSendMessageParams = .init(chatId: .chat(userId),
                                                        text: "Please select from menu",
                                                        replyMarkup: .replyKeyboardMarkup(replyKeyboardMarkup))

                try bot.sendMessage(params: params)
            }

            bot.connection.dispatcher.add(handler)
        }
    
    // MARK: - Site
    
    private static func commandSiteHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/About"]) { update, bot in
            try update.message?.reply(text: """
                                            🧭Site - http://tech42.am
                                            
                                            ☎️Telephone - 012420042
                                            
                                            ✉️Email -  info@tech42.am
                                            
                                            📍Address - Բաղրամյան 21/3
                                            """,
                                      bot: bot)
        }
        bot.connection.dispatcher.add(handler)
    }
    
    // MARK: - Courses
    
    private static func commanCoursesHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/Courses"]) { update, bot in
            guard let userId = update.message?.from?.id else { fatalError("user id not found") }

            let keyboard = [
                [TGKeyboardButton(text: "/QA"), TGKeyboardButton(text: "/PM")],
                [TGKeyboardButton(text: "/iOS"), TGKeyboardButton(text: "/Sales")],
                [TGKeyboardButton(text: "/Javascript"), TGKeyboardButton(text: "/C#")],
                [TGKeyboardButton(text: "/Java"), TGKeyboardButton(text: "/UI_UX")],
                [TGKeyboardButton(text: "/Python"), TGKeyboardButton(text: "/Recruitment")]
            ]
            

            let replyKeyboardMarkup = TGReplyKeyboardMarkup(keyboard: keyboard, resizeKeyboard: true, oneTimeKeyboard: false, inputFieldPlaceholder: "Type /start to go back", selective: false)
            
            let params: TGSendMessageParams = .init(chatId: .chat(userId),
                                                    text: "Please select from menu",
                                                    replyMarkup: .replyKeyboardMarkup(replyKeyboardMarkup))

            try bot.sendMessage(params: params)
        }

        bot.connection.dispatcher.add(handler)
    }
    
    
    // MARK: - FAQ
    
    private static func commanFAQHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/FAQ"]) { update, bot in
            guard let userId = update.message?.from?.id else { fatalError("user id not found") }

            let keyboard = [
                [TGKeyboardButton(text: "/1 Ես չունեմ ծրագրավորման գիտելիքներ։ Արդյո՞ք կարող եմ սովորել Tech42-ում։")],
                [TGKeyboardButton(text: "/2 Ո՞ր ծրագրավորման լեզուն խորհուրդ կտաք սովորել սկսնակների համար։")],
                [TGKeyboardButton(text: "/3 Արդյո՞ք դասընթացների ավարտին ապահովում եք աշխատանքով։")],
                [TGKeyboardButton(text: "/4 Որքա՞ն է կազմում դասընթացի արժեքը և տևողությունը։")],
                [TGKeyboardButton(text: "/5 Արդյո՞ք սեփական համակարգչի առկայությունը պարտադիր է։")],
                [TGKeyboardButton(text: "/6 Անհատական պարապմունքներ ունե՞ք։")]
            ]

            let replyKeyboardMarkup = TGReplyKeyboardMarkup(keyboard: keyboard, resizeKeyboard: true, oneTimeKeyboard: false, inputFieldPlaceholder: "Type /start to go back", selective: false)
            
            let params: TGSendMessageParams = .init(chatId: .chat(userId),
                                                    text: "Please select from menu",
                                                    replyMarkup: .replyKeyboardMarkup(replyKeyboardMarkup))

            try bot.sendMessage(params: params)
        }

        bot.connection.dispatcher.add(handler)
    }
    
    private static func commandFAQ1Handler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/1"]) { update, bot in
            try update.message?.reply(text: "Այո, կարող եք։ Tech42-ում Դասընթացները նախատեսված են ինչպես սկսնակների համար, այնպես էլ արդեն որոշակի փորձ ունեցող մասնագետների համար։ Հարկավոր է գրանցվել սկսնակների համար նախատեսված դասընթացներից մեկում։",
                                      bot: bot)
        }
        
        bot.connection.dispatcher.add(handler)
    }
    
    private static func commandFAQ2Handler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/2"]) { update, bot in
            try update.message?.reply(text: "Ծրագրավորման լեզուները տարբեր են լինում, որոնց կիրառելիությունը նախատեսված է տարաբնույթ խնդիրների լուծմանը։ Այսպիսով, մեծ նշանակություն ունի թե ինչու՞ եք ցանկանում սովորել ծրագրավորում և ինչ եք ցանկանում անել Ձեր սովորածով: Tech42-ը ունի խորհրդատվության ծառայություն, պատվիրեք խորհրդատվությունը, որպեսզի մասնագտեը ճիշտ ուղղորդի Ձեզ։",
                                      bot: bot)
        }
        
        bot.connection.dispatcher.add(handler)
    }
    
    private static func commandFAQ3Handler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/3"]) { update, bot in
            try update.message?.reply(text: "Լավագույն ուսանողներին Tech42-ը առաջարկում է իրենց թեկնածությունը գործընկեր կազմակերպություններում` աշխատանքի անցնելու համար։",
                                      bot: bot)
        }
        
        bot.connection.dispatcher.add(handler)
    }
    // MARK: - QA
    
    private static func commandQAHandler(app: Vapor.Application, bot: TGBotPrtcl) {
           let handler = TGCommandHandler(commands: ["/QA"]) { update, bot in
               guard let userId = update.message?.from?.id else { fatalError("user id not found") }
               let buttons: [[TGInlineKeyboardButton]] = [
                   [.init(text: "📝Register for QA", url: "http://tech42.am/ios-fundamentals.html")]
               ]
               
               
               let keyboard: TGInlineKeyboardMarkup = .init(inlineKeyboard: buttons)
               let params: TGSendMessageParams = .init(chatId: .chat(userId),
                                                       text: """
                                                        ⏰Duration - 2 months
                                                        
                                                        💵Cost - 50.000AMD per month
                                                        
                                                        👩🏻‍💻Tutor - Lusine Simonyan(from EPAM)
                                                        """,
                                                       replyMarkup: .inlineKeyboardMarkup(keyboard))
               try bot.sendMessage(params: params)
           }
           bot.connection.dispatcher.add(handler)
       }
    
    // MARK: - PM
    
    private static func commandPMHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/PM"]) { update, bot in
            try update.message?.reply(text: """
                                            ⏰Duration - 3 months
                                            
                                            💵Cost - 55.000AMD per month
                                            
                                            📝/register_for_PM
                                            """,
                                      bot: bot)
        }
        bot.connection.dispatcher.add(handler)
    }
    
    private static func commandRegisterPMHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/register_for_PM"]) { update, bot in
            try update.message?.reply(text: "http://tech42.am/itpm-fundamentals.html", bot: bot)
        }
        bot.connection.dispatcher.add(handler)
    }
    
    // MARK: - iOS
    
    private static func commandiOSHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/iOS"]) { update, bot in
            try update.message?.reply(text: """
                                            ⏰Duration - 6 months
                                            
                                            💵Cost - 50.000AMD per month
                                            
                                            📝/register_for_iOS
                                            """,
                                      bot: bot)
        }
        bot.connection.dispatcher.add(handler)
    }
    
    private static func commandRegisteriOSHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/register_for_iOS"]) { update, bot in
            try update.message?.reply(text: "http://tech42.am/ios-fundamentals.html", bot: bot)
        }
        bot.connection.dispatcher.add(handler)
    }
}
