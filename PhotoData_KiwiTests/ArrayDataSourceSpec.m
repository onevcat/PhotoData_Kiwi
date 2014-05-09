//
//  ArrayDataSourceSpec.m
//  PhotoData_Kiwi
//
//  Created by 王 巍 on 14-5-6.
//  Copyright 2014年 OneV's Den. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ArrayDataSource.h"

SPEC_BEGIN(ArrayDataSourceSpec)

describe(@"ArrayDataSource", ^{
    context(@"Initializing", ^{
        it(@"should not be allowed using init", ^{
            [[[[ArrayDataSource alloc] init] should] beNil];
        });
    });
    
    context(@"Configuration", ^{
        __block UITableViewCell *configuredCell = nil;
        __block id configuredObject = nil;
        
        TableViewCellConfigureBlock block = ^(UITableViewCell *a, id b){
            configuredCell = a;
            configuredObject = b;
        };
        ArrayDataSource *dataSource = [[ArrayDataSource alloc] initWithItems:@[@"a", @"b"] cellIdentifier:@"foo" configureCellBlock:block];
        
        id mockTableView = [UITableView mock];
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        __block id result = nil;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        it(@"should receive cell request", ^{
            [[mockTableView should] receive:@selector(dequeueReusableCellWithIdentifier:forIndexPath:) andReturn:cell withArguments:@"foo",indexPath];
            result = [dataSource tableView:mockTableView cellForRowAtIndexPath:indexPath];
        });
        
        it(@"should return the dummy cell", ^{
            [[result should] equal:cell];
        });
        
        it(@"should have benn passed to the block", ^{
            [[configuredCell should] equal:cell];
        });
        
        it(@"should have the same configured object", ^{
            [[configuredObject should] equal:@"a"];
        });
    });
    
    context(@"number of rows", ^{
        id mockTableView = [UITableView mock];
        ArrayDataSource *dataSource = [[ArrayDataSource alloc] initWithItems:@[@"a", @"b"] cellIdentifier:@"foo" configureCellBlock:nil];
        
        it(@"should be 2 items", ^{
            NSInteger count = [dataSource tableView:mockTableView numberOfRowsInSection:0];
            [[theValue(count) should] equal:theValue(2)];
        });
    });
});

SPEC_END
