

#import <UIKit/UIKit.h>

@interface APPMasterViewController : UITableViewController <NSXMLParserDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) BOOL isFiltered;
@property (strong, nonatomic) NSMutableArray       *allTableData;
@property (strong, nonatomic) NSMutableArray       *filteredTableData;

@end
