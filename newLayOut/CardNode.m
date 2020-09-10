//
//  CardNode.m
//  newLayOut
//
//  Created by hapii on 2020/9/10.
//  Copyright © 2020 hapii. All rights reserved.
//

#import "CardNode.h"

static const CGFloat kOuterPadding = 16.0f;
static const CGFloat kInnerPadding = 10.0f;

@implementation CardNode {
    ItemModel           *_model;
    ASNetworkImageNode  *_videoImgNode;
    ASTextNode          *_titleLab;
    ASTextNode          *_starLab;
    ASTextNode          *_publicTimeLab;
    ASTextNode          *_aliasLab;
    ASTextNode2          *_performerLab;
    ASTextNode          *_toStarLab;
    ASTextNode          *_videoDescribeLab;
    CGSize _imgSize;
}

- (instancetype)initWithObject:(ItemModel *)obj {
    if (self = [super init]) {
        _model = obj;
        
        _imgSize = CGSizeMake(self.frame.size.width, self.frame.size.width*9/16);
        _videoImgNode     = [[ASNetworkImageNode alloc] init];
        _videoImgNode.URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://placekitten.com/%zd/%zd",
                                                (NSInteger)roundl(_imgSize.width),
                                                (NSInteger)roundl(_imgSize.height)]];
        _videoImgNode.placeholderFadeDuration = .5;
        _videoImgNode.placeholderColor = ASDisplayNodeDefaultPlaceholderColor();
        
        _titleLab = [[ASTextNode alloc] init];
        _titleLab.attributedText = [[NSAttributedString alloc] initWithString:obj.title];
        
        _performerLab = [[ASTextNode2 alloc] init];
        _performerLab.layerBacked= YES;
        _performerLab.attributedText = [[NSAttributedString alloc] initWithString:obj.performer];
        _performerLab.maximumNumberOfLines = 2;
        
        _videoDescribeLab = [[ASTextNode alloc] init];
        _videoDescribeLab.maximumNumberOfLines =  2;
        _videoDescribeLab.truncationAttributedText = [[NSAttributedString alloc] initWithString:@"…"];
        _videoDescribeLab.additionalTruncationMessage = [[NSAttributedString alloc] initWithString:@"更多"];
        _videoDescribeLab.attributedText = [[NSAttributedString alloc] initWithString:obj.videoDescribe attributes:[self textStyle]];
        self.automaticallyManagesSubnodes = YES;
    }
    return self;
}

- (NSDictionary *)textStyle {
  UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
  NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  style.paragraphSpacing = 0.5 * font.lineHeight;
  style.hyphenationFactor = 1.0;
  
  return @{
    NSFontAttributeName: font,
    NSParagraphStyleAttributeName: style,
    NSForegroundColorAttributeName : [UIColor lightGrayColor],
    ASTextNodeWordKerningAttributeName : @.5
  };
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    CGFloat width = constrainedSize.max.width > 0 ? constrainedSize.max.width : [UIScreen mainScreen].bounds.size.width;
    _videoImgNode.style.preferredSize = CGSizeMake(width-2*10, width*9/16);
    _titleLab.style.flexShrink = YES;
    ASStackLayoutSpec *verTopStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch children:@[_videoImgNode]];
    //ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:verTopStackLayout];
    
    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[_videoDescribeLab]];
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:
            [ASOverlayLayoutSpec overlayLayoutSpecWithChild:verTopStackLayout  overlay:verStackLayout]];
}

@end
