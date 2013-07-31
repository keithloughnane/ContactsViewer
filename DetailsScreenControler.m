//
//  DetailsScreenControler.m
//  ContactsView
//
//  Created by keith.loughnane on 06/05/2011.
//  Copyright 2011 none. All rights reserved.
//

#import "DetailsScreenControler.h"



@implementation DetailsScreenControler

@synthesize label;
@synthesize button;
@synthesize nameField;
@synthesize lastNameField;
@synthesize companyField;
@synthesize iPhoneField;
@synthesize phoneField;
@synthesize addressField;
@synthesize homepageField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"Started initWithNib");
   
    
   // [label setText:@"test"];

    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    //textField.text = @"Text";
    //[textField setText:@"test"];
    
    
     
    NSLog(@"Finished initWithNib return");
    
    return self;
    
    
    
    
    
    
    

}

- (void)setContact:(int)ContactNum;
{
    
   // contactName = name;
    [self setThingsUp:ContactNum];
    
}

- (IBAction)updateText
{

   // textField.text = @"Text";
   // textField.text = @"Text";
    
    //[textField setText:@"test"];
    
    
    
    //[lAddressBook removeRecord:
    ABAddressBookRemoveRecord(lAddressBook, lRef, nil);
   // ABAddressBook
    
    ABAddressBookSave(lAddressBook, nil);
    
    
    //lAddressBook.ABAddressBookRemove
    //[lAddressBook save];
}
- (IBAction)saveDetails
{
    
    NSLog(@"Saving details");
    //Name
    
    
    //Phone
    
    //Get phone numbers
    ABMultiValueRef multiPhones = ABRecordCopyValue(lRef,
                                                    kABPersonPhoneProperty);
    
    //Create mutable list to be able to modify numbers
    ABMutableMultiValueRef multiPhonesList =
    ABMultiValueCreateMutableCopy(multiPhones);
    
    //Number of phone numbers
   // NSInteger count = (NSInteger)ABMultiValueGetCount(multiPhones);
    //for (int j = 0; j < count; j++) {
        
        //Replace old number with new number
        BOOL replace = ABMultiValueReplaceValueAtIndex
        (multiPhonesList,phoneField.text,0);
        if (!replace) {
            NSLog(@"Error Replacing");
        }
        
        //Replace old multivalue with new multivalue
        BOOL setValue = ABRecordSetValue(lRef,
                                         kABPersonPhoneProperty,multiPhonesList, nil);
        if (!setValue) {
            NSLog(@"Error setting value");
        }
    
    ABRecordSetValue(lRef,kABPersonFirstNameProperty, nameField.text, nil);
       ABRecordSetValue(lRef,kABPersonLastNameProperty, lastNameField.text, nil);
       ABRecordSetValue(lRef,kABPersonOrganizationProperty, companyField.text, nil);
       ABRecordSetValue(lRef,kABPersonFirstNameProperty, nameField.text, nil);
        
    
    


    
    //Web
    
    ABMutableMultiValueRef urlMultiValue = 
    ABMultiValueCreateMutable(kABStringPropertyType);
    if([homepageField.text length] >1)
    {
    ABMultiValueAddValueAndLabel(urlMultiValue, homepageField.text,
                                 kABPersonHomePageLabel, NULL);
    
    
    ABRecordSetValue(lRef, kABPersonURLProperty, urlMultiValue,nil);
    }
    
    
    
    //Address
    
    
    ABMutableMultiValueRef multiAddress = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
    
	//Create a Disctionary Array to hold the address
	NSMutableDictionary *addressDictionary = [[NSMutableDictionary alloc] init];
    
	[addressDictionary setObject:@"Test address" forKey:(NSString *)kABPersonAddressStreetKey];
	//if (venue.city) [addressDictionary setObject:venue.city forKey:(NSString *)//kABPersonAddressCityKey];
	//if (venue.state) [addressDictionary setObject:venue.state forKey:(NSString *)kABPersonAddressStateKey];
	//if (venue.zip) [addressDictionary setObject:venue.zip forKey:(NSString *)kABPersonAddressZIPKey];
	ABMultiValueAddValueAndLabel(multiAddress, addressDictionary, kABWorkLabel, NULL);
	ABRecordSetValue(lRef, kABPersonAddressProperty, multiAddress,nil);
	CFRelease(multiAddress);
    
    
    
    
    
    
    //Save addressbook
    BOOL save = ABAddressBookSave(lAddressBook, nil);
    if (!save) {
        NSLog(@"Save error");
    }
    
}

- (IBAction)updateLabel1
{
    
    
    
    [nameField resignFirstResponder];
    NSLog(@"updateLabel1");
}

- (IBAction)textFieldReturn:(id)sender
{
    
    [sender resignFirstResponder];
}

