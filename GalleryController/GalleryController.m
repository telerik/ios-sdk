//
//  GalleryController.m
//  QSF-iPhone
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "GalleryController.h"
#import "GalleryCollectionViewCell.h"
#import "GalleryCollectionView.h"
#import "GalleryCollectionViewLayout.h"
#import "AppDelegate.h"
#import "TAGManager.h"
#import "TAGDataLayer.h"

@interface GalleryController ()

@end

@implementation GalleryController
{
    UICollectionView *_exampleListCollectionView;
    UIView *_exampleView;
    UICollectionViewLayout *_layout;
    UIViewController *_exampleViewController;
    Example *_selectedExample;
    NSInteger _selectedExampleIndex;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _selectedExampleIndex = -1;
        _layout = [[GalleryCollectionViewLayout alloc] init];
        _exampleListCollectionView = [[GalleryCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _exampleListCollectionView.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)setExample:(Example *)example
{
    [super setExample:example];
    [_exampleListCollectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _exampleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [_exampleListCollectionView registerClass:[GalleryCollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    _exampleListCollectionView.delegate = self;
    _exampleListCollectionView.dataSource = self;
    [self.view addSubview:_exampleListCollectionView];
    [self.view addSubview:_exampleView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.example.childExamples.count > 0) {
        CGSize collectionViewSize = _layout.collectionViewContentSize;
        _exampleListCollectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, collectionViewSize.height);
        _exampleView.frame = CGRectMake(0, collectionViewSize.height , self.view.bounds.size.width, self.view.bounds.size.height - collectionViewSize.height);
    } else {
        _exampleListCollectionView.frame = CGRectZero;
        _exampleView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    
    _exampleViewController.view.frame = _exampleView.bounds;
    
    if (_selectedExampleIndex == -1) {
        _selectedExampleIndex = 0;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [_exampleListCollectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        [self switchExample:0];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.example.childExamples.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryCollectionViewCell *cell = [_exampleListCollectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.example = self.example.childExamples[indexPath.item];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _selectedExampleIndex) {
        return;
    }
  
    [self switchExample:indexPath.item];
    _selectedExampleIndex = indexPath.row;
    [_exampleListCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)switchExample:(NSInteger)index
{
    if (_exampleViewController) {
        [_exampleViewController willMoveToParentViewController:nil];
        [_exampleViewController.view removeFromSuperview];
        [_exampleViewController removeFromParentViewController];
        _exampleViewController = nil;
    }
    
    if (self.example.childExamples.count > 0) {
        _selectedExample = self.example.childExamples[index];
        _exampleViewController = [_selectedExample loadExample];
        if ([_exampleViewController isKindOfClass:[ExampleController class]]) {
            ExampleController *exc = (ExampleController*)_exampleViewController;
            exc.example = _selectedExample;
        }
    }
    
    AppDelegate* appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    TAGDataLayer* dataLayer  = appdelegate.tagManager.dataLayer;
    NSString* title = self.example.className;
    
   // if([title containsString:@"Controller"]){
       title = [title stringByReplacingOccurrencesOfString:@"Controller" withString:@""];
   // }
    
    [dataLayer push:@{@"event" : @"openScreen", @"screenName" : [NSString stringWithFormat:@"Example %@", title]}];
        
    _exampleViewController.view.frame = _exampleView.bounds;
    [self addChildViewController:_exampleViewController];
    [_exampleView addSubview:_exampleViewController.view];
    [_exampleViewController didMoveToParentViewController:self];
}

- (NSString*)sourceCode
{
    NSString *name = _selectedExample.className;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:name ofType:@"m"];
    NSData *data = [fileManager contentsAtPath:resourcePath];
    NSString *content =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return content;
}

@end
