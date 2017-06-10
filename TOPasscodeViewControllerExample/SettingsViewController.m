//
//  SettingsViewController.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/4/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "SettingsViewController.h"
#import "TOPasscodeSettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {

    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Settings";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneButtonTapped
{
    if (self.doneButtonTappedHandler) {
        self.doneButtonTappedHandler();
    }
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 1 ? @"Passcode View Style" : nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
    }

    if (indexPath.section == 0) {
        cell.textLabel.text = @"Passcode";
        cell.detailTextLabel.text = self.passcode;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        NSString *cellText = nil;

        switch (indexPath.row) {
            case 0: cellText = @"Dark Translucent"; break;
            case 1: cellText = @"Light Translucent"; break;
            case 2: cellText = @"Dark Opaque"; break;
            case 3: cellText = @"Light Opaque"; break;
            default:
                break;
        }

        if (indexPath.row == self.style) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

        cell.textLabel.text = cellText;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1) {
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.style inSection:1];
        self.style = indexPath.row;
        [tableView reloadRowsAtIndexPaths:@[lastIndex, indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    else {
        TOPasscodeSettingsViewController *settingsController = [[TOPasscodeSettingsViewController alloc] init];
        [self.navigationController pushViewController:settingsController animated:YES];
    }
}

@end
