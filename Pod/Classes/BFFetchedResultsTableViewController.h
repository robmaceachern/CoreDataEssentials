//
//  FetchedResultsTableViewController.h
//  Enero
//
//  Created by Rob MacEachern on 2015-01-26.
//  Copyright (c) 2015 Blackfish Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface BFFetchedResultsTableViewController : UITableViewController

// Override this method to configure the cell with the object from the fetchedResultsController
- (void)configureCell:(UITableViewCell *)cell withObject:(id)object;

@end
