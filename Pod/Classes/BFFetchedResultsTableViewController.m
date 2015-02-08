//
//  FetchedResultsTableViewController.m
//  Enero
//
//  Created by Rob MacEachern on 2015-01-26.
//  Copyright (c) 2015 Blackfish Development. All rights reserved.
//

#import "BFFetchedResultsTableViewController.h"
#import "BFTableViewFetchedResultsControllerDelegate.h"

@interface BFFetchedResultsTableViewController ()

@property (nonatomic, strong) BFTableViewFetchedResultsControllerDelegate *fetchedResultsControllerDelegate;

@end

@implementation BFFetchedResultsTableViewController

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object {
    cell.textLabel.text = [object description];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fetchedResultsControllerDelegate = [[BFTableViewFetchedResultsControllerDelegate alloc] initWithTableView:self.tableView];
    BFFetchedResultsTableViewController * __weak weakSelf = self;
    self.fetchedResultsControllerDelegate.onUpdate = ^(UITableViewCell *cell, id object) {
        [weakSelf configureCell:cell withObject:object];
    };
    self.fetchedResultsController.delegate = self.fetchedResultsControllerDelegate;
    [self.fetchedResultsController performFetch:nil];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:object];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return sectionInfo.name;
}

@end
