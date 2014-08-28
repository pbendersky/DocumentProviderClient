//
//  TextEditorViewController.m
//  DocumentPicker
//
//  Created by Pablo Bendersky on 7/10/14.
//  Copyright (c) 2014 Pablo Bendersky. All rights reserved.
//

#import "TextEditorViewController.h"

#import "TextDocument.h"

@interface TextEditorViewController ()

- (IBAction)doneEditing:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, copy) NSString *editingText;
@property (nonatomic, strong) TextDocument *document;

@end

@implementation TextEditorViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.document = [[TextDocument alloc] initWithFileURL:self.editingFileURL];
    
    [self.document openWithCompletionHandler:^(BOOL success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textView.text = self.document.textRepresentation;
        });
    }];
}

- (IBAction)doneEditing:(id)sender {
    self.document.textRepresentation = self.textView.text;
    __weak __typeof__(self) weakSelf = self;
    
    [self.document closeWithCompletionHandler:^(BOOL success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    }];
}

@end
