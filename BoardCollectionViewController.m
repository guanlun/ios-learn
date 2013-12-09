//
//  BoardCollectionViewController.m
//  iOSLearn
//
//  Created by Guanlun Zhao on 12/9/13.
//  Copyright (c) 2013 Guanlun Zhao. All rights reserved.
//

#import "BoardCollectionViewController.h"
#import "PostileHttpHandler.h"
#import "BoardViewCell.h"

@interface BoardCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSDictionary *topicData;
@property (strong, nonatomic) NSArray *boardsData;

@end

@implementation BoardCollectionViewController

@synthesize topicData;
@synthesize boardsData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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

- (IBAction)refreshClicked:(id)sender
{
    NSLog(@"refreshing");
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [boardsData count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoardCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    */
    
    NSDictionary *boardData = [boardsData objectAtIndex:indexPath.row];

    BoardViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoardViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.boardNameLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    cell.boardNameLabel.text = [[boardData objectForKey:@"board"] objectForKey:@"name"];
    
    /*
    NSMutableString *picURL;
    [picURL appendString:@"http://postiles.com:8000/"];
    
    [picURL appendString:[[boardData objectForKey:@"board"] objectForKey:@"image_url"]];
    */
    
    NSString *imageURL = @"http://postiles.com:8000/";
    imageURL = [imageURL stringByAppendingString:[[boardData objectForKey:@"board"] objectForKey:@"image_url"]];
    NSLog(imageURL);
    
    UIImage *boardImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    [cell.boardImage setImage:boardImg];
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize retval = CGSizeMake(120, 100);
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

@end
