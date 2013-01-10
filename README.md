SearchHUD
=========

Control used to show a HUD which contains searchbar and tableview.

![Screen 1](https://github.com/pradyumnad/SearchHUD/blob/master/Screen%202.png?raw=true)

Including into Project
-----------------------


	#import "PDSearchHUD.h"
	
	PDSearchHUD *searchHUD = [[PDSearchHUD alloc] initWithSearchList:self.items andDelegate:self];
    [self.view addSubview:searchHUD];
    
   
Options in PDSearchHUD

	//Dismisses the view when a row is selected.
	[searchHUD setDismissWhenRowSelected:YES];
	
	//Used to specify the search type "beginsWith" or "compare"
    [searchHUD setSearchType:PDSearchTypeBeginsWith];   
    

#### PDSearchHUDDelegate

	- (void)didSelectRowAtIndex:(int)index {
    	NSLog(@"Index of Tapped item : %i", index);
	    _countryLabel.text = [self.items objectAtIndex:index];
	}

	- (void)didSelectItem:(NSString *)item {
    	NSLog(@"Selected Item %@", item);
	    _countryLabel.text = item;
	}
	

Requirements
------------
PDSearchHUD requires either iOS 5.0 and above.

Contact
-------
Follow [@pradyumna_d](http://twitter.com/pradyumna_d) on Twitter for the latest news.

License
------------
PDSearchHUD is available under the CC BY 3.0 license. See the LICENSE file for more info.