//
//  PhotosViewControllerSpec.m
//  PhotoData_Kiwi
//
//  Created by 王 巍 on 14-5-6.
//  Copyright 2014年 OneV's Den. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "PhotosViewController.h"
#import "PhotoViewController.h"
#import "Photo.h"

SPEC_BEGIN(PhotosViewControllerSpec)

describe(@"PhotosViewController", ^{
    context(@"when click a cell in table view", ^{
        it(@"A PhotoViewController should be pushed", ^{

            PhotosViewController *photosViewController = [[PhotosViewController alloc] init];
            UIView *view = photosViewController.view;
            [[view shouldNot] beNil];
            
            UINavigationController *mockNavController = [UINavigationController mock];
            [photosViewController stub:@selector(navigationController) andReturn:mockNavController];

            [[mockNavController should] receive:@selector(pushViewController:animated:)];
            KWCaptureSpy *spy = [mockNavController captureArgument:@selector(pushViewController:animated:) atIndex:0];
            [photosViewController tableView:photosViewController.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            id obj = spy.argument;
            PhotoViewController *vc = obj;
            [[vc should] beKindOfClass:[PhotoViewController class]];
            [[vc.photo shouldNot] beNil];
        });

        
    });
});

SPEC_END
