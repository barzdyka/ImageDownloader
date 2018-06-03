//
//  ViewController.h
//  ImageDownloader
//
//  Created by Viktoryia Barzdyka on 5/31/18.
//  Copyright © 2018 Barzdyka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) ImageView* imageView;
@property (strong, nonatomic) NSArray* arrayOfSeparateUrls;
@property (strong, nonatomic) NSArray* arrayOfGroupUrls;

@end

