//
//  GeneralPreferencesViewController.h
//  owncloudnews
//
//  Created by Lukas Köll on 31.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OcnViewController.h"

@interface GeneralPreferencesViewController : OcnViewController
@property (weak) IBOutlet NSTextField *txtProtocol;
@property (weak) IBOutlet NSTextField *txtBaseUrl;
@property (weak) IBOutlet NSTextField *txtUsername;
@property (weak) IBOutlet NSTextField *txtPassword;
@property (weak) IBOutlet NSTextField *lblCheckResult;

- (IBAction)checkSettings:(id)sender;

@end
