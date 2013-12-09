//
//  TopicListViewController.m
//  iOSLearn
//
//  Created by Guanlun Zhao on 12/7/13.
//  Copyright (c) 2013 Guanlun Zhao. All rights reserved.
//

#import "TopicListViewController.h"
#import "PostileHttpHandler.h"
#import "TopicListCell.h"
#import "BoardDataDisplayViewController.h"

@interface TopicListViewController ()

@property (strong, nonatomic) NSDictionary *topicData;
@property (strong, nonatomic) NSArray *boardsData;

@end

@implementation TopicListViewController

@synthesize topicData;
@synthesize boardsData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    [postDict setObject:@"1" forKey:@"topic_id"];
    
    NSString *url = @"http://postiles.com:3000/topic/get_topic";
    
    NSDictionary *data = [PostileHttpHandler sendRequestToURL:url WithData:postDict];
    
    if ([[data objectForKey:@"status"] isEqualToString:@"ok"]) {
        topicData = [[data objectForKey:@"message"] objectForKey:@"topic"];
        NSString *topicName = [topicData objectForKey:@"name"];
        self.navigationItem.title = topicName;
    }
    
    url = @"http://postiles.com:3000/board/get_boards_in_topic";
    
    data = [PostileHttpHandler sendRequestToURL:url WithData:postDict];
    
    if ([[data objectForKey:@"status"] isEqualToString:@"ok"]) {
        boardsData = [[data objectForKey:@"message"] objectForKey:@"boards"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [boardsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TopicListCell";
    
    TopicListCell *cell = (TopicListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *outlets = [NSArray arrayWithArray:[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil]];
        for (id obj in outlets) {
            if ([obj isKindOfClass:[TopicListCell class]]) {
                cell = (TopicListCell *)obj;
            }
        }
    }
    
    // Configure the cell...
    NSDictionary *boardData = [boardsData objectAtIndex:indexPath.row];
    cell.titleLabel.text = [[boardData objectForKey:@"board"] objectForKey:@"name"];
    cell.descriptionLabel.text = [[boardData objectForKey:@"board"] objectForKey:@"description"];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
	
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoardDataDisplayViewController *displayViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardDataDisplayViewController"];
    displayViewController.boardIndex = indexPath.row;

    [self.navigationController pushViewController:displayViewController animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"BoardDataDisplayViewController"]) {
        BoardDataDisplayViewController *con = (BoardDataDisplayViewController *)segue.destinationViewController;
        con.boardIndex = [NSNumber numberWithInt:3];
    }
}

@end
