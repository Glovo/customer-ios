//
//  KUSImage.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/4/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSImage.h"

@implementation KUSImage

#pragma mark - UIImage methods

+ (UIImage *)imageNamed:(NSString *)name
{
    NSBundle *kustomerBundle = [NSBundle bundleForClass:[self class]];
    UIImage *image = [UIImage imageNamed:name inBundle:kustomerBundle compatibleWithTraitCollection:nil];
    if (image) {
        return image;
    }
    return [UIImage imageNamed:name];
}

#pragma mark - Public methods

+ (UIImage *)kustomerTeamIcon
{
    return [self imageNamed:@"kustomer_team_icon"];
}

+ (UIImage *)kustyImage
{
    return [self imageNamed:@"kusty"];
}

+ (UIImage *)sendArrowImage
{
    return [self imageNamed:@"up_arrow"];
}

+ (UIImage *)pencilImage
{
    return [self imageNamed:@"pencil_image"];
}

+ (UIImage *)sendImageWithSize:(CGSize)size color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillEllipseInRect(context, (CGRect) { .size = size });
    CGSize arrowSize = CGSizeMake(ceil(size.width * 0.45), ceil(size.height * 0.45));
    [[self sendArrowImage] drawInRect:(CGRect) {
        .origin.x = (size.width - arrowSize.width) / 2.0,
        .origin.y = (size.height - arrowSize.height) / 2.0,
        .size = arrowSize
    }];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)circularImageWithSize:(CGSize)size color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillEllipseInRect(context, (CGRect) { .size = size });
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)defaultAvatarImageForName:(NSString *)name
{
    NSString *firstLetter = @"*";
    if (name.length > 0) {
        firstLetter = [[name substringToIndex:1] uppercaseString];
    }
    NSUInteger letterHash = [firstLetter hash];
    NSUInteger colorIndex = letterHash % [self _defaultNameColors].count;
    UIColor *color = [self _defaultNameColors][colorIndex];

    CGRect imageRect = CGRectMake(0.0, 0.0, 40.0, 40.0);
    CGRect boundingRect = [firstLetter boundingRectWithSize:imageRect.size
                                                    options:kNilOptions
                                                 attributes:[self _defaultAvatarTextAttributes]
                                                    context:nil];

    UIGraphicsBeginImageContextWithOptions(imageRect.size, YES, 0.0);
    [color setFill];
    UIRectFill(imageRect);

    CGPoint drawPoint = (CGPoint) {
        .x = (imageRect.size.width - boundingRect.size.width) / 2.0,
        .y = (imageRect.size.height - boundingRect.size.height) / 2.0
    };
    [firstLetter drawAtPoint:drawPoint withAttributes:[self _defaultAvatarTextAttributes]];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Internal methods

+ (NSDictionary<NSString *, id> *)_defaultAvatarTextAttributes
{
    return @{
        NSFontAttributeName: [UIFont systemFontOfSize:14.0],
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };
}

+ (NSArray<UIColor *> *)_defaultNameColors
{
    // https://github.com/Sitebase/react-avatar/blob/0f790acb720502cb26f572dca58a6e67557d71b3/lib/utils.js#L53
    // For parity with the kustomer web ui
    static NSArray<UIColor *> *_defaultNameColors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultNameColors = @[
            [UIColor colorWithRed:215.0/255.0 green:61.0/255.0 blue:50.0/255.0 alpha:1.0],
            [UIColor colorWithRed:126.0/255.0 green:55.0/255.0 blue:148.0/255.0 alpha:1.0],
            [UIColor colorWithRed:66.0/255.0 green:133.0/255.0 blue:244.0/255.0 alpha:1.0],
            [UIColor colorWithRed:103.0/255.0 green:174.0/255.0 blue:63.0/255.0 alpha:1.0],
            [UIColor colorWithRed:214.0/255.0 green:26.0/255.0 blue:127.0/255.0 alpha:1.0],
            [UIColor colorWithRed:255.0/255.0 green:64.0/255.0 blue:128.0/255.0 alpha:1.0],
        ];
    });
    return _defaultNameColors;
}

@end
