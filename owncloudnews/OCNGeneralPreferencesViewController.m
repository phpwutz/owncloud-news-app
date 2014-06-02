//
//  GeneralPreferencesViewController.m
//  owncloudnews
//
//  Created by Lukas Köll on 31.05.14.
//  Copyright (c) 2014 Lukas Köll. All rights reserved.
//

#import "OCNGeneralPreferencesViewController.h"
#import "OCNNewsAPI12.h"
#import "OCNServiceFactoryImpl.h"

@implementation OCNGeneralPreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id) init{
    return [[OCNGeneralPreferencesViewController alloc ]initWithNibName:@"GeneralPreferences" bundle:nil];
}

- (IBAction)checkSettings:(id)sender{
    [self.lblCheckResult setStringValue: @"checking..."];
    [self.lblCheckResult needsDisplay];
    NSString* protocol = [self.txtProtocol stringValue];
    NSString* baseUrl = [self.txtBaseUrl stringValue];
    NSString* username = [self.txtUsername stringValue];
    NSString* password = [self.txtPassword stringValue];
    
    if(![OCNNewsAPI12 checkSettingsWithProtocol:protocol
                                 andBaseUrl:baseUrl
                                andUsername:username
                                andPassword:password]){
        [self.lblCheckResult setStringValue:@"Could not connect to the owncloud news API. Please enter correct settings."];
        //[[NSUserDefaultsController sharedUserDefaultsController] revertToInitialValues:self];
    }else{
        [self.lblCheckResult setStringValue:@"Your settings seem OK. You can close this window now."];
        [[[OCNServiceFactoryImpl getInstance ]getOwncloudSyncService] syncDatabaseWithApi];
        NSUserDefaultsController *controller = [NSUserDefaultsController sharedUserDefaultsController];
        [controller save:self];
    }
}
@end
