//
//  PJTItemListViewController.m
//  PunicappJsonTest
//
//  Created by Александр Бонко on 2/28/17.
//  Copyright © 2017 PunicApp. All rights reserved.
//

#import "PJTItemListViewController.h"
#import "PJTMainTableViewCell.h"
#import "PJTItemList.h"
#import "PJTPageViewController.h"

#define SEGUE_DETAILS @"showDetails"

@interface PJTItemListViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableViewItems;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) PJTItemList* listLoadedItems;
@property (strong, nonatomic) NSArray<PJTItem*>* filteredItems;

@property (nonatomic) BOOL isSearched;

@end

@implementation PJTItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _listLoadedItems = [[PJTItemList alloc] init];
    [self initCells];
    [self refreshData];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initCells{
    [_tableViewItems registerNib:[UINib nibWithNibName:@"PJTMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"PJTMainTableViewCell"];

}

-(void) refreshData{
    [self startLoadAnimation];
    @weakify(self);
    [_listLoadedItems loadItemList:^(BOOL status, BOOL isNeedConnection) {
        @strongify(self);
        [self stopLoadAnimation];
        [self.tableViewItems reloadData];
        
        if(isNeedConnection){
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Ошибка"
                                          message:@"Нет соединения с сетью интернет. Попробовать загрузить еще раз?"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"Загрузить"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [self refreshData];
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            UIAlertAction* cancel = [UIAlertAction
                                     actionWithTitle:@"Отменить"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
            
            [alert addAction:ok];
            [alert addAction:cancel];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_isSearched){
        return _filteredItems.count;
    }
    else{
        return _listLoadedItems.items.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PJTMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PJTMainTableViewCell"];

    PJTItem* item;
    if(_isSearched){
        NSAssert(indexPath.row < _filteredItems.count, @"_filteredItems count");
        item = _filteredItems[indexPath.row];
    }else{
        NSAssert(indexPath.row < _listLoadedItems.items.count, @"_listLoadedItems count");
        item = _listLoadedItems.items[indexPath.row];
 
    }
    cell.item = item;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:SEGUE_DETAILS sender:indexPath];
    
    [self.view endEditing:YES];
}

#pragma mark AnimationRefresh
-(void) startLoadAnimation{
    _tableViewItems.hidden = YES;
    _activityIndicator.hidden = NO;
    [_activityIndicator startAnimating];
    
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    [self navigationItem].rightBarButtonItem = barButton;
    [activityIndicator startAnimating];
}

-(void) stopLoadAnimation{
    _tableViewItems.hidden = NO;
    _activityIndicator.hidden = YES;
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                               target:self
                               action:@selector(refreshData)];
    self.navigationItem.rightBarButtonItem = button;
}

#pragma mark UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if(searchText.length > 0){
        _isSearched = YES;
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"title CONTAINS %@", searchText];
        _filteredItems = [_listLoadedItems.items filteredArrayUsingPredicate:predicate];

    }else{
        _isSearched = NO;
    }
    [self.tableViewItems reloadData];
}

#pragma mark Segue

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:SEGUE_DETAILS]){
        NSIndexPath* indexPath = (NSIndexPath*) sender;
        PJTPageViewController* vc = segue.destinationViewController;
        if(self.isSearched){
            [vc setItems:_filteredItems];
        }else{
            [vc setItems:_listLoadedItems.items];
        }
        [vc setStartPageIndex:indexPath.row];

    }
}

#pragma mark Keyboard delegate

- (void)keyboardDidShow:(NSNotification*)aNotification
{
    CGSize keyboardSize = [[[aNotification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    }
    
    self.tableViewItems.contentInset = contentInsets;
    self.tableViewItems.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.tableViewItems.contentInset = UIEdgeInsetsZero;
    self.tableViewItems.scrollIndicatorInsets = UIEdgeInsetsZero;
}


@end
