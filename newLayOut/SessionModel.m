//
//  SessionModel.m
//  newLayOut
//
//  Created by hapii on 2020/9/9.
//  Copyright © 2020 hapii. All rights reserved.
//

#import "SessionModel.h"

@implementation SessionModel

#pragma mark - IGListDiffable
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"result":ItemModel.class};
}

- (id<NSObject>)diffIdentifier
{
  return self;
}

- (BOOL)isEqualToDiffableObject:(id<IGListDiffable>)object
{
  return self == object;
}
@end
