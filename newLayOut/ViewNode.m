//
//  ViewNode.m
//  newLayOut
//
//  Created by hapii on 2020/9/9.
//  Copyright © 2020 hapii. All rights reserved.
//

#import "ViewNode.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import <YYKit.h>

static const CGFloat kImageSize = 80.0f;
static const CGFloat kOuterPadding = 16.0f;
static const CGFloat kInnerPadding = 10.0f;

@interface ViewNode ()

@end

@implementation ViewNode{
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
    BOOL _isImageEnlarged;
    BOOL _swappedTextAndImage;
}

- (instancetype)initWithObject:(ItemModel *)obj {
    if (self = [super init]) {
        _model = obj;
        
        _imgSize = CGSizeMake(50, 80);
        _videoImgNode     = [[ASNetworkImageNode alloc] init];
        _videoImgNode.URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://placekitten.com/%zd/%zd",
                                                (NSInteger)roundl(_imgSize.width),
                                                (NSInteger)roundl(_imgSize.height)]];
        _videoImgNode.placeholderFadeDuration = .5;
        _videoImgNode.placeholderColor = ASDisplayNodeDefaultPlaceholderColor();
        [_videoImgNode addTarget:self action:@selector(toggleNodesSwap) forControlEvents:ASControlNodeEventTouchUpInside];
        
        
        _titleLab = [[ASTextNode alloc] init];
        _titleLab.attributedText = [[NSAttributedString alloc] initWithString:obj.title];
        
        _performerLab = [[ASTextNode2 alloc] init];
        _performerLab.layerBacked= YES;
        _performerLab.attributedText = [[NSAttributedString alloc] initWithString:obj.performer];
        _performerLab.maximumNumberOfLines = 2;
        
        _videoDescribeLab = [[ASTextNode alloc] init];
        _videoDescribeLab.backgroundColor = [UIColor whiteColor];
        _videoDescribeLab.maximumNumberOfLines = _isImageEnlarged ? 0 : 2;
        _videoDescribeLab.truncationAttributedText = [[NSAttributedString alloc] initWithString:@"…"];
        _videoDescribeLab.additionalTruncationMessage = [[NSAttributedString alloc] initWithString:@"更多"];
        _videoDescribeLab.attributedText = [[NSAttributedString alloc] initWithString:obj.videoDescribe attributes:[self textStyle]];
        [_videoDescribeLab addTarget:self action:@selector(toggleImageEnlargement) forControlEvents:ASControlNodeEventTouchUpInside];
        self.automaticallyManagesSubnodes = YES;
    }
    return self;
}

- (void)toggleNodesSwap
{
  _swappedTextAndImage = !_swappedTextAndImage;
  
  [UIView animateWithDuration:0.15 animations:^{
    self.alpha = 0;
  } completion:^(BOOL finished) {
    [self setNeedsLayout];
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.15 animations:^{
      self.alpha = 1;
    }];
  }];
}

- (void)toggleImageEnlargement
{
  _isImageEnlarged = !_isImageEnlarged;
   
   [UIView animateWithDuration:0.15 animations:^{
       self.alpha = 0.5;
   } completion:^(BOOL finished) {
     [self setNeedsLayout];
     [self.view layoutIfNeeded];
     
     [UIView animateWithDuration:0.15 animations:^{
       self.alpha = 1;
     }];
   }];
}

- (NSDictionary *)textStyle {
  UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
  NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  style.paragraphSpacing = 0.5 * font.lineHeight;
  style.hyphenationFactor = 1.0;
  
  return @{
    NSFontAttributeName: font,
    NSParagraphStyleAttributeName: style,
    NSForegroundColorAttributeName : [UIColor redColor],
    ASTextNodeWordKerningAttributeName : @.5
  };
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    CGSize imageSize = _isImageEnlarged ? CGSizeMake(2.0 * kImageSize, 2.0 * kImageSize) : CGSizeMake(kImageSize, kImageSize);
    _videoDescribeLab.maximumNumberOfLines = _isImageEnlarged ? 0 : 2;
    _videoImgNode.style.preferredSize = imageSize;
   
    ASStackLayoutSpec *vLabStack = [ASStackLayoutSpec verticalStackLayoutSpec];
    vLabStack.spacing = kInnerPadding;
    vLabStack.children = @[_titleLab,_performerLab];
    vLabStack.style.flexShrink = 1.0f;
    _performerLab.style.flexShrink = 1.0;
    _titleLab.style.flexShrink = 1.0;
    _performerLab.style.flexGrow = 1.0;
     _titleLab.style.flexGrow = 1.0;
    
    ASStackLayoutSpec *hStack = [ASStackLayoutSpec horizontalStackLayoutSpec];
    hStack.spacing = kInnerPadding;
    hStack.justifyContent = ASStackLayoutJustifyContentStart;
    hStack.alignItems = ASStackLayoutAlignItemsStart;
    hStack.children = _swappedTextAndImage ? @[vLabStack,_videoImgNode] : @[_videoImgNode, vLabStack];
    
    ASStackLayoutSpec *vStack = [ASStackLayoutSpec verticalStackLayoutSpec];
    vStack.style.spacingBefore = 12.0f;
    [vStack setChildren:@[hStack, _videoDescribeLab]];
    
    // Configure stack
   return [ASInsetLayoutSpec
   insetLayoutSpecWithInsets:UIEdgeInsetsMake(kOuterPadding, kOuterPadding, kOuterPadding, kOuterPadding)
   child:vStack];
}

@end
