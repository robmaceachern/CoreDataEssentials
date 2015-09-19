//
//  FetchedResultsTableViewController.h
//  Enero
//
//  Created by Rob MacEachern on 2015-01-26.
//  Copyright (c) 2015 Blackfish Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@protocol BFFetchedResultsViewControllerDatasource <NSObject>

@required
- (NSFetchedResultsController *)fetchedResultsControllerForViewController:(UIViewController *)viewController;

@end

@interface BFFetchedResultsTableViewController : UITableViewController <BFFetchedResultsViewControllerDatasource>

@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, assign) id <BFFetchedResultsViewControllerDatasource> dataSource;

// Override this method to configure the cell with the object from the fetchedResultsController
- (void)configureCell:(UITableViewCell *)cell withObject:(id)object;

@end
