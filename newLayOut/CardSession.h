//
//  CardSession.h
//  newLayOut
//
//  Created by hapii on 2020/9/10.
//  Copyright © 2020 hapii. All rights reserved.
//

#import "IGListSectionController.h"
#import "SessionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardSession : IGListSectionController

@property (nonatomic, strong) SessionModel *sessions;

@end

NS_ASSUME_NONNULL_END
