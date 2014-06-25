//
//  DataSynchronization.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "DataSynchronization.h"
#import <TelerikUI/TelerikUI.h>
#import "Product.h"

static NSString* const cellID = @"tableCell";

@interface DataSynchronization()<UITableViewDataSource, TKDataSyncDelegate>

@property (nonatomic, strong) TKDataSyncContext* theContext;

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSArray* products;

@property (nonatomic, strong) NSString* accessToken;

@property (nonatomic, strong) NSString* apiKey;

@end

@implementation DataSynchronization

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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, width, height -  44)];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.view addSubview:self.tableView];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.bounds.size.width, 44)];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:toolbar];
    
    UIBarButtonItem *buttonAdd    = [[UIBarButtonItem alloc] initWithTitle:@"  Add "  style:UIBarButtonItemStylePlain target:self action:@selector(addNewButtonTouchedDown:)];
    UIBarButtonItem *buttonDelete = [[UIBarButtonItem alloc] initWithTitle:@"Delete"  style:UIBarButtonItemStylePlain target:self action:@selector(removeItemButtonTouchedDown:)];
    UIBarButtonItem *buttonUpdate = [[UIBarButtonItem alloc] initWithTitle:@"Update"  style:UIBarButtonItemStylePlain target:self action:@selector(updateSelectedItemButtonTouchedDown:)];
    UIBarButtonItem *buttonSync   = [[UIBarButtonItem alloc] initWithTitle:@" Sync  " style:UIBarButtonItemStylePlain target:self action:@selector(synchronizeItemsButtonTouchedDown:)];

    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolbar.items = @[buttonAdd, space, buttonDelete, space,  buttonUpdate, space, buttonSync];
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
        [self reloadAllItemsFromDB];
        [self updateViews:_products.count];
    }
    else{
        NSAssert(FALSE, @"Error during persisting of new product:%@", error.description);
    }
}


-(void) removeItemButtonTouchedDown:(id)sender
{
    NSIndexPath* curSel = [self.tableView indexPathForSelectedRow];
    if(!curSel)
        return;
    
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

-(void) synchronizeItemsButtonTouchedDown:(id)sender
{
    [_theContext syncChangesAsync:dispatch_get_main_queue()
                completionHandler: ^(BOOL result, NSError *error) {
        if (!result) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Data synchronization"
                                                            message:@"FAILED "
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Data synchronization"
                                                            message:@"SUCCEEDED "
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        _products = [NSMutableArray arrayWithArray:[self.theContext getAllObjectsOfType:Product.class failedWithError:&error]];
        [self updateViews:YES];
    }];

}

#pragma Persistence

/*!
 Get access token from Auth request's response body for registered user.
 Additional information for request can be found here: http://docs.telerik.com/platform/backend-services/development/rest-api/users/authenticate-user
 HINT: you can create a dummy user and use its access token value for all app users.
*/
-(void)obtainAccessTokenForApiKey:(NSString*) apiKey
{
    //Use appropriate username & password here
    NSDictionary* userInfo= @{  @"username": @"andy", @"password": @"1", @"grant_type": @"password"};
    NSError *error;
    NSData* body  = [NSJSONSerialization dataWithJSONObject:userInfo
                                                    options:NSJSONWritingPrettyPrinted
                                                      error:&error];

    NSString* strUrl = [NSString stringWithFormat:@"http://api.everlive.com/v1/%@/oauth/token", apiKey];
    NSURL* url = [NSURL URLWithString:strUrl];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData

                                                       timeoutInterval:30];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:body];

    NSURLResponse* response = nil;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (!data){
        _accessToken = @"";
        return;
    }
    
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    // show all values , just for debug purposes
    for(id key in res){
        id value = [res objectForKey:key];
        
        NSString *strKey = (NSString *)key;
        NSString *strValue = (NSString *)value;
        NSLog(@"key: %@ \nvalue: %@", strKey, strValue);
    }
    
    // extract access token value only
    NSDictionary* resDict = [res objectForKey:@"Result"];
    NSString *token = [resDict objectForKey:@"access_token"];
    NSLog(@"Access token: %@", token);

    _accessToken = token;
}

/*!
 Lazy load access token
 */
-(NSString*) accessToken{
    if (_accessToken) {
        return _accessToken;
    }
    
    [self obtainAccessTokenForApiKey:self.apiKey];
    return _accessToken;
}
//////////////////////

-(void) initDataContext
{
   
    //1: Create Everlive client instance
   self.apiKey = @""; //put here the ApiKey of the application that you use for backend
    
    TKEverliveClient* everliveClient = [TKEverliveClient clientWithApiKey:self.apiKey
                                                              accessToken:self.accessToken //see property getter
                                                           serviceVersion:@1];

    //2: init the policy
    TKDataSyncReachabilityOptions options = TKSyncIn3GNetwork | TKSyncInWIFINetwork;
    TKDataSyncPolicy* thePolicy = [[TKDataSyncPolicy alloc] initForSyncOnDemandWithReachabilityOptions:options
                                                                                conflictResolutionType:TKPreferLocalInstance
                                                                                           syncTimeout:100.0];
    //3: init the synchronization context
    _theContext = [[TKDataSyncContext alloc] initWithLocalStoreName:@"syncExample"
                                                       cloudService:everliveClient
                                                         syncPolicy:thePolicy];

    [_theContext setDelegate:self];
    //4:: for every entity class a primary key should be specified exclusively!!!
    [_theContext registerClass:[Product class] withPrimaryKeyField:@"productID" asAutoincremental:NO]; // in case that productID is of type "long" you can specify it as auto incremental.
    
    //5: set some indices on this entity class Product according to the business logic of SELECT queries.
    //NOTE: for this example we don't need indices, so the next method call is not mandatory
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
#pragma TKDataSyncDelegate

- (BOOL)dataSyncContextIsReadyForSyncExecution
{
    NSLog(@"\n --> dataSyncContextIsReadyForSyncExecution: called.");
    return YES;
}

- (BOOL)dataSyncFailedForTableWithName:(NSString*) name
                             withError:(NSError**) error
{
    NSLog(@"\n --> dataSyncFailedForTableWithName:name:error called");
    return YES; //let's try again to synchronize this table
}

- (id) resolveConflictOfObjectsWithType:(Class) type
                           remoteObject:(id) remote
                             localOject:(id) local
{
    NSLog(@"\n --> resolveConflictOfObjectsWithType:type:remote:local called.");
    return local;
}

- (BOOL)beforeSynchOfTableWithName:(NSString*) tableName
{
    NSLog(@"\n --> beforeSynchOfTableWithName: called.");
    return YES;
}

- (BOOL)afterSynchOfTableWithName:(NSString*) tableName
                    doneWithError:(NSError**) error
{
    NSLog(@"\n --> afterSynchOfTableWithName: called.");
    return YES;
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
        path = (bSelectCurrent)?[NSIndexPath indexPathForRow:lastSelection inSection:0] : [NSIndexPath indexPathForRow:(_products.count > 0)?(_products.count - 1):0 inSection:0];
        
        [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}


@end
