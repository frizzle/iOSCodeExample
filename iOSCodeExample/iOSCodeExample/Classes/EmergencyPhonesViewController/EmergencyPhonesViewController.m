
#import "EmergencyPhonesViewController.h"
#import "EmergencyPhoneCellView.h"

@interface EmergencyPhonesViewController ()

@end

@implementation EmergencyPhonesViewController

@synthesize editButton          = _editButton;
@synthesize tableHeaderTop      = _tableHeaderTop;
@synthesize tableHeaderBottom   = _tableHeaderBottom;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _datasource = [[EmergencyPhonesDataSource alloc] init];
        _datasource.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super setNavigationBarTitle:LOC(@"emergency.navigation_bar.title")];
//    _editButton.titleLabel.font       = [AppFonts sharedInstance].avinorMedium_13;
    [_editButton setTitle:LOC(@"emergency.button.edit") forState:UIControlStateNormal];

    [_datasource loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark UITableViewDelegate
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}
- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *phoneData = [_datasource objectForIndexPath:indexPath];
    CGFloat height = [EmergencyPhoneCellView cellHeightForPhoneData:phoneData];
    
    return height;
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [_datasource moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row inSection:sourceIndexPath.section];
}

#pragma mark UITableViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_datasource sectionsCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datasource rowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *phoneData = [_datasource objectForIndexPath:indexPath];
    
    NSString *reuseIdentifier = [EmergencyPhoneCellView cellReuseIdentifier];
    EmergencyPhoneCellView *cell = [_tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [EmergencyPhoneCellView cellInstance];
        cell.delegate = self;
    }
    
    cell.phoneData = phoneData;
   
    return cell;
}

#pragma mark TableViewDataSourceProtocol
- (void)dataSourceDidFinishLoading
{
    [_tableView reloadData];
    if ([_datasource rowsInSection:0] > 0) {
        _tableView.tableHeaderView = _tableHeaderTop;
        _tableView.tableFooterView = _tableHeaderBottom;
    } else {
        _tableView.tableHeaderView = nil;
        _tableView.tableFooterView = nil;
    }
}

- (void)dataSourceGotData
{
    [_tableView reloadData];
    if ([_datasource rowsInSection:0] > 0) {
        _tableView.tableHeaderView = _tableHeaderTop;
        _tableView.tableFooterView = _tableHeaderBottom;
    } else {
        _tableView.tableHeaderView = nil;
        _tableView.tableFooterView = nil;
    }
}

#pragma mark EmergencyPhoneCellViewDelegate

- (void)emergencyPhoneCellDidCall:(EmergencyPhoneCellView *)phoneCell
{
    NSDictionary *phoneData = phoneCell.phoneData;
    
    NSString *urlString = [NSString stringWithFormat:@"tel://%@", [phoneData objectForKey:@"phone_number"]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (IBAction)editButtonClick:(id)sender {
    [_editButton setSelected:!_editButton.selected];
    
    if (_editButton.selected) {
        [self.delegate sliderContentTurnOffGestureRecognizing];
        [_editButton setTitle:[LOC(@"complete") uppercaseString] forState:UIControlStateNormal];
    } else {
        [self.delegate sliderContentTurnOnGestureRecognizing];
        [_editButton setTitle:LOC(@"emergency.button.edit") forState:UIControlStateNormal];
    }
    
    [_tableView setEditing:_editButton.selected animated:YES];
}

#pragma mark Notification Handlers
- (void)sliderDidCloseHandler:(NSNotification *)notification
{
    [super sliderDidCloseHandler:notification];
    [self.delegate sliderContentTurnOnGestureRecognizing];
}

- (void)sliderDidOpenHandler:(NSNotification *)notification
{
    [super sliderDidOpenHandler:notification];
    if (_editButton.selected) {
        [self.delegate sliderContentTurnOffGestureRecognizing];
    } else {
        [self.delegate sliderContentTurnOnGestureRecognizing];
    }
}
@end
