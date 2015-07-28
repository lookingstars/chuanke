//
//  JZAlbumListModel.h
//  chuanke
//
//  Created by jinzelu on 15/7/23.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZAlbumListModel : NSObject

@property(nonatomic, strong) NSString *AlbumID;
@property(nonatomic, strong) NSString *Title;
@property(nonatomic, strong) NSString *PhotoURL;
@property(nonatomic, strong) NSString *Sort;
@property(nonatomic, strong) NSString *message;

@property(nonatomic, strong) NSString *IphoneType;
@property(nonatomic, strong) NSString *IpadType;

@end
