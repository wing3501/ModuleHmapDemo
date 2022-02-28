//
//  MyPodAView.m
//  MyPodA
//
//  Created by styf on 2022/1/21.
//

#import "MyPodAView.h"
#import <OnlySwift/OnlySwift-Swift.h>
//#import <OCSwift/OCSView.h>
@import OCSwift.OCSView;
#import <OCSwift/OCSwift-Swift.h>

@implementation MyPodAView

- (instancetype)init {
    self = [super init];
    if (self) {
        //OC库中引用swift库和swiftOC混编库
        OSObject *o = [OSObject new];
        OCSView *v = [OCSView new];
        OCSPerson *p = [OCSPerson new];
    }
    return self;
}

@end
