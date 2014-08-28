//
//  ViewController.m
//  DocumentPicker
//
//  Created by Pablo Bendersky on 6/19/14.
//  Copyright (c) 2014 Pablo Bendersky. All rights reserved.
//

@import MobileCoreServices;

#import "ViewController.h"

#import "TextEditorViewController.h"

@interface ViewController ()
            
- (IBAction)openDocument:(id)sender;
- (IBAction)importDocument:(id)sender;
- (IBAction)exportToService:(id)sender;
- (IBAction)moveToService:(id)sender;

- (void)showDocumentPickerInMode:(UIDocumentPickerMode)mode;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openDocument:(id)sender {
    [self showDocumentPickerInMode:UIDocumentPickerModeOpen];
}

- (IBAction)importDocument:(id)sender {
    [self showDocumentPickerInMode:UIDocumentPickerModeImport];
}

- (IBAction)exportToService:(id)sender {
    [self showDocumentPickerInMode:UIDocumentPickerModeExportToService];
}

- (IBAction)moveToService:(id)sender {
    [self showDocumentPickerInMode:UIDocumentPickerModeMoveToService];
}

- (void)showDocumentPickerInMode:(UIDocumentPickerMode)mode {
    UIDocumentPickerViewController *picker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[(NSString *)kUTTypeContent] inMode:mode];
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIDocumentPickerDelegate methods

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    NSLog(@"picked %@", url);
    TextEditorViewController *textEditorViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editorViewController"];
    textEditorViewController.editingFileURL = url;
    
    [self performSelector:@selector(navigate:) withObject:textEditorViewController afterDelay:0.5];
    
//    [textEditorViewController loadTextFromURL:url];
}

- (void)navigate:(TextEditorViewController *)textEditorViewController {
    [self.navigationController pushViewController:textEditorViewController animated:YES];
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    NSLog(@"documentPickerWasCancelled");
}

@end
