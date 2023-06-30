//
//  UserData.swift
//  MightyK1ngRichard-App
//
//  Created by Дмитрий Пермяков on 23.06.2023.
//

import Foundation
import CryptoKit


struct UserData: Identifiable {
    var id             : Int
    var nickname       : String
    var description    : String?
    var locationInfo   : String?
    var university     : String?
    var backroundImage : URL?
    var userAvatar     : URL?
    var countOfFriends : Int
}

struct UserPostData: Identifiable {
    let id              : UUID
    var user            : UserData
    var datePublic      : Date
    var content         : String?
    var countOfLike     : Int
    var countOfComments : Int
    var imageInPost     : URL?
    var comments        : [CommentUnderPost]
}

struct CommentUnderPost: Identifiable {
    let id             : UUID
    var date           : Date
    var content        : String
    var countOfLike    : Int
    var imageInComment : URL?
}

struct UserImagesData: Identifiable {
    let id    : UUID
    var image : URL?
}


// MARK: - Тестовые данные для вёрски
let testUser = UserData(id: 1, nickname: "Dmitriy Permyakov", description: " Engoing Web/iOS developing", locationInfo: "London", university: "МГТУ им. Н.Э.Баумана", backroundImage: backImg, userAvatar: userURL, countOfFriends: 105)

let testPosts: [UserPostData] = [
    .init(id: UUID(), user: testUser, datePublic: .now, content: testText2, countOfLike: 16, countOfComments: 4, imageInPost: imageOfPostThird, comments: testComments),
    .init(id: UUID(), user: testUser, datePublic: .now, content: testText, countOfLike: 9, countOfComments: 5, imageInPost: imageOfPostSecond, comments: testComments),
    .init(id: UUID(), user: testUser, datePublic: .now, content: testText, countOfLike: 8, countOfComments: 6, imageInPost: imageOfPost, comments: testComments),
    .init(id: UUID(), user: testUser, datePublic: .now, content: testText, countOfLike: 7, countOfComments: 8, imageInPost: imageOfPostSecond, comments: testComments),
    .init(id: UUID(), user: testUser, datePublic: .now, content: testText, countOfLike: 5, countOfComments: 10, imageInPost: imageOfPost, comments: testComments),
    
]

let testComments: [CommentUnderPost] = [
    // ....
]

let testImagesUser: [UserImagesData] = [
    .init(id: UUID(), image: imageOfPost),
    .init(id: UUID(), image: imageOfPostSecond),
    .init(id: UUID(), image: imageOfPostThird),
    .init(id: UUID(), image: backImg),
    .init(id: UUID(), image: imageOfPostThird),
    .init(id: UUID(), image: imageOfPostSecond),
    .init(id: UUID(), image: imageOfPostSecond),
]


private let backImg = URL(string: "https://d1lss44hh2trtw.cloudfront.net/assets/article/2023/01/09/apple-to-unveil-mixed-reality-headset-spring-2023-news_feature.jpg")!

private let userURL = URL(string: "https://ru-static.z-dn.net/files/df9/899fd190739b0985daa1921650cb9897.jpg")!

private let testText = """
Пишу что-то для тест поста. Я хз что писать для проверки вёрстки, но надо побольше текста.
Так, вот я сделал абзац.

А вот теперь ещё один.
""".trimmingCharacters(in: .whitespaces)

private let testText2 = """
Некоторые режиссеры просто могут, вот и всё. Талант есть талант.

Великолепный визуал. Очень понравилось всё такое красочное, яркое, контрастное. Местами стиль отдельных пауков немного раздражал (панка), но это вкусовщина. В целом и в большинстве своём я просто наслаждался визуалом, который ещё и двигался... Ах как же он двигался, этот визуал...

Мечтаю увидеть какой-нибудь новый фильм (с живыми актерами) с экшеном на таком высоком уровне. Возможно ли это? Всё таки есть близкие примеры, но чуток недотягивающие. Великолепные ракурсы, изобретательные ситуации, а музыкальное сопровождение... Ммм, я уже не могу сосчитать сколько раз по моей спине пробежали мурашки во время просмотра. Сидишь, смотришь и бум бац хряк, а картинка уносит тебя в фееричный вихрь экшена, движения, взаимодействующих элементов. Это невозможно повторить за деньги. Нельзя просто дать съемочной команде 1 млрд долларов и сказать сделайте также. Это просто невозможно и компания Марвел (и не только она) это доказала своим безвкусным дорогим экшеном. Такие фильмы как 'Человек-паук: Паутина вселенных' нужно ценить и оставлять на доске почета только лишь за это. Как мне понравился экшен в 'Коте в сапогах 2', но тут он реально круче и его значительно больше. Браво.

Сюжет. Сюжет про подростковые проблемы. Я тоже раньше был подростком. Все взрослые были подростками. Что ж, я не против ещё разок посмотреть историю про то как кто то становится взрослым и самостоятельным. Ничего нового тут не увидел, но и не раздражало почти ничего. Хороший такой бэкграунд для супер-мега-экшена. Хотя одну вещь я таки не понял, нафига сами знаете кто рассказал сами знаете кому про грядущую смерть сами знаете кого. Алё, зачем? Промолчал бы и подождал два дня. Это же ребенок, кому вообще пришло в голову ему такое рассказывать и ждать 'понимания' и адекватной реакции? Это конечно большая сценарная дыра, ну да ладно.

Понравились характеры героев. Панк, который отрицает команды и логику: )) Девушка-паучиха отличный персонаж со своей драмой. Забавный паучок в розовом халате. Принципиальный несгибаемый паук-смотритель, который пытается сделать так, чтобы всё не развалилось. Немного смутила беременная паучиха, ну блин... Как юморной заход ладно, но больше похоже на повесточку.

Ну и что ж... В итоге получился очень очень очень крутой экшен боевик с более менее цельным сюжетом, за которым интересно наблюдать. Забавными персонажами. Отличной музыкальной составляющей и великолепным визуалом. Заслуженно, высокие оценки. В море серости и стандартности (однообразие, тупость и повестка) этот продукт должен быть поднят над всеми остальными и быть замечен. С удовольствием посмотрю ещё ни раз дома.
"""

private let imageOfPost = URL(string: "https://img1.akspic.ru/attachments/crops/7/1/6/8/6/168617/168617-wwdc22-grafika-art-gaz-vizualnyj_effekt_osveshheniya-1366x768.jpg")!
private let imageOfPostSecond = URL(string: "https://w.forfun.com/fetch/5a/5a86e6d603f9a2a5c0322847d1c6680f.jpeg")!
private let imageOfPostThird = URL(string: "https://i.ytimg.com/vi/lI_mqAJ71dw/maxresdefault.jpg?7857057827")!
