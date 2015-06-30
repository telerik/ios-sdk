#import "MyChartViewController.h"

@implementation MyChartViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor lightGrayColor];

	self.chart = [[TKChart alloc] initWithFrame:CGRectInset(self.view.frame, 20, 20)];
	self.chart.backgroundColor = [UIColor lightGrayColor];
	[self.view addSubview:self.chart];
}

@end