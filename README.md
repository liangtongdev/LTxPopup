# LTxPopup

A collection components of popup. 

 + Menu
 + Toast
 + View
 + Alert


## Installation with CocoaPods

LTxPopup is available in CocoaPods, specify it in your *Podfile*:

    pod 'LTxPopup'

## Deployment
    9.0

## PopupMenu
**UIViewController** Category

![](https://github.com/liangtongdev/LTxPopup/blob/master/screenshots/popup_menu.png)


Just 3 steps. 
 + set up configuration 
 + protocol method
 + show

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

## PopupView

**UIViewController** and **UIView** Category

![](https://github.com/liangtongdev/LTxPopup/blob/master/screenshots/popup_view.png)


Set up configuration

 ```Objective-C
    LTxPopupViewConfiguration* config = [LTxPopupViewConfiguration defaultConfiguration];
    config.containerBackgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.2];//outside color
    config.cornerSize = 25.f;//corner size
    config.dismissOnTapOutside = NO;//dismiss on tap outside
    //animation setting
    config.showAnimationType = LTxPopupShowAnimationAppear;
    config.showAnimationDuration = .6f;
    config.hideAnimationType = LTxPopupHideAnimationFadeOut;
    config.hideAnimationDuration = .4f;
 ```

Show and hide

 ```Objective-C
    //show
    [self.view showLTxPopupView:popView configuration:config];

    //hide. You may not need it if you set dismissOnTapOutside = YES
    [self.view hideLTxPopupView];
 ```



## PopupToast

![](https://github.com/liangtongdev/LTxPopup/blob/master/screenshots/popup_toast.png)

Quick example of LTxPopupToast

 ```Objective-C
    LTxPopupToastConfiguration* configuration = [LTxPopupToastConfiguration defaultConfiguration];
    configuration.image = [UIImage imageNamed:@"teal_checkmark"];
    configuration.title = @"Notification";
    configuration.message = @"This liangtong from zhengzhou. thanks very much.   😄 ";
    
    [LTxPopupToast showLTxPopupToastWithConfiguration:configuration show:^{
        NSLog(@"popup toast show complete");
    } tap:^{
        NSLog(@"tap at popup toast ");
    } dismiss:^{
        NSLog(@"popup toast dismissed");
    }];
 ```

Setup the toast

 ```Objective-C
@interface LTxPopupToastConfiguration : NSObject

/**
 * show under status bar
 **/
@property (nonatomic, assign) BOOL showUnderStatusBar;

/**
 * background color
 **/
@property (nonatomic, strong) UIColor* backgroundColor;

/**
 * image on the left of toast. nil means no image
 **/
@property (nonatomic, strong) UIImage* image;

/**
 * ignore btn. title color and font
 **/
@property (nonatomic, assign) BOOL showIgnoreBtn;
@property (nonatomic, strong) NSString* ignoreBtnTitle;
@property (nonatomic, strong) UIColor* ignroeBtnTitleColor;
@property (nonatomic, assign) CGFloat ignoreBtnTitleFontSize;

/**
 * title
 **/
@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) NSTextAlignment titleTextAlignment;
@property (nonatomic, strong) UIColor* titleColor;
@property (nonatomic, assign) CGFloat titleFontSize;

/**
 * message
 **/
@property (nonatomic, strong) NSString* message;
@property (nonatomic, assign) NSTextAlignment messageTextAlignment;
@property (nonatomic, strong) UIColor* messageColor;
@property (nonatomic, assign) CGFloat messageFontSize;

/**
 * animating
 **/
@property (nonatomic, assign) CGFloat showAnimateDuration;
@property (nonatomic, assign) CGFloat showDuration;
@property (nonatomic, assign) BOOL autoDismiss;

/**
 * @brief: init method. also you can use alloc and init method.
 **/
+(instancetype)defaultConfiguration;
@end
 ```


## PopupAlert

![](https://github.com/liangtongdev/LTxPopup/blob/master/screenshots/popup_alert.png)

On the top of **UIAlertController**

 ```Objective-C
    UIAlertAction* cancelAction = ...;
    UIAlertAction* okAction = ...;
    UIAlertAction* desAction = ...;

    [self showLTxPopupAlertWithTitle:@"提醒"
                             message:@"这是一个AlertViewController"
                               style:UIAlertControllerStyleAlert
                          sourceView:nil
                             actions:cancelAction,okAction,desAction,nil];
 ```





## Release Log

+ 0.0.4 (2018/07/31) - Popup Toast Support

+ 0.0.3 (2018/07/30) - Popup Alert Support

+ 0.0.2 (2018/07/27) - Popup View Support

+ 0.0.1 (2018/07/26) - Popup Menu Support

## Contacts

 liangtongdev@163.com

## License

MIT License

Copyright (c) 2018 liangtong

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

