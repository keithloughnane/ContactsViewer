//
//  RootViewController.m
//  ContactsView
//
//  Created by keith.loughnane on 02/05/2011.
//  Copyright 2011 none. All rights reserved.
//

#import "RootViewController.h"
#import "DetailsScreenControler.h"
//#import "DetailsViewControler.xib"
//#import "NSMutableDictionary.h"

@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RootViewController

@synthesize fetchedResultsController=__fetchedResultsController;

@synthesize managedObjectContext=__managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set up the edit and add buttons.
    //self.navigationItem.leftBarButtonItem = 
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = backButton;
    
    
    [self setUpContacts];
    [addButton release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (BOOL)setUpContacts{
    
    NSLog(@"Setting up contacts");
    lAddressBook = ABAddressBookCreate();
    
    lRawAddressBookEntries = ABAddressBookCopyArrayOfAllPeople(lAddressBook);
    sCustomAddressBookPersonRefs = [[NSMutableDictionary alloc] initWithCapacity:1000];
    lTotalContactsCount = ABAddressBookGetPersonCount(lAddressBook);
    
    /*******************************************************/
    // ABRecordRef lRef = CFArrayGetValueAtIndex(lRawAddressBookEntries, 0);
    
    
    
    // NSString* name = (NSString *)ABRecordCopyValue(lRef,
    // kABPersonFirstNameProperty);
    // self.firstName.text = name;
    
    // NSLog(name);
    //[name release];
    // name = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    //self.lastName.text = name;
    // [name release];
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}




// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailsScreenControler *detailsScreenControler = [[DetailsScreenControler alloc] initWithNibName:@"DetailsScreenControler" bundle:nil];
    NSString *tableText = [tableView cellForRowAtIndexPath:indexPath].text;
    NSArray *names = ABAddressBookCopyPeopleWithName(lAddressBook, tableText);
    [detailsScreenControler setContact:ABRecordGetRecordID([names objectAtIndex:0])];
    
    
    // ...
    // Pass the selected object to the new view controller.
    //[detailsScreenControler init];
    
    [self.navigationController pushViewController:detailsScreenControler animated:YES];
    
    
    
    [detailsScreenControler release];
	
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [__fetchedResultsController release];
    [__managedObjectContext release];
    [super dealloc];
}
- (void)bigButton
{
    [self newEntry];
}
- (void)newEntry
{
    
    
    
}
- (void)back
{
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Configure Cell recieved %@ as NSIndexPath paramenter",indexPath);
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // cell.textLabel.text = @"Hello";
    
    
    /*********************************/
    
    NSLog(@"Address book count %d",CFArrayGetCount(lRawAddressBookEntries));
    if (CFArrayGetCount(lRawAddressBookEntries) < 1) {
        return;
    }
    ABRecordRef lRef = CFArrayGetValueAtIndex(lRawAddressBookEntries, indexPath.row
                                              );
    
   // NSLog(@"lRef = %@",lRef);
    
    /*if(lRef == NULL)
        return;*/
    
    // NSString *tRec = ABRecordCopyCompositeName(lRef);
    
    
    
    /*  if ([tRec rangeOfString:@"null"].location == NSNotFound) {
     NSLog(@"string does not contain bla");
     */
    
    
    // NSString
    
    // [tRec 
    
    // NSLog(@"lRef = %@",tRec);
    if(!(lRef == NULL || lRef ==0 ||lRef == Nil))
    {
        CFStringRef name;
        // NSLog(@"lRef = %@",lRef);
        //NSLog(@"Made it here %@",lRef);
        NSString * tRec = ABRecordCopyCompositeName(lRef);
        NSString * nullLooksLike = @"null";
        NSRange textRange;
        textRange = [tRec rangeOfString:nullLooksLike];
        if (textRange.location != NSNotFound) {
         NSLog(@"lRefContains null = %@",tRec);
            
            return;
        }
        
        
        
        
        name = ABRecordCopyValue(lRef,kABPersonFirstNameProperty);
        
        
        
        // self.firstName.text = name;
        
        cell.textLabel.text = name;
        
        NSLog(name);
        [name release];
    }


// else 
//{
// NSLog(@"NULL NULL NULL");
//}


//[[managedObject valueForKey:@"timeStamp"] description];
}


- (void)insertNewObject
{
    
    ABRecordRef newPerson = ABPersonCreate();
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, @"New Person", nil);
    ABAddressBookAddRecord(lAddressBook, newPerson, nil);
    
    ABAddressBookSave(lAddressBook, nil);
    
    
    DetailsScreenControler *detailsScreenControler = [[DetailsScreenControler alloc] initWithNibName:@"DetailsScreenControler" bundle:nil];
    
    [detailsScreenControler setContact:ABRecordGetRecordID(newPerson)];
    
    
    // ...
    // Pass the selected object to the new view controller.
    //[detailsScreenControler init];
    
    [self.navigationController pushViewController:detailsScreenControler animated:YES];
    
    
    
    [detailsScreenControler release];
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName: [entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    [self.tableView beginUpdates];
    // Save the context.
    NSError *error = nil;
    if (![context save:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil)
    {
        return __fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
    {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

#pragma mark - Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
            
        case NSFetchedResultsChangeInsert:
            
            
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            
            
            
            
            
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

@end
