//
//  LocalPDFViewController.m
//  HBDrawViewDemo
//
//  Created by points on 2017/6/29.
//  Copyright © 2017年 伍宏彬. All rights reserved.
//

#import "LocalPDFViewController.h"
#import "SpePDFEditViewController.h"

@interface LocalPDFViewController ()<UITableViewDelegate,UITableViewDataSource,SpePDFEditViewControllerDelegate>
@property(nonatomic,strong)NSArray *m_arrPDFs;
@end

@implementation LocalPDFViewController

- (NSArray *) getAllFileNames
{
    // 获得此程序的沙盒路径
    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [patchs lastObject];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectory error:nil];
    NSPredicate *sPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] '.pdf'"];
    return [files filteredArrayUsingPredicate:sPredicate];
}

- (NSArray *)arrPDFs{
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"pdf"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSString *ducoment = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    [data writeToFile:[ducoment stringByAppendingPathComponent:@"1.pdf"] atomically:YES];
    
    NSArray *arr = [self getAllFileNames];
    return arr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.m_arrPDFs = [self arrPDFs];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_arrPDFs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    NSString *name = [self.m_arrPDFs objectAtIndex:indexPath.row];
    cell.textLabel.text = name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = [self.m_arrPDFs objectAtIndex:indexPath.row];
    
    NSString *ducoment = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    name = [ducoment stringByAppendingPathComponent:name];
    SpePDFEditViewController *pdfVc = [[SpePDFEditViewController alloc]initWith:[NSURL fileURLWithPath:name]];
    pdfVc.m_pdfDelegate = self;
    [self.navigationController pushViewController:pdfVc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)onSavedNewPDF:(NSString *)localFilePath
{
    self.m_arrPDFs = [self arrPDFs];
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
