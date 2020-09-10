//
//  CardNode.h
//  newLayOut
//
//  Created by hapii on 2020/9/10.
//  Copyright © 2020 hapii. All rights reserved.
//

#import <Texture/AsyncDisplayKit/AsyncDisplayKit.h>
#import "ItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardNode : ASCellNode

- (instancetype)initWithObject:(ItemModel *)obj;

@end

NS_ASSUME_NONNULL_END
