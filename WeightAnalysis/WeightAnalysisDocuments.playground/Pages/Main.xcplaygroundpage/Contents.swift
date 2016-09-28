//: [Previous](@previous)

/*:
 # Main
 - callout(模块简介): Main模块根据业务以及页面逻辑，对应app页面的纪录，分析和设置3个tab，从而分为对应的Record，Analyse，Setting3个业务模块，同时将主要的SSFMainTabbarcontroller和AppDelegate并入Container文件夹。
 ---
 */

/*:
 ## Container模块
 待编写
 
 ---
 */

/*:
 ## Record模块
 待编写
 
 ---
 */

/*:
 ## Analyse模块
 待编写
 
 ---
 */

/*:
 ## Setting模块
  - callout(model):设置模块model层
 
 `SSFSettingBrain.swift`:设置模块的model层，处理整个设置模块需要做的核心功能，包括登陆，注册，修改头像，修改昵称等功能。
 
 
  - callout(view):设置模块view层
 
 `LoginAndRegisterView.swift`:自定义的登陆和注册页面，没有使用oop思想实现，而是用了pop思想来实现。
 
 `Setting.storyboard`:设置模块的可视化视图组件storyboard，除自定义之外的所有view都在这个文件里。
 
 
  - callout(controller):设置模块controller层
 
 `SSFSettingTableViewController.swift`:设置模块的首页controller，响应设置模块首页的所有交互事件。
 
 `SSFSignInAndUpViewController.swift`:设置模块的登陆和注册页的controller，响应登陆和注册等用户操作，并使用SSFSettingBrain来处理真正的登陆和注册核心功能。
 
 
 ---
 */
//: [Next](@next)
