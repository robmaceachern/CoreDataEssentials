//
//  TableViewFetchedResultsControllerDelegate.h
//  Enero
//
//  Created by Rob MacEachern on 2015-01-26.
//  Copyright (c) 2015 Blackfish Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface BFTableViewFetchedResultsControllerDelegate : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, copy) void (^onUpdate)(UITableViewCell *cell, id object);
@property (nonatomic) BOOL ignoreNextUpdates;

- (instancetype)initWithTableView:(UITableView *)tableView;

@end