- (void) setThingsUp:(int)ContactNum
{
    
    NSLog(@"Setting up for ID = ",ContactNum);
    
    lAddressBook = ABAddressBookCreate();
    
    lRawAddressBookEntries = ABAddressBookCopyArrayOfAllPeople(lAddressBook);
    sCustomAddressBookPersonRefs = [[NSMutableDictionary alloc] initWithCapacity:1000];
    lTotalContactsCount = ABAddressBookGetPersonCount(lAddressBook);
    
    /*******************************************************/
    //lRef = CFArrayGetValueAtIndex(lRawAddressBookEntries, ContactNum);
    lRef = ABAddressBookGetPersonWithRecordID(lAddressBook, ContactNum);
    
    
    
    name = (NSString *)ABRecordCopyValue(lRef,kABPersonFirstNameProperty);
        lastName = (NSString *)ABRecordCopyValue(lRef,kABPersonLastNameProperty);
        company = (NSString *)ABRecordCopyValue(lRef,kABPersonOrganizationProperty);
        //iPhone = (NSString *)ABRecordCopyValue(lRef,kABPersonPhoneIPhoneLabel);
    iPhone = @"123456";
    ABMultiValueRef temp = (NSString *)ABRecordCopyValue(lRef,kABPersonURLProperty);
    
    
   NSLog(@"Temp is %d",  ABMultiValueGetCount(  temp) );
    if(ABMultiValueGetCount(  temp) != 0)
    {
    homepage = ABMultiValueCopyValueAtIndex(temp, 0);//[NSString stringWithFormat:@"%@",temp];
    }
     
     /* Example code
     ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
     CFStringRef email = ABMultiValueCopyValueAtIndex(emails, <INDEX>);
     NSLog( (NSString *) email);
      */
    
    NSLog(@"homepage = \n%@",homepage);
    
   //ABMultiValueRef
    
    
        phone = ABRecordCopyValue(lRef,kABPersonPhoneProperty);
    
int tempPhoneCount =  ABMultiValueGetCount(phone);
    if(tempPhoneCount > 0)
    phoneV =  (NSString *)ABMultiValueCopyValueAtIndex(phone, 0);
   
        if(tempPhoneCount > 1)
    phoneI =  (NSString *)ABMultiValueCopyValueAtIndex(phone, 1);
    
    //NSDictionary 
    
    
        ABMultiValueRef multi = ABRecordCopyValue(lRef,kABPersonAddressProperty);
    NSLog(@"The Multi = %@", multi);
    NSArray *theArray  = [(id)ABMultiValueCopyArrayOfAllValues(multi) autorelease];
      NSLog(@"The Array = %@", theArray);                    
            const NSUInteger theIndex = ABMultiValueGetIndexForIdentifier(multi, ContactNum);
    NSLog(@"The theIndex = %d",theIndex);
      NSDictionary *theDict = [theArray objectAtIndex:theIndex];
    NSLog(@"The Dict = %@", theDict);
    
    
    
     const NSUInteger theCount = [theDict count];
   // NSLog(@"The Count = %d", theCount);
    NSString *keys[theCount];
   // NSLog(@"The keys = %@", keys);
    NSString *values[theCount];
   // NSLog(@"The Values = %@", values);
    [theDict getObjects:values andKeys:keys];
    NSLog(@"The Dict 2 = %@", theDict);
        //name = (NSString *)ABRecordCopyValue(lRef,kABPersonFirstNameProperty);
    
    
   /* strAddress = [NSString stringWithFormat:@"%@, %@, %@, %@ %@",
               [address objectForKey:(NSString *)kABPersonAddressStreetKey],
               [address objectForKey:(NSString *)kABPersonAddressCityKey],
               [address objectForKey:(NSString *)kABPersonAddressStateKey],
               [address objectForKey:(NSString *)kABPersonAddressZIPKey],
               [address objectForKey:(NSString *)kABPersonAddressCountryKey]]; */
    
    
    
    /*
     City 
     Springfield;
     Country 
     "United States";
     CountryCode 
     us;
     State 
     unknown;
     Street 
     "527\nEvergreen Trc";
     ZIP 
     5555;
     */
    
    
    
    strAddress = [NSString stringWithFormat:@"%@",theDict];
    
    //TODO STRIP OUT WEIRD CHARICTORS
    
    strAddress = [strAddress stringByReplacingOccurrencesOfString:@"="
                                         withString:@"\n"];
    
    strAddress = [strAddress stringByReplacingOccurrencesOfString:@"City"
                                                       withString:@"\n"];
    
    strAddress = [strAddress stringByReplacingOccurrencesOfString:@"State"
                                                       withString:@"\n"];
    
    strAddress = [strAddress stringByReplacingOccurrencesOfString:@"Street"
                                                       withString:@"\n"];
    
    strAddress = [strAddress stringByReplacingOccurrencesOfString:@"ZIP"
                                                       withString:@"\n"];
    
    strAddress = [strAddress stringByReplacingOccurrencesOfString:@"\""
                                                       withString:@" "];
    
    strAddress = [strAddress stringByReplacingOccurrencesOfString:@"{"
                                                       withString:@" "];
    
    strAddress = [strAddress stringByReplacingOccurrencesOfString:@"}"
                                                       withString:@"\n"];
    
    //RESEARCH SAVING FROM TEXT FIELDS
    
    //IMPLEMENT
    

    
    
    // self.firstName.text = name;
    NSLog(@"it inited");
    NSLog(@"In DetailsView >> %@,%@,%@,%@,%@,%@,%@",name,lastName,company,iPhone,phone,address,strAddress);
    
    
    
    NSLog(@"Update text called");
    //label.text = @"test";
    //[label setText:@"test"];
    /*
    nameField.text = name;
    lastNameField.text = @"Text";
    companyField.text = @"Text";
    addressField.text = @"Text";
    homepageField.text = @"Text";
    iPhoneField.text = @"123456";
    phoneField.text = @"789101112";
     */
    
}

- (void) SetUpText
{
nameField.text = name;
    lastNameField.text = lastName;
    companyField.text = company;
    iPhoneField.text = phoneI;
    phoneField.text = phoneV;
   addressField.text = strAddress;
    homepageField.text = (NSString*)homepage;
}




- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
     //[self setThingsUp];
    [self SetUpText];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
   
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
