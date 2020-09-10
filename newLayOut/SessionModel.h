//
//  SessionModel.h
//  newLayOut
//
//  Created by hapii on 2020/9/9.
//  Copyright © 2020 hapii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListDiff.h>
#import "ItemModel.h"

NS_ASSUME_NONNULL_BEGIN
//http://web.peakchao.top:250/video/getVideoBanner

@interface SessionModel : NSObject<IGListDiffable>

@property (nonatomic, assign) NSInteger states;

@property (nonatomic, copy) NSArray <ItemModel *> *result;

@end

NS_ASSUME_NONNULL_END
