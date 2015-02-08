//
//  TableViewFetchedResultsControllerDelegate.m
//  Enero
//
//  Created by Rob MacEachern on 2015-01-26.
//  Copyright (c) 2015 Blackfish Development. All rights reserved.
//
//  Ported from work by Alek Åström https://github.com/MrAlek
//  https://github.com/MrAlek/Swift-NSFetchedResultsController-Trickery/blob/master/CoreDataTrickerySwift/FetchControllerDelegate.swift

#import "BFTableViewFetchedResultsControllerDelegate.h"

@interface BFTableViewFetchedResultsControllerDelegate ()

@property (nonatomic, strong) NSMutableArray *sectionsBeingAdded;
@property (nonatomic, strong) NSMutableArray *sectionsBeingRemoved;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BFTableViewFetchedResultsControllerDelegate

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self.tableView = tableView;
    }
    return self;
}

#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (self.ignoreNextUpdates) {
        return;
    }
    self.sectionsBeingAdded = [NSMutableArray new];
    self.sectionsBeingRemoved = [NSMutableArray new];
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    if (self.ignoreNextUpdates) {
        return;
    }
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.sectionsBeingAdded addObject:[NSNumber numberWithInteger:sectionIndex]];
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.sectionsBeingRemoved addObject:[NSNumber numberWithInteger:sectionIndex]];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    if (self.ignoreNextUpdates) {
        return;
    }
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            if (self.onUpdate) {
                self.onUpdate([self.tableView cellForRowAtIndexPath:indexPath], anObject);
            }
            break;
        case NSFetchedResultsChangeMove:
            // Stupid and ugly, rdar://17684030
            if (![self.sectionsBeingAdded containsObject:[NSNumber numberWithInteger:newIndexPath.section]] &&
                ![self.sectionsBeingRemoved containsObject:[NSNumber numberWithInteger:indexPath.section]]) {
                [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
                if (self.onUpdate) {
                    self.onUpdate([self.tableView cellForRowAtIndexPath:indexPath], anObject);
                }
            } else {
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
    }
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (self.ignoreNextUpdates) {
        self.ignoreNextUpdates = false;
    } else {
        [self.tableView endUpdates];
    }
}

@end
