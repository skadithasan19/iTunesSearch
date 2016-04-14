//
//  ViewController.m
//  iTunesSearch
//
//  Created by Md Adit Hasan on 4/5/16.
//  Copyright © 2016 Md Adit Hasan. All rights reserved.
//

#import "ViewController.h"
#import "customCell.h"
#import "DetailViewController.h"
#import "iService.h"
#import "AbstractActionSheetPicker.h"
#import "ActionSheetStringPicker.h"



@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *entityField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *cellIdentifier = @"customCell";

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 103.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.entityField.delegate = self;
    self.searchBar.delegate = self;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self showDatePicker:textField];
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[TrackManager shareTrackManager] getTotalTrackCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    customCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Track *data = [[TrackManager shareTrackManager] getTrackByIndex:indexPath.row];
    cell.trackName.text = data.trackName;
    cell.kindNamew.text = data.kindName;
    cell.trackPrice.text = [NSString stringWithFormat:@"%@ %@",data.trackPrice,data.trackCurrency];
    cell.shortDescription.text = data.shortDescription;
    [iService downloadImageWithURL:[NSURL URLWithString:data.artWorkURL60] completionBlock:^(BOOL succeeded, UIImage *image) {
        cell.artWorkImg.image = image;
    }];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"detailSegue" sender:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender  {
    
    if ([[segue destinationViewController] isKindOfClass:[DetailViewController class]]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *detailView = [segue destinationViewController];
        [detailView setTrackObject:[[TrackManager shareTrackManager] getTrackByIndex:indexPath.row]];
        
    }

}

-(void) showDatePicker:(id)sender {
    
    NSArray  *entitys = [NSArray arrayWithObjects:@"movie",@"podcast",@"music",@"musicVideo",@"audiobook",@"shortFilm",@"tvShow",@"software",@"ebook",@"all", nil];
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
 
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
        
    };
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Property Type" rows:entitys initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

#pragma Seachbar delegate


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
 
    if ([self.entityField.text length]!= 0 && [searchBar.text length]!=0 ) {
        [self itunesSearch:searchBar.text];
    }
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchText length] == 0) {
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
    }
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [[TrackManager shareTrackManager] removeTrackList];
    [self.tableView reloadData];
    
}

-(void)itunesSearch:(NSString *)searchText {
    
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&entity=%@",searchText,self.entityField.text];
    
    [iService getJsonResponse:[NSString stringWithFormat:@"%@",urlString] success:^(NSDictionary *responseDict) {
        
        [[TrackManager shareTrackManager] addTracks:[responseDict valueForKey:@"results"]];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
