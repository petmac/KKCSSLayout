//
//  KKMainViewController.m
//  KKCSSLayout
//
//  Created by Peter Mackay on 26/03/2015.
//  Copyright (c) 2015 Kotikan Ltd. All rights reserved.
//

#import "KKMainViewController.h"

static NSString *const reuseIdentifier = @"ReuseIdentifier";

@interface KKMainViewController ()

@property (nonatomic, readonly) NSArray *examples;

@end

@implementation KKMainViewController

#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.examples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = self.examples[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rows = self.examples[indexPath.section];
    NSString *example = rows[indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = example;
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rows = self.examples[indexPath.section];
    NSString *example = rows[indexPath.row];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:example owner:nil options:nil];
    
    NSAssert([nib[0] isKindOfClass:[UIViewController class]], @"Expected a view controller.");
    UIViewController *viewController = nib[0];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark Private

- (NSArray *)examples {
    return @[@[@"Flex Wrap", @"Justify Content", @"Align Items"], @[@"Flex", @"Align Self"], @[@"Auto Layout", @"CSS", @"Container in Container"]];
}

@end
