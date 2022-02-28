//
//  OCSView.m
//  OCSwift
//
//  Created by styf on 2022/1/21.
//

#import "OCSView.h"
#import <OCSwift/OCSwift-Swift.h>
@implementation OCSView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //混编库中 OC调用swift
        OCSPerson *p = [OCSPerson new];
        [p run:11];
    }
    return self;
}

@end
