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
        commandQAHandler(app: app, bot: bot)
        commandRegisterQAHandler(app: app, bot: bot)
        commandPMHandler(app: app, bot: bot)
        commandRegisterPMHandler(app: app, bot: bot)
        commandiOSHandler(app: app, bot: bot)
        commandRegisteriOSHandler(app: app, bot: bot)
    }

    // MARK: - Default
    
    /// add handler for all messages unless command "/ping"
    private static func defaultHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGMessageHandler(filters: (.all &&
                                                 !.command.names(["/Site"]) &&
                                                 !.command.names(["/Courses"]) &&
                                                 !.command.names(["/start"]) &&
                                                 !.command.names(["/QA"]) &&
                                                 !.command.names(["/register_for_QA"]) &&
                                                 !.command.names(["/PM"]) &&
                                                 !.command.names(["/register_for_PM"]) &&
                                                 !.command.names(["/iOS"]) &&
                                                 !.command.names(["/register_for_iOS"])
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
                    [TGKeyboardButton(text: "/Site")],
                    [TGKeyboardButton(text: "/Courses")]
                ]

                let replyKeyboardMarkup = TGReplyKeyboardMarkup(keyboard: keyboard, resizeKeyboard: true, oneTimeKeyboard: false, inputFieldPlaceholder: "Type something like /Courses...", selective: false)
                
                let params: TGSendMessageParams = .init(chatId: .chat(userId),
                                                        text: "Please select from menu",
                                                        replyMarkup: .replyKeyboardMarkup(replyKeyboardMarkup))

                try bot.sendMessage(params: params)
            }

            bot.connection.dispatcher.add(handler)
        }
    
    // MARK: - Site
    
    private static func commandSiteHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/Site"]) { update, bot in
            try update.message?.reply(text: "http://tech42.am", bot: bot)
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
            

            let replyKeyboardMarkup = TGReplyKeyboardMarkup(keyboard: keyboard, resizeKeyboard: true, oneTimeKeyboard: false, inputFieldPlaceholder: "Type something like /QA...", selective: false)
            
            let params: TGSendMessageParams = .init(chatId: .chat(userId),
                                                    text: "Please select from menu",
                                                    replyMarkup: .replyKeyboardMarkup(replyKeyboardMarkup))

            try bot.sendMessage(params: params)
        }

        bot.connection.dispatcher.add(handler)
    }
    
    // MARK: - QA
    
    private static func commandQAHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/QA"]) { update, bot in
            try update.message?.reply(text: """
                                            ⏰Duration - 2 months
                                            
                                            💵Cost - 50.000AMD per month
                                            
                                            📝/register_for_QA
                                            """,
                                      bot: bot)
        }
        bot.connection.dispatcher.add(handler)
    }
    
    private static func commandRegisterQAHandler(app: Vapor.Application, bot: TGBotPrtcl) {
        let handler = TGCommandHandler(commands: ["/register_for_QA"]) { update, bot in
            try update.message?.reply(text: "http://tech42.am/qa-manual.html", bot: bot)
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
    
    // MARK: - Comments
    
        /// add two handlers for callbacks buttons
//        private static func buttonsActionHandler(app: Vapor.Application, bot: TGBotPrtcl) {
//            let handler = TGCallbackQueryHandler(pattern: "press 1") { update, bot in
//                let params: TGAnswerCallbackQueryParams = .init(callbackQueryId: update.callbackQuery?.id ?? "0",
//                                                                text: update.callbackQuery?.data  ?? "data not exist",
//                                                                showAlert: nil,
//                                                                url: nil,
//                                                                cacheTime: nil)
//                try bot.answerCallbackQuery(params: params)
//            }
//
//            let handler2 = TGCallbackQueryHandler(pattern: "press 2") { update, bot in
//                let params: TGAnswerCallbackQueryParams = .init(callbackQueryId: update.callbackQuery?.id ?? "0",
//                                                                text: update.callbackQuery?.data  ?? "data not exist",
//                                                                showAlert: nil,
//                                                                url: nil,
//                                                                cacheTime: nil)
//                try bot.answerCallbackQuery(params: params)
//            }
//
//            bot.connection.dispatcher.add(handler)
//            bot.connection.dispatcher.add(handler2)
//        }
    
    /// add handler for command "/ping"
//    private static func commandPingHandler(app: Vapor.Application, bot: TGBotPrtcl) {
//        let handler = TGCommandHandler(commands: ["/ping"]) { update, bot in
//            try update.message?.reply(text: "pong", bot: bot)
//        }
//        bot.connection.dispatcher.add(handler)
//    }
}
