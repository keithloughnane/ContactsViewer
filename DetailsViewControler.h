//
//  DetailsViewControler.h
//  ContactsView
//
//  Created by keith.loughnane on 03/05/2011.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
//#import <UITableView.h>


@interface DetailsViewControler : UITableViewController {
    NSMutableArray *list;
    
    ABAddressBookRef lAddressBook;
    
    
    CFArrayRef lRawAddressBookEntries;
    
    NSMutableDictionary *sCustomAddressBookPersonRefs;
    
    
    
    CFIndex lTotalContactsCount;
}

-(BOOL)setUpContacts;

@property (nonatomic, copy, readwrite) NSMutableArray *list;
@end
