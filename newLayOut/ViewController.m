//
//  ViewController.m
//  newLayOut
//
//  Created by hapii on 2020/9/9.
//  Copyright © 2020 hapii. All rights reserved.
//

#import "ViewController.h"
#import "SessionModel.h"
#import <NSObject+YYModel.h>
#import "ViewSession.h"
#import "CardSession.h"

@interface ViewController ()<IGListAdapterDataSource, ASCollectionDelegate>

@property (nonatomic, strong) NSArray<id<IGListDiffable>> *sessionItems;
@property (nonatomic, strong) IGListAdapter *listAdapter;
@property (nonatomic, strong) ASCollectionNode *collectionNode;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionNode.view.alwaysBounceVertical = YES;
    // Do any additional setup after loading the view.
}

- (instancetype)init {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionNode = [[ASCollectionNode alloc] initWithCollectionViewLayout:layout];
    if (self = [super initWithNode:self.collectionNode]) {
        
        [self loadData];
        IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
        _listAdapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self workingRangeSize:0];
        _listAdapter.dataSource = self;
        [_listAdapter setASDKCollectionNode:self.collectionNode];
    }
    return self;
}

- (void)loadData {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"dataJson" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"\n%@", [error localizedDescription]);
    SessionModel *model = [SessionModel modelWithJSON:result];
    model.states = 0;
    
    SessionModel *model1 = [SessionModel modelWithJSON:result];
       model1.states = 1;
    
    self.sessionItems = @[model,model1];
    
}

#pragma mark - IGListAdapterDataSource

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter
{
  return self.sessionItems;
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter
{
  return [UIView new];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(SessionModel *)object
{
    
    if (object.states == 0) {
        return [[ViewSession alloc] init];
    }else if (object.states == 1){
        return [[CardSession alloc] init];
    }else {
        ASDisplayNodeFailAssert(@"Only supports objects of class PhotoFeedModel.");
        return nil;
    }
}
@end
