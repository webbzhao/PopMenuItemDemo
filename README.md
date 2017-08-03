很方便去使用这个弹出菜单，在定义时需传入元组类型的数组。
元组的第一个值为菜单名称，第二个值为图片名称。图片名称可以为nil。
在闭包里返回你点击的菜单名称，进行相应的处理
<pre><code>
let menuView = PopMenuView(menusArr: [("复制",nil),("更改",nil),("插入",nil),("取消",nil)]){
            menuName in
            print("您点击了\(menuName)功能")
        }
        self.navigationController?.view .addSubview(menuView)
        </code></pre>
