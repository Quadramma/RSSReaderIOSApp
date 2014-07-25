

#import "Feed.h"
#import "APPMasterViewController.h"
#import "APPDetailViewController.h"

@interface APPMasterViewController () {
    
    NSXMLParser *parser;
    Feed *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description;
    NSString *element;
    
}
@end

@implementation APPMasterViewController


@synthesize searchBar;
@synthesize filteredTableData;
@synthesize allTableData;




- (void)awakeFromNib
{
    [super awakeFromNib];
}




- (void)viewDidLoad {
    [super viewDidLoad];

    item = [[Feed alloc]init];
    allTableData = [[NSMutableArray alloc] init];
    filteredTableData = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"http://feeds.bbci.co.uk/news/rss.xml"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
     searchBar.delegate = (id)self;
    
    NSLog(@"viewDidLoad OK");
}



-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        self.isFiltered = FALSE;
    }
    else
    {
        self.isFiltered = TRUE;
        filteredTableData = [[NSMutableArray alloc] init];
        for (Feed* feed in allTableData)
        {
            NSRange nameRange = [feed.title rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [feed.description rangeOfString:text options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
            {
                [filteredTableData addObject:feed];
            }
        }
    }
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rowCount;
    if(self.isFiltered)
        rowCount = filteredTableData.count;
    else
        rowCount = allTableData.count;
    
    return rowCount;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:101];

    Feed *feed = nil;
    if(self.isFiltered){
        feed = [filteredTableData objectAtIndex:indexPath.row];
    }else{
        feed = [allTableData objectAtIndex:indexPath.row];
    }
    
    titleLabel.text = feed.title;
    detailLabel.text = feed.description;   
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:102];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:feed.imageUrl]];
    imageView.image = [UIImage imageWithData:imageData];
    return cell;
}




- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    element = elementName;
    if ([element isEqualToString:@"item"]) {
        item = [[Feed alloc]init];
         NSLog(@"Item start");
    }
    else if([elementName isEqualToString:@"media:thumbnail"]) {
        item.imageUrl = [attributeDict objectForKey:@"url"];
    }
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"item"]) {        
        NSLog(@"Item ready ->%@",item.title);
        [allTableData addObject:item];
        NSLog(@"Item added");
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{    
    if ([element isEqualToString:@"title"] && [item.title isEqualToString:@""]) {
        item.title = string;
        NSLog(@"parser found title %@",item.title);
    }
    else if ([element isEqualToString:@"link"] && [item.link isEqualToString:@""]) {
        item.link = string;
        NSLog(@"parser found link %@",item.link);
    }
    else if ([element isEqualToString:@"description"] && [item.description isEqualToString:@""]) {
        item.description = string;
        NSLog(@"parser found description %@",item.description);
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if(self.isFiltered){
            [[segue destinationViewController] setItem: filteredTableData[indexPath.row]];
        }else{
            [[segue destinationViewController] setItem: allTableData[indexPath.row]];
        }
    
    }
}

@end
