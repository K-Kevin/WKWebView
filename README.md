# WKWebView

仅做了简单的浏览器，可以做静态页面的展示；
起初打算用 WKWebView 提升项目 H5 页面的记载速度（的确比 UIWebView 快出很多），不过由于 cookie 注入的问题，一直没能解决，所以就暂且搁置了；

以下是为了解决 cookie 注入问题的一些链接，作为备忘；

注意：最低版本要求 iOS8，如果希望使用 WKWebView，分版本判断，iOS8 以下的使用 UIWebView；

链接：
<a href="http://blog.csdn.net/reylen/article/details/46679895">WKWebView进度及title</a>
<a href="http://www.brighttj.com/ios/ios-wkwebview-new-features-and-use.html">WKWebView的新特性与使用</a>
<a href="http://www.brighttj.com/ios/ios-wkwebview-new-features-and-use.html">WKWebView的新特性与使用</a>
<a href="http://www.hotobear.com/?p=741">WebKit in iOS 8</a>

cookie相关：
<a href="http://stackoverflow.com/questions/26573137/can-i-set-the-cookies-to-be-used-by-a-wkwebview/26577303#26577303">Can I set the cookies to be used by a WKWebView?</a>
<a href="http://stackoverflow.com/questions/24464397/how-can-i-retrieve-a-file-using-wkwebview/24982211#24982211">How can I retrieve a file using WKWebView?</a>
<a href="http://atmarkplant.com/ios-wkwebview-tips/">iOS WKWebView Tips</a>

参考：
<a href="https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/WebKit/ObjC_classic/index.html#//apple_ref/doc/uid/TP30000745
">WebKit Objective-C Framework Reference</a>
<a href="https://developer.apple.com/videos/wwdc/2014/">Introducing the Modern WebKit API</a>
<a href="https://github.com/WebKit/webkit">GitHub/WebKit</a>