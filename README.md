# LTxPopup

A collection components of popup. 

## Installation with CocoaPods

LTxPopup is available in CocoaPods, specify it in your *Podfile*:

    pod 'LTxPopup'

## Deployment
    9.0


## PopupView

**UIViewController** and **UIView** Category

![](https://github.com/liangtongdev/LTxPopup/blob/master/screenshots/2.png)

### Usage

Set up configuration

 ```Objective-C
    LTxPopupViewConfiguration* config = [LTxPopupViewConfiguration defaultConfiguration];
    config.containerBackgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.2];//outside color
    config.cornerSize = 25.f;//corner size
    config.dismissOnTapOutside = NO;//dismiss on tap outside
    //animation setting
    config.showAnimationType = LTxPopupViewShowAnimationFromTop;
    config.showAnimationDuration = .6f;
    config.hideAnimationType = LTxPopupViewHideAnimationFadeOut;
    config.hideAnimationDuration = .4f;
 ```

Show and hide

 ```Objective-C
    //show
    [self.view showLTxPopupView:popView configuration:config];

    //hide. You may not need it if you set dismissOnTapOutside = YES
    [self.view hideLTxPopupView];
 ```



## PopupMenu
**UIViewController** Category

![](https://github.com/liangtongdev/LTxPopup/blob/master/screenshots/1.png)

### Usage

Just 3 steps. 
 + set up configuration 
 + protocol method
 +  show

 For example. If you show custom Nib menu item with LTxPopupMenu
 ```Objective-C
 //step 1 : set up configuration
 LTxPopupMenuConfiguration* config = [LTxPopupMenuConfiguration defaultConfiguration];
 config.rowHeight = UITableViewAutomaticDimension;
 config.menuContentSize = CGSizeMake(360, 200);
 config.separatorStyle = UITableViewCellSeparatorStyleNone;
 config.cellNib = [UINib nibWithNibName:@"LTxMenuItemTableViewCell" bundle:nil];
 
 //step 2: protocol method
 -(NSInteger)ltx_numberOfRows{
     return _dataSource.count;
 }
 -(void)ltx_configMenuCellItem:(UITableViewCell*)cell forIndex:(NSInteger)index{
    NSDictionary* item = [_dataSource objectAtIndex:index];
    if ([cell isKindOfClass:[LTxMenuItemTableViewCell class]]) {
        LTxMenuItemTableViewCell* nibCell = (LTxMenuItemTableViewCell*)cell;
        nibCell.item = item;
    }
 }
 -(void)ltx_selectedIndex:(NSInteger)index{
    NSLog(@"%td row is selected",index);
 }
 
 //step 3: show
[self showLTxPopupMenuFrom:sender configuration:config delegate:self];

 ```
#### Configuration 

you can custom LTxPopupMenu with **LTxPopupMenuConfiguration**. include arrow color , direction, content size , item height and so on.

```Objective-C
//arrow color. default is [UIColor whiteColor]
@property (nonatomic, strong) UIColor* arrowColor;

//arrow direction. default is UIPopoverArrowDirectionAny
@property (nonatomic, assign) UIPopoverArrowDirection arrowDirection;

//menu content size. default is CGSizeMake(200, 300)
@property (nonatomic, assign) CGSize menuContentSize;

/**
* menu item height. default is 50.f
* you should set it to UITableViewAutomaticDimension when estimoting row height
**/
@property (nonatomic, assign) CGFloat rowHeight;
/**
* estimoted item height. default is 50.f
**/
@property (nonatomic, assign) CGFloat estimatedRowHeight;
/**
* menu item separator style. default is line
**/
@property (nonatomic, assign) UITableViewCellSeparatorStyle separatorStyle;
/**
* menu item separator line color. default is [UIColor lightGrayColor]
**/
@property (nonatomic, strong) UIColor* separatorColor;
/**
* menu item cell style. default is UITableViewCellStyleDefault
**/
@property (nonatomic, assign) UITableViewCellStyle itemStyle;
/**
* menu scroll indicator. default value is NO.
**/
@property (nonatomic, assign) BOOL showsScrollIndicator;
/**
* when you want to use nib with LTxPopupMenu item.
**/
@property (nonatomic, strong) UINib* cellNib;

/**
* @brief: init method. also you can use alloc and init method.
**/
+(instancetype)defaultConfiguration;
```

#### Delegate 
the delegate method **ltx_numberOfRows** and **ltx_configMenuCellItem:forIndex:** is required. 

```Objective-C

@required
/**
* number of rows in popupMenu
**/
-(NSInteger)ltx_numberOfRows;

/**
* custom menu item at index
**/
-(void)ltx_configMenuCellItem:(UITableViewCell*)cell forIndex:(NSInteger)index;


@optional
/**
* menu item is selected at index
**/
-(void)ltx_selectedIndex:(NSInteger)index;
```



## Release Log

+ 0.0.2 (2018/07/27) - PopupView Support

+ 0.0.1 (2018/07/26) - Initial Release
  + LTxPopupMenu Support

## Contacts

 liangtongdev@163.com
