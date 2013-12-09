//
//  BoardDataDisplayViewController.m
//  iOSLearn
//
//  Created by Guanlun Zhao on 12/7/13.
//  Copyright (c) 2013 Guanlun Zhao. All rights reserved.
//

#import "BoardDataDisplayViewController.h"

@interface BoardDataDisplayViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation BoardDataDisplayViewController

@synthesize boardIndex;

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
    NSLog([NSString stringWithFormat:@"%i", boardIndex]);
	// Do any additional setup after loading the view.c
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
