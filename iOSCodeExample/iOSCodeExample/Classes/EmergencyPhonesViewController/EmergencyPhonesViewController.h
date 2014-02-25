
#import "SliderContentViewController.h"
#import "EmergencyPhonesDataSource.h"
#import "EmergencyPhoneCellViewDelegate.h"

@interface EmergencyPhonesViewController : SliderContentViewController<UITableViewDataSource, UITableViewDelegate, TableViewDataSourceProtocol, EmergencyPhoneCellViewDelegate>
{
    EmergencyPhonesDataSource *_datasource;
}

@property (weak, nonatomic)     IBOutlet UITableView    *tableView;
@property (weak, nonatomic)     IBOutlet UIButton       *editButton;
@property (strong, nonatomic)   IBOutlet UIView         *tableHeaderTop;
@property (strong, nonatomic)   IBOutlet UIView         *tableHeaderBottom;

- (IBAction)editButtonClick:(id)sender;
@end
