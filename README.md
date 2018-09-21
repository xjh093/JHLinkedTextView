# JHLinkedTextView
attributeText with Tap event

# What?
![image](https://github.com/xjh093/JHLinkedTextView/blob/master/image.png)

# Example
```
    JHLinkedTextView *textView = [[JHLinkedTextView alloc] init];
    textView.frame = CGRectMake(20, 100, kScreenWidth-40, 50);
    textView.text = @"登录即视为同意《用户使用协议》及《隐私权条款》";
    textView.textColor = [UIColor lightGrayColor];
    textView.font = [UIFont systemFontOfSize:15];
    //textView.backgroundColor = [UIColor brownColor];
    
    __weak typeof(self) ws = self;
    [textView setLinkedText:@"《用户使用协议》" color:[UIColor redColor] font:[UIFont systemFontOfSize:17] withTapEvent:^{
        [ws showInfo:@"《用户使用协议》"];
    }];
    
    [textView setLinkedText:@"《隐私权条款》" color:[UIColor greenColor] font:[UIFont systemFontOfSize:13] withTapEvent:^{
        [ws showInfo:@"《隐私权条款》"];
    }];
```

# Notice

设置为 链接 的文字，它的颜色由系统控制，这里设置为 `redColor` 与 `greenColor` 都无效，见效果图

如果想要改变系统默认的颜色，使用`tintColor`设置颜色

但是！！！无法单独设置每个的颜色，只能统一设置

# Other

```
textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor],  // color
                                NSUnderlineStyleAttributeName:@1,                   // underLine
                                NSFontAttributeName:[UIFont systemFontOfSize:20]    // font
                                };
```                                    
