//
//  MyPodCView.m
//  MyPodC
//
//  Created by styf on 2022/1/21.
//

#import "MyPodCView.h"
//#import "SDImageCache.h"
#import <SDWebImage/SDImageCache.h>
@implementation MyPodCView

- (instancetype)init
{
    self = [super init];
    if (self) {
        SDImageCache*a = [[SDImageCache alloc]init];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
