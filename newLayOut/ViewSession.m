//
//  ViewSession.m
//  newLayOut
//
//  Created by hapii on 2020/9/9.
//  Copyright © 2020 hapii. All rights reserved.
//

#import "ViewSession.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ViewNode.h"

@interface ViewSession ()<ASSectionController>

@end

@implementation ViewSession

#pragma mark - IGListSectionType

- (NSInteger)numberOfItems {
    return self.sessions.result.count;
}
- (void)didUpdateToObject:(id)object
{
  _sessions = object;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  return [ASIGListSectionControllerMethods cellForItemAtIndex:index sectionController:self];
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return [ASIGListSectionControllerMethods sizeForItemAtIndex:index];
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
    
}

- (ASCellNodeBlock)nodeBlockForItemAtIndex:(NSInteger)index {
    
    ItemModel *object = self.sessions.result[index];
    ASCellNode *(^nodeBlock)(void) =  ^{
      ViewNode *cellNode = [[ViewNode alloc] initWithObject:object];
      return cellNode;
    };
  return nodeBlock;
}

@end
