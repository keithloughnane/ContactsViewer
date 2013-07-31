//
//  DetailsViewControler.m
//  ContactsView
//
//  Created by keith.loughnane on 03/05/2011.
//  Copyright 2011 none. All rights reserved.
//

#import "DetailsViewControler.h"


@implementation DetailsViewControler

- (id)initWithStyle:(UITableViewStyle)style
{
        NSLog(@"DetailsView beganInit");
    self = [super initWithStyle:style];
    if (self) {
        
        NSMutableArray *localList = [[NSMutableArray alloc]init];
        self.list = localList;
        [localList release];
        
        
        
        // Custom initialization
    }
    return self;
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
    NSLog(@"DetailsView didLoad");
    
    self.title = @"Contact Details";
        [self setUpContacts];
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (BOOL)setUpContacts{
    lAddressBook = ABAddressBookCreate();
    
    lRawAddressBookEntries = ABAddressBookCopyArrayOfAllPeople(lAddressBook);
    sCustomAddressBookPersonRefs = [[NSMutableDictionary alloc] initWithCapacity:1000];
    lTotalContactsCount = ABAddressBookGetPersonCount(lAddressBook);
    
    /*******************************************************/
    ABRecordRef lRef = CFArrayGetValueAtIndex(lRawAddressBookEntries, 0);
    
    
    
    NSString* name = (NSString *)ABRecordCopyValue(lRef,
                                                   kABPersonFirstNameProperty);
    // self.firstName.text = name;
    
    NSLog(@"In DetailsView >> %@",name);
   // [name release];
    // name = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    //self.lastName.text = name;
    // [name release];
    [self dismissModalViewControllerAnimated:YES];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"chuck"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"chuck"] autorelease];
    }
    
    UITableViewCell *cell2 = [self.tableView dequeueReusableCellWithIdentifier:@"chuck2"];
    if (cell2 == nil) {
        cell2 = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"chuck2"] autorelease];
    }
    //cell.
   // cell.textLabel.alpha = 0.0;
    
    cell2.textLabel.text = name;
    cell.textLabel.text = @"test test";  //[chuckJokes objectAtIndex:[indexPath.row]];
   // NSIndexPath *nPath = [[NSIndexPath alloc] initWithIndex:1];
   // nPath.row
   // nPath.section = 0;
    
    //[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:nPath] withRowAnimation:UITableViewRowAnimationFade];
    cell.backgroundColor = [[UIColor alloc] initWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
   // [self.tableView insertSubview:cell belowSubview:self.tableView];
    
    [self.tableView insertSubview:cell atIndex:0];
    
    cell2.backgroundColor = [[UIColor alloc] initWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    
 
    
    //[self.tableView insertSubview:cell2 aboveSubview:cell];
    
    //NSIndexPath *newIndexPath = [[NSIndexPath alloc] initWithIndex:10];
    //newIndexPath.row = 1;
    //newIndexPath.section = 0;
    
    
    
     // [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
   //   [self.tableView insertSubview:cell2 atIndex:1];
    
    [self.tableView insertSubview:cell2 belowSubview:cell];
    
    //[label setText:
    
    
    // [self.tableView insertSubview:cell belowSubview:self.tableView];
    //[self.tableView insertSubview:cell belowSubview:cell];
    
    return NO;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    
    
    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [chuckJokes count];
    }
    
    
    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chuck"];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"chuck"] autorelease];
        }
        cell.text = [chuckJokes objectAtIndex:[indexPath.row]];
        
        return cell;
    }
    
   */
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chuck"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"chuck"] autorelease];
    }
    cell.text = @"test test";  //[chuckJokes objectAtIndex:[indexPath.row]];
    
    return cell;
    
   // return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
