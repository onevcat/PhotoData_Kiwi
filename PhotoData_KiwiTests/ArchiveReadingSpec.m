//
//  ArchiveReadingSpec.m
//  PhotoData_Kiwi
//
//  Created by 王 巍 on 14-5-6.
//  Copyright 2014年 OneV's Den. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "Store.h"
#import "Photo.h"
#import "User.h"

SPEC_BEGIN(ArchiveReadingSpec)

describe(@"ArchiveReading", ^{
    context(@"when store creating", ^{
        Store *store = [Store store];
        it(@"should not be nill", ^{
            [[store shouldNot] beNil];
            [[store.photos shouldNot] beNil];
            [[store.users shouldNot] beNil];
        });
    });
    
    context(@"the photos in store", ^{
        Store* store = [Store store];
        it(@"should have an id and user for each", ^{
            for (Photo *photo in store.photos) {
                [[theValue(photo.identifier) shouldNot] equal:theValue(0)];
                [[photo.user shouldNot] beNil];
            }
        });
        
        it(@"should have at least one phone with name", ^{
            NSInteger count = [[store.photos filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Photo *photo, NSDictionary *bindings) {
                return (0 < [photo.name length]);
            }]] count];
            [[theValue(count) should] beGreaterThan:theValue(0)];
        });
    });
    
    context(@"the users in store", ^{
        Store *store = [Store store];
        it(@"should have id, name and at least 1 photo for each", ^{
            for (User *user in store.users) {
                [[theValue(user.identifier) shouldNot] equal:theValue(0)];
                [[theValue([user.username length]) should] beGreaterThan:theValue(0)];
                [[theValue([user.photos count]) should] beGreaterThan:theValue(0)];
            }
        });
        
        it(@"should at least 1 having a first name", ^{
            NSInteger count = [[store.users filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(User *user, NSDictionary *bindings) {
                return (0 < [user.firstName length]);
            }]] count];
            [[theValue(count) should] beGreaterThan:theValue(0)];
        });
        
        it(@"should at least 1 having a last name", ^{
            NSInteger count = [[store.users filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(User *user, NSDictionary *bindings) {
                return (0 < [user.lastName length]);
            }]] count];
            [[theValue(count) should] beGreaterThan:theValue(0)];
        });
    });
});



SPEC_END
