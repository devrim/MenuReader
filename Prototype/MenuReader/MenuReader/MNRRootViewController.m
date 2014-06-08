//
//  MNRRootViewController.m
//  MenuReader
//
//  Created by Taylan Pince on 2014-06-07.
//  Copyright (c) 2014 Hipo. All rights reserved.
//

#import <TesseractOCR/TesseractOCR.h>

#import "MNRRootViewController.h"

#import "UIView+AutoLayout.h"


@interface MNRRootViewController () <TesseractDelegate>

@end


@implementation MNRRootViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu.png"]];
    
    [imageView setFrame:self.view.bounds];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [imageView setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:imageView];
    
    [imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];

    UITextView *resultView = [[UITextView alloc] initForAutoLayout];
    
    [resultView setBackgroundColor:[UIColor whiteColor]];
    [resultView setEditable:NO];
    
    [self.view addSubview:resultView];
    
    [resultView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [resultView autoSetDimension:ALDimensionHeight toSize:120.0];
    [imageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:resultView];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        Tesseract *tesseract = [[Tesseract alloc] initWithLanguage:@"eng"];
        
        [tesseract setDelegate:self];
        //    [tesseract setVariableValue:@"Phaidon" forKey:@"tessedit_char_whitelist"];
        [tesseract setImage:[UIImage imageNamed:@"menu.png"]];
        [tesseract recognize];
        
        NSString *recognizedText = [[tesseract recognizedText] copy];
        
        tesseract = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [resultView setText:recognizedText];
        });
    });
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Tesseract delegate

- (void)progressImageRecognitionForTesseract:(Tesseract *)tesseract {
    
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(Tesseract *)tesseract {
    return NO;
}

@end
