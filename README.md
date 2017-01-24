# key-vimrc

[TOC]

##1 Plugins

### 1.1 vim-surround


####1.1.1 Normal mode

1. ds - 删除一个 surrounding
2. cs - 改变一个 surrounding
3. ys - 增加一个 surrounding
4. yS - 将文本放在新行并在上下增加 surrounding（个人感觉没啥卵用
5. yss - ys的整行操作
6. ySs - yS的整行操作
7. ySS - 与 ySs 相同

####1.1.2 Visual mode

s   - 增加一个 surrounding
S   - 将文本放在新行并在上下增加 surrounding（个人感觉没啥卵用

####1.1.3 Insert mode
-----------
`<CTRL-s>` - 增加一个 surrounding
`<CTRL-s><CTRL-s>` - 将文本放在新行并在上下增加 surrounding（个人感觉没啥卵用
`<CTRL-g>s` -  与 ` <CTRL-s>` 相同
`<CTRL-g>S` -  与 `<CTRL-s><CTRL-s>` 相同

####1.1.4 实际操作
(以下  * 代表光标处)
##### cs 命令  代表 change surround

文本          |命令     |  结果
---------------  |-------   |-----------
"Hello *world!"| cs"'  |    'Hello world!'
"Hello *world!" | cs"<q>  |  <q>Hello world!</q>
(123+4*56)/2     |cs)]      |[123+456]/2
(123+4*56)/2    | cs)[     | [ 123+456 ]/2
`<div>foo*</div>`| ` cst<p> ` | ` <p>foo</p>`
fo*o!         |  csw'  |    'foo'!|
fo*o!         |  csW'   |   'foo!'|

##### yss 命令 代表 add surround
Text              |Command |     New Text
---------------   | -------        |  -----------
Hello w*orld!  |   ysiw)   |    Hello (world)!
Hello w*orld!  |   csw)      |  Hello (world)!
fo*o             | `ysiwt<html>` | `<html>foo</html>`
foo quu*x baz |    yss"        | "foo quux baz"
foo quu*x baz  |   ySS"        | "foo quux baz

#####ds 命令 代表  delete surround
只需`ds(surrounding)`即可 不加()

---

### 1.2 nerdcommenter

1. `<leader>cc`  注释当前行和选中行
2. `<leader>cu`  取消当前行的注释
3. `<leader>cs`  以"性感"的方式注释当前行 
4. `<leader>ci`  执行反注释操作  即注释未被注释的  取消注释 已被注释的
5. `<leader>ca`  转换默认的注释方式   eg.c++的// 与/* */
6. `<leader>c$`  从光标开始到行尾注释
7. `number<leader>cc` 光标以下number行添加注释
8. `number<leader>cu` 光标以下number行取消注释
9. `number<leader>cm` 光标以下number行添加块注释

Normal模式下，几乎所有命令前面都可以指定行数
Visual模式下执行命令，会对选中的特定区块进行注释/反注释

//个人觉得常用的就这么几个    以后可以更新


