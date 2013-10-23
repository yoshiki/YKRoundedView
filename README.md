YKRoundedView
=================

YKRoundedView is simple view like UITableViewCell grouped.

Installation
=================

Just copy YKRoundedView/* to your project.

Usage
=================

See demo project.

### Construction

```
- (void)viewDidLoad {
    [super viewDidLoad];

    YKRoundedView *roundedView = [[YKRoundedView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 44.0f)];
    roundedView.fillColor = [UIColor whiteColor];
    roundedView.strokeColor = [UIColor grayColor];
    roundedView.shadowColor = [UIColor lightGrayColor];
    roundedView.separatorColor = [UIColor grayColor];
    roundedView.separatorShadowColor = [UIColor lightGrayColor];
    roundedView.lineWidth = 1.0f;
    roundedView.cornerRadius = 5.0f;
    roundedView.position = YKRoundedViewSingle;
    [self.view addSubview:roundedView];
}
```

