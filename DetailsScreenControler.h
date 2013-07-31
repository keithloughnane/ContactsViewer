//
//  DetailsScreenControler.h
//  ContactsView
//
//  Created by keith.loughnane on 06/05/2011.
//  Copyright 2011 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface DetailsScreenControler :  UIViewController {
    
    NSMutableArray *list;
    
    
    ABAddressBookRef lAddressBook;
    CFArrayRef lRawAddressBookEntries;
    NSMutableDictionary *sCustomAddressBookPersonRefs;
    CFIndex lTotalContactsCount;
    
    NSString* name;
    NSString* lastName;
    NSString* company;
    NSString* iPhone;
    ABMultiValueRef* phone;
    NSString* phoneV;
    NSString* phoneI;
    
    NSString* strAddress;
    
    NSString* homepage;
    NSDictionary* address;
    
    ABRecordRef lRef;
    
    
    
    UILabel *label;
    UIButton *button;
    IBOutlet UITextField *nameField;
    IBOutlet UITextField *lastNameField;
    IBOutlet UITextField *companyField;
    IBOutlet UITextField *iPhoneField;
    IBOutlet UITextField *phoneField;
    IBOutlet UITextField *homepageField;
    IBOutlet UITextField *addressField;
    
    
}
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, retain) UITextField *lastNameField;
@property (nonatomic, retain) UITextField *companyField;
@property (nonatomic, retain) UITextField *iPhoneField;
@property (nonatomic, retain) UITextField *phoneField;
@property (nonatomic, retain) UITextField *homepageField;
@property (nonatomic, retain) UITextField *addressField;

- (IBAction)updateText;
- (IBAction)saveDetails;


- (void) setThingsUp:(int)ContactNum;
- (void) SetUpText;
- (IBAction)textFieldReturn:(id)sender;
@end
