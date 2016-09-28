//:# WeightAnalysisDocuments
/*:
 - callout(简介): WeightAnalysis是一款轻量级的记录并且分析用户体重的app。通过每天输入的体重，可以很好的绘制一段时间内的体重走势趋势，并且提醒用户在指定时间点锻炼。
*/
/*:
 - important: 每个项目的准备工作一直都很重要，我们崇尚更好的规划与准备工作，而不是直接扎入项目中敲代码，以下几条希望此项目的开发者都能了然于心。
  
 1. 工程编码规范
    * 使用swift官方建议的编码规范
 2. 此项目应用架构
    * 使用apple官方建议的MVC层级架构
    * 本项目主目录根据业务架构划分，每个业务模块根据MVC划分。
 3. 项目第三方库依赖管理
    * 使用Carthage来管理第三方库
 4. scheme命名规则
    * 项目经常需要配置多个配置文件来适应不同的调试或者发布等等，统一命名为:MyAppName(Environment)
 5. 持续集成和交付
    * 此项目使用testFlight(后续转成Fastlane)
 */
/*:
 - callout(项目章节): 以下根据项目里面的文件夹目录分为不同的章节
 * [Main](Main)
   * Container
   * Record
   * Analyse
   * Setting
 * Expand
   * Utility
   * Network
   * Constant
 * Supportting
 * Products
 * Frameworks
 */

//: [下一页](@next)
