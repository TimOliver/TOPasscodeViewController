//
//  SettingsViewController.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/4/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "SettingsViewController.h"
#import "TOPasscodeSettingsViewController.h"

@interface SettingsViewController () <UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
TOPasscodeSettingsViewControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

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

    self.imageView = [[UIImageView alloc] initWithImage:self.wallpaperImage];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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

#pragma mark - Settings Controller Delegate -

- (BOOL)passcodeSettingsViewController:(TOPasscodeSettingsViewController *)passcodeSettingsViewController didAttemptCurrentPasscode:(NSString *)passcode
{
    return [passcode isEqualToString:self.passcode];
}

- (void)passcodeSettingsViewController:(TOPasscodeSettingsViewController *)passcodeSettingsViewController didChangeToNewPasscode:(NSString *)passcode ofType:(TOPasscodeType)type
{
    self.passcode = passcode;
    self.passcodeType = type;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0: return nil;
        case 1: return @"Passcode Display Style";
        case 2: return @"Choose Wallpaper";
        case 3: return @"Passcode Keypad Button Style";
        default: break;
    }

    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 4;
    } else if (section == 3) {
        return 1;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 2) { return 44.0f; }

    return 280.0f;
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
    else if (indexPath.section == 1) {
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
    else if (indexPath.section == 3) {
        NSString *cellText = nil;
        
        switch (indexPath.row) {
            case 0:
                cellText = @"Show Lettering";
                cell.accessoryType = self.showButtonLettering ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
                break;
            default:
                break;
        }
        
        cell.detailTextLabel.text = nil;
        cell.textLabel.text = cellText;
    }
    else {
        cell.textLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.imageView.frame = CGRectInset(cell.bounds, 20, 20);
        [cell addSubview:self.imageView];
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
    else if (indexPath.section == 0) {
        TOPasscodeSettingsViewController *settingsController = [[TOPasscodeSettingsViewController alloc] init];
        settingsController.passcodeType = self.passcodeType;
        settingsController.delegate = self;
        settingsController.requireCurrentPasscode = YES;
        [self.navigationController pushViewController:settingsController animated:YES];
    }
    else if (indexPath.section == 2) {
        __weak typeof(self) weakSelf = self;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        UIImage *pasteboardImage = pasteboard.image;

        void (^photoAction)(UIAlertAction *) = ^(UIAlertAction *action) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            pickerController.delegate = self;
            pickerController.modalPresentationStyle = UIModalPresentationFormSheet;
            [weakSelf presentViewController:pickerController animated:YES completion:nil];
        };

        if (!pasteboardImage) {
            photoAction(nil);
            return;
        }

        void (^clipboardAction)(UIAlertAction *) = ^(UIAlertAction *action) {
            [weakSelf setNewWallpaper:pasteboardImage];
        };

        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Choose Image Source"
                                                                            message:nil
                                                                     preferredStyle:UIAlertControllerStyleActionSheet];
        [controller addAction:[UIAlertAction actionWithTitle:@"Paste Image" style:UIAlertActionStyleDefault handler:clipboardAction]];
        [controller addAction:[UIAlertAction actionWithTitle:@"Choose from Library" style:UIAlertActionStyleDefault handler:photoAction]];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else if (indexPath.section == 3) {
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.style inSection:1];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0:
                self.showButtonLettering = !self.showButtonLettering;
                cell.accessoryType = self.showButtonLettering ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
                break;
            default:
                break;
        }
        
        [tableView reloadRowsAtIndexPaths:@[lastIndex, indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self setNewWallpaper:info[UIImagePickerControllerOriginalImage]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setNewWallpaper:(UIImage *)wallpaper
{
    if (wallpaper == nil) { return; }

    self.wallpaperImage = wallpaper;
    self.imageView.image = wallpaper;

    if (self.wallpaperChangedHandler) {
        self.wallpaperChangedHandler(wallpaper);
    }
}

@end
