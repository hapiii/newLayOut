//
//  ViewSession.h
//  newLayOut
//
//  Created by hapii on 2020/9/9.
//  Copyright © 2020 hapii. All rights reserved.
//

#import "IGListSectionController.h"
#import "SessionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewSession : IGListSectionController

@property (nonatomic, strong) SessionModel *sessions;

@end

NS_ASSUME_NONNULL_END
