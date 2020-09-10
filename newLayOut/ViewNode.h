//
//  ViewNode.h
//  newLayOut
//
//  Created by hapii on 2020/9/9.
//  Copyright © 2020 hapii. All rights reserved.
//
#import <Texture/AsyncDisplayKit/ASCellNode.h>
#import "ItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewNode : ASCellNode

- (instancetype)initWithObject:(ItemModel *)obj;

@end

NS_ASSUME_NONNULL_END
