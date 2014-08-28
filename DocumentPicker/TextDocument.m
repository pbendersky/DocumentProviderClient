//
//  TextDocument.m
//  DocumentPicker
//
//  Created by Pablo Bendersky on 8/11/14.
//  Copyright (c) 2014 Pablo Bendersky. All rights reserved.
//

#import "TextDocument.h"

@implementation TextDocument

- (void)setTextRepresentation:(NSString *)textRepresentation {
    _textRepresentation = textRepresentation;
    
    [self updateChangeCount:UIDocumentChangeDone];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)outError {
    NSString* newStr = [[NSString alloc] initWithData:contents encoding:NSUTF8StringEncoding];
    
    self.textRepresentation = newStr;
    
    return YES;
}

- (id)contentsForType:(NSString *)typeName error:(NSError **)outError {
    return [self.textRepresentation dataUsingEncoding:NSUTF8StringEncoding];
}

@end
