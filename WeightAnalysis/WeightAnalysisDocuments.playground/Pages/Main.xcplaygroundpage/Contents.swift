//: [Previous](@previous)

/*:
 # Main
 - callout(模块简介): Main模块主目录根据MVC模式划分，次目录再根据业务逻辑划分。View，Controller，都根据不同的业务模块划分成MainAndLogin，Record，Analysis，Setting。
 ---
 */

/*:
 ## Model
 `SSFAnalysisBrain.swift`:程序的model层，处理整个app需要做的核心功能，包括登陆，注册，修改头像，修改昵称，记录体重，分析体重等功能。
 
 ---
 */

/*:
 ## View
 - callout(Login):包含了登陆注册的view
 
 `LoginAndRegisterView.swift`:自定义的登陆和注册页面，没有使用oop思想实现，而是用了pop思想来实现。
 `Main.storyboard`:主模块的可视化视图组件storyboard，除自定义之外的所有view都在这个文件里。
 - callout(Record):记录模块的相关view
 
 `Record.storyboard`:记录模块的可视化视图组件storyboard，除自定义之外的所有view都在这个文件里。
 - callout(Analyse):分析模块的相关view
 
 `Analyse.storyboard`:分析模块的可视化视图组件storyboard，除自定义之外的所有view都在这个文件里。
 - callout(Setting):设置模块的相关view
 
 `Setting.storyboard`:设置模块的可视化视图组件storyboard，除自定义之外的所有view都在这个文件里。
 
 ---
 */

/*:
 ## Controller
 - callout(MainAndLogin):登陆和主模块的controller
 
 `SSFSignInAndUpViewController.swift`:登陆和注册页的controller，响应登陆和注册等用户操作，并使用SSFAnalysisBrain来处理真正的登陆和注册核心功能。
 
 `SSFMainTabBarViewController.swift`:app的主要承载controller，响应登陆和注册等用户操作，包含了所有内容controller。
 
 - callout(Record):记录模块的controller
 
 待编写
 - callout(Analyse):分析模块的controller
 
 待编写
 - callout(Setting):设置模块的controller
 
 `SSFSettingTableViewController.swift`:设置模块的首页controller，响应设置模块首页的所有交互事件。
 
 ---
 */

//: [Next](@next)
