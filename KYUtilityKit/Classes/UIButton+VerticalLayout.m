//
//  UIButton+VerticalLayout.m
//  iMarkDemo
//
//  Created by Kitten x iDaily on 17/3/23.
//  Copyright © 2017年 KittenYang. All rights reserved.
//

#import "UIButton+VerticalLayout.h"

@implementation UIButton (VerticalLayout)

- (void)centerVerticallyWithPadding:(float)padding {

    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = self.imageView.image.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + padding), 0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + padding), 0.0, 0.0, - titleSize.width);
    
    // increase the content height to avoid clipping
    CGFloat edgeOffset = fabs(titleSize.height - imageSize.height) / 2.0;
    self.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0);
}

- (void)centerVertically {
    const CGFloat kDefaultPadding = 6.0f;    
    [self centerVerticallyWithPadding:kDefaultPadding];
}  


@end
