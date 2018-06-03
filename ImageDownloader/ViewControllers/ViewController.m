//
//  ViewController.m
//  ImageDownloader
//
//  Created by Viktoryia Barzdyka on 5/31/18.
//  Copyright © 2018 Barzdyka. All rights reserved.
//

#import "ViewController.h"
#import "ImageView.h"

@interface ViewController ()

@end

@implementation ViewController

int viewHeight;
int offset;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.arrayOfSeparateUrls = @[@"https://www.lovethispic.com/uploaded_images/167482-White-French-Bulldog.jpg",
                                 @"https://cdn.itv.com/uploads/editor/NZD77GzMGyu0u1lYHJV4CPc9tRZiZV7paj2yyZq7lkE.jpg",
                                 @"http://www.petmd.com/sites/default/files/kneecap-dislocation-dogs.jpg"];
    
    self.arrayOfGroupUrls = @[@"https://s.abcnews.com/images/Lifestyle/cats-dogs1-gty-mem-171130_4x3_992.jpg",
                              @"http://c1.thejournal.ie/media/2017/11/shutterstock_589354838-390x285.jpg",
                              @"http://www.dogbreedslist.info/uploads/allimg/dog-pictures/Beagle-1.jpg"];
    
    //refresh button
    viewHeight = self.view.bounds.size.height / 5;
    offset = 20;
    UIButton *refreshButton = [[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - viewHeight/2, offset+4*viewHeight, viewHeight, viewHeight/2)] autorelease];
    [refreshButton addTarget:self action:@selector(reloadImages) forControlEvents:UIControlEventTouchUpInside];
    [refreshButton setTitle:@"Refresh" forState:UIControlStateNormal];
    refreshButton.backgroundColor = UIColor.darkGrayColor;
    [self.view addSubview:refreshButton];

    [self loadSeparateImages];
    [self loadGroupImages];

}

- (void)reloadImages {
    
    for (ImageView *imgView in self.view.subviews) {
        if ([imgView isMemberOfClass:[ImageView class]]) {
            [(ImageView *)imgView removeFromSuperview];
        }
    }

    [self loadSeparateImages];
    [self loadGroupImages];
}

- (ImageView*)createView:(int) number {
    viewHeight = self.view.bounds.size.height / 5;
    offset = 10;
    ImageView *imageView = [[[ImageView alloc] initWithFrame:CGRectMake(offset, 2*offset + number*viewHeight, self.view.bounds.size.width-2*offset, viewHeight-2*offset)] autorelease];
    return imageView;
}

- (void) loadSeparateImages {
    __block int index = 0;
    
    for (int i = 0; i< [_arrayOfSeparateUrls count]; i++){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURL *url = [NSURL URLWithString:[_arrayOfSeparateUrls objectAtIndex:i]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[UIImage alloc] initWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView = [self createView:index];
                [self.view addSubview:self.imageView];
                [self.imageView setImageViewContent:img with: url.absoluteString];
                index++;
            });
        });
    }
}

- (void) loadGroupImages {
    NSMutableArray *arrayOfGroupImages = [[NSMutableArray alloc] init];
    NSLock *arrayLock = [[[NSLock alloc] init] autorelease];
    dispatch_group_t group = dispatch_group_create();
    
    for (int i = 0; i < [_arrayOfGroupUrls count] ; i++) {
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *url = [NSURL URLWithString:[_arrayOfGroupUrls objectAtIndex:i]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[[UIImage alloc] initWithData:data] autorelease];
            [arrayLock lock];
            [arrayOfGroupImages addObject:img];
            [arrayLock unlock];
            dispatch_group_leave(group);
        });
    }
    
    dispatch_group_notify(group,dispatch_get_main_queue(),^{
        self.imageView = [self createView:3];
        [self.view addSubview:self.imageView];
        [self.imageView setGroupImageViewContent: arrayOfGroupImages];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [_arrayOfGroupUrls release];
    [_arrayOfSeparateUrls release];
    [_imageView release];
    [super dealloc];
}

@end
