//
//  NewsModel.h
//  ReactiveCocoaProject
//
//  Created by biyabi on 15/11/3.
//  Copyright © 2015年 biyabi. All rights reserved.
//

#import "ModelObject.h"

@interface NewsModel : ModelObject

@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSDictionary *pageDictionary;
@property (nonatomic, strong) NSNumber *numberOfPage;//in
@property (nonatomic, strong) NSNumber *count;//in
@property (nonatomic, strong) NSNumber *pageCount;//in
@property (nonatomic, strong) NSArray *listArray;

@end

/*
 
 {
 "status": 1,
 "page": {
 "Page": 5,
 "Count": 58,
 "PageCount": 5
 },
 "list": [
 {
 "id": "12288",
 "title": "韩国美女COS阿狸 长腿酥胸魅惑",
 "thumb": "http://img.78dian.com/et/201508/14/1439536383_8604.jpeg",
 "summary": "长腿酥胸尽显魅惑，如此妖媚小狐狸你能不上钩？",
 "movie_url": "",
 "up": "8",
 "comment_num": "1",
 "tid": "5",
 "is_movie": "0",
 "time": "08月14日"
 },
 {
 "id": "12276",
 "title": "最美DOTA2女选手 甜美依人",
 "thumb": "http://img.78dian.com/et/201508/14/1439485090_3540.jpeg",
 "summary": "新加坡PMS女子战队的队员MsJovial。甜美小女人！瞬间融化！",
 "movie_url": "",
 "up": "3",
 "comment_num": "0",
 "tid": "5",
 "is_movie": "0",
 "time": "08月14日"
 },
 {
 "id": "12275",
 "title": "“撸”妹合集 颜值身材均爆表",
 "thumb": "http://img.78dian.com/et/201508/14/1439484812_7510.jpeg",
 "summary": "看到如此之多的正妹，就后悔为什么不早点打好LOL啊。",
 "movie_url": "",
 "up": "7",
 "comment_num": "3",
 "tid": "5",
 "is_movie": "0",
 "time": "08月14日"
 },
 {
 "id": "12232",
 "title": "都是大美妞，2015CJ美图合集",
 "thumb": "http://img.78dian.com/et/201508/12/1439344558_8932.jpeg",
 "summary": "2015CJ美女SG合集，你看着眼熟吗？",
 "movie_url": "",
 "up": "5",
 "comment_num": "4",
 "tid": "0",
 "is_movie": "0",
 "time": "08月12日"
 },
 {
 "id": "11451",
 "title": "ShowGirl健身房里香汗淋漓",
 "thumb": "http://img.78dian.com/et/201507/21/1437469049_1606.jpeg",
 "summary": "一年一度ChinaJoy即将来临，各家ShowGirl也都磨拳霍霍。",
 "movie_url": "",
 "up": "13",
 "comment_num": "7",
 "tid": "4",
 "is_movie": "0",
 "time": "07月21日"
 },
 {
 "id": "11290",
 "title": "最胸DOTA2女主播生活照曝光",
 "thumb": "http://img.78dian.com/et/201507/14/1436862805_5467.gif",
 "summary": "最胸女主播裹浴巾打DOTA2，宅男纷纷挂机投降。",
 "movie_url": "",
 "up": "13",
 "comment_num": "2",
 "tid": "0",
 "is_movie": "0",
 "time": "07月14日"
 },
 {
 "id": "11190",
 "title": "美女玩家博眼球 大秀豪乳深沟",
 "thumb": "http://img.78dian.com/et/201507/09/1436428615_7097.jpeg",
 "summary": "美女个个鼻血推荐，游戏玩的好身材更火爆！",
 "movie_url": "",
 "up": "16",
 "comment_num": "8",
 "tid": "0",
 "is_movie": "0",
 "time": "07月09日"
 },
 {
 "id": "11183",
 "title": "爆乳游戏女王 不喜欢好男孩",
 "thumb": "http://img.78dian.com/et/201507/09/1436418503_8225.jpeg",
 "summary": "17岁的美娜子表示，对她太好的男孩子反而适应不了。",
 "movie_url": "",
 "up": "18",
 "comment_num": "6",
 "tid": "0",
 "is_movie": "0",
 "time": "07月09日"
 },
 {
 "id": "10957",
 "title": "心疼我妞！跪地求施舍盒饭",
 "thumb": "http://img.78dian.com/et/201507/01/1435736221_2064.jpeg",
 "summary": "爆乳妹子跪地求施舍，你能不动心么？",
 "movie_url": "",
 "up": "3",
 "comment_num": "1",
 "tid": "4",
 "is_movie": "0",
 "time": "07月01日"
 },
 {
 "id": "985",
 "title": "美女玩家宛如邻家小妹",
 "thumb": "http://img.78dian.com/magazine_old/Uploads/53f2d935b88ff.gif",
 "summary": "美女玩家清纯无比，仿佛如邻家小妹一般。",
 "movie_url": "",
 "up": "1",
 "comment_num": "0",
 "tid": "0",
 "is_movie": "0",
 "time": "01月19日"
 }
 ]
 }
 
 */