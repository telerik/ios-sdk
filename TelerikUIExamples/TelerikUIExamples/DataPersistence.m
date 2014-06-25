//
//  DataPersistence.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "DataPersistence.h"
#import <TelerikUI/TelerikUI.h>
#import "Product.h"

static NSString* const cellID = @"tableCell";


@interface DataPersistence() <UITableViewDataSource>

@property (nonatomic, strong) TKDataSyncContext* theContext;

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) UIToolbar *toolbar;

@property (nonatomic, strong) NSArray* products;

@property (nonatomic) BOOL inFilteredMode;

@end


@implementation DataPersistence

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initDataContext];
        [self reloadAllItemsFromDB];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    UIView *view = [[UIView alloc] initWithFrame:applicationFrame];
    self.view = view;
    
    CGFloat width = CGRectGetWidth(applicationFrame);
    CGFloat height = CGRectGetHeight(applicationFrame);

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height - 44)];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];

    [self.view addSubview:self.tableView];

    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.bounds.size.width, 44)];
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_toolbar];

    UIBarButtonItem *buttonAdd    = [[UIBarButtonItem alloc] initWithTitle:@" Add "  style:UIBarButtonItemStylePlain target:self action:@selector(addNewButtonTouchedDown:)];
    UIBarButtonItem *buttonDelete = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(removeItemButtonTouchedDown:)];
    UIBarButtonItem *buttonFilter = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterItemsButtonTouchedDown:)];
    UIBarButtonItem *buttonUpdate = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStylePlain target:self action:@selector(updateSelectedItemButtonTouchedDown:)];

    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    _toolbar.items = @[buttonAdd, space, buttonDelete, space, buttonFilter, space, buttonUpdate];
}

- (void) viewDidLoad
{
    [self updateViews:0];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    Product* theProduct = self.products[indexPath.row];
    NSString* str = [NSString stringWithFormat:@"Name: %@ | Price: %lu", theProduct.name, (unsigned long)theProduct.price];
    cell.textLabel.text = str;
    return cell;
}


#pragma Event handlers

-(void) addNewButtonTouchedDown:(id)sender
{
    Product* pd = [self generateNewProduct];
    
    [self.theContext insertObject:pd];
    NSError* error = nil;
    if ([self.theContext saveChanges:&error])
    {
        self.inFilteredMode = NO;
        [self reloadAllItemsFromDB];
        [self updateViews:_products.count];
    }
    else{
        NSAssert(FALSE, @"Error during persisting of new product:%@", error.description);
    }
}

-(void) filterItemsButtonTouchedDown:(id)sender
{
    NSError* error = nil;
    
    if (NO == self.inFilteredMode){
        _products = [self.theContext getObjectsWithQuery:@"select * from Product where price % 2 != 0"
                                          withParameters:nil
                                              objectType:Product.class
                                         failedWithError:&error];
    }else{
        [self reloadAllItemsFromDB];
    }

    self.inFilteredMode = !self.inFilteredMode;

    if (_products){
        [self updateViews:0];
    }
    else{
        NSAssert(FALSE, @"Error during select query execution:%@", error.description);
    }
}

-(void) removeItemButtonTouchedDown:(id)sender
{
    NSIndexPath* curSel = [self.tableView indexPathForSelectedRow];
    if(!curSel)
        return;
    
    self.inFilteredMode = NO;
    Product* pd = self.products[curSel.row];
    if (pd) {
        [self.theContext deleteObject:pd];
        
        NSError* error = nil;
        if ([self.theContext saveChanges:&error]) {
            [self reloadAllItemsFromDB];
            [self updateViews:curSel.row];
        }else{
            NSAssert(FALSE, @"Error during delete operation:%@", error.description);
        }
    }
}

-(void) updateSelectedItemButtonTouchedDown:(id)sender
{
    NSIndexPath* curSel = [self.tableView indexPathForSelectedRow];
    if(!curSel)
        return;
    
    self.inFilteredMode = NO;
    Product* pd = self.products[curSel.row];
    if (pd) {
        pd.name = [pd.name stringByReplacingOccurrencesOfString:@"Prod" withString:@"Updated"];
        [self.theContext updateObject:pd];
        
        NSError* error = nil;
        if ([self.theContext saveChanges:&error]) {
            [self reloadAllItemsFromDB];
            [self updateViews:curSel.row];
        }else{
            NSAssert(FALSE, @"Error during update operation:%@", error.description);
        }
    }
}

#pragma Persistence

-(void) initDataContext
{
    //1: create&init the context instance
    _theContext = [[TKDataSyncContext alloc] initWithLocalStoreName:@"localPersistenceExample"
                                                       cloudService:nil
                                                         syncPolicy:nil];
    
    //2: for every entity class a primary key should be specified exclusively!!!
    [_theContext registerClass:[Product class] withPrimaryKeyField:@"productID" asAutoincremental:NO];// in case that productID is of type "long" you can specify it as auto incremental.

    //3: set some indices on this entity class Product according to the business logic of SELECT queries
    [_theContext registerIndex:@"idxByProductName"
                      forClass:[Product class]
                     onColumns:@[@"name", @"manufacturer"]
                    withOrders:@[@"Asc", @"Desc"]
                      asUnique:NO];
}

-(void)reloadAllItemsFromDB
{
    if (self.theContext)
    {
        NSError* error = nil;
        _products = [self.theContext getAllObjectsOfType:Product.class failedWithError:&error];
        if (!_products){
            NSAssert(FALSE, @"Error during persisting of new product:%@", error.description);
        }
    }
}

#pragma Helpers

-(Product*) generateNewProduct
{
    Product* product = [[Product alloc] init];

    int rnd = arc4random() % 1000;

    //product.ID this field is the primary key, we shouldn't set a value to it since it is an autoincremental
    product.name = [[NSString alloc] initWithFormat:@"Prod #%i", rnd ];
    product.manufacturer = [[NSString alloc] initWithFormat:@"Manifacturer of %i", rnd ];
    product.price = rnd % 350;
    product.quantity = rnd;

    product.dateOfPurchase = [NSDate date];
    
    return product;
}
-(void) updateViews:(NSInteger) lastSelection
{
    [self.tableView reloadData];
    
    if (_products.count > 0)
    {
        NSIndexPath* path = nil;
        BOOL bSelectCurrent = (_products.count > 0) && (lastSelection < _products.count);
        path = (bSelectCurrent)?[NSIndexPath indexPathForRow:lastSelection inSection:0] : [NSIndexPath indexPathForRow:(_products.count - 1) inSection:0];

        [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    //update the color of Filter button
    UIBarButtonItem* firstBtn = self.toolbar.items[0];
    UIColor* tint = firstBtn.tintColor;
    for (UIBarButtonItem* button in self.toolbar.items) {
        if (button.title && [button.title compare:@"Filter"] == NSOrderedSame) {
            button.tintColor = (self.inFilteredMode)? [UIColor redColor] : tint;
        }
    }
}
@end
