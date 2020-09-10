//
//  ItemModel.h
//  newLayOut
//
//  Created by hapii on 2020/9/9.
//  Copyright © 2020 hapii. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *star;

@property (nonatomic, copy) NSString *publicTime;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *toStar;

@property (nonatomic, copy) NSString *performer;

@property (nonatomic, copy) NSString *country;

@property (nonatomic, copy) NSString *alias;

@property (nonatomic, copy) NSString *videoDescribe;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *video;

@property (nonatomic, copy) NSString *videoTime;

@property (nonatomic, copy) NSString *episodes;
@end

NS_ASSUME_NONNULL_END
