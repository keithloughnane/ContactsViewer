//
//  RootViewController.h
//  ContactsView
//
//  Created by keith.loughnane on 02/05/2011.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    
    ABAddressBookRef lAddressBook;
    CFArrayRef lRawAddressBookEntries;
    NSMutableDictionary *sCustomAddressBookPersonRefs;
    CFIndex lTotalContactsCount;
    
}
-(BOOL)setUpContacts;


@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) ABAddressBookRef lAddressBook;
@property (nonatomic) CFArrayRef lRawAddressBookEntries;
@property (nonatomic, retain) NSMutableDictionary *sCustomAddressBookPersonRefs;
@property (nonatomic) CFIndex lTotalContactsCount;

@end
