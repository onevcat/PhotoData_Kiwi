//
//  PhotoCellSpec.m
//  PhotoData_Kiwi
//
//  Created by 王 巍 on 14-5-6.
//  Copyright 2014年 OneV's Den. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "PhotoCell.h"

SPEC_BEGIN(PhotoCellSpec)

describe(@"PhotoCell", ^{
    context(@"when nib load", ^{
        UINib *nib = [PhotoCell nib];
        it(@"should not be nil", ^{
            [[nib shouldNot] beNil];
        });
        
        NSArray *a = [nib instantiateWithOwner:nil options:0];
        it(@"should contains one instance", ^{
            [[a should] haveCountOf:1];
        });
        
        PhotoCell *cell = a[0];
        it(@"should be the class of PhotoCell", ^{
            [[cell should] beKindOfClass:[PhotoCell class]];
        });
        
        it(@"should have non nil label", ^{
            [[cell.photoTitleLabel shouldNot] beNil];
            [[cell.photoDateLabel shouldNot] beNil];
        });
    });
});

SPEC_END
