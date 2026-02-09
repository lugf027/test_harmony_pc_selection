# 鸿蒙PC上长按文字出现悬浮菜单后，无法拖拽水滴改变选择范围

* 代码位置：`Index.ets`

* 核心代码：
```typescript
 Text(this.message, this.options)
    .id('HelloWorld')
    .fontSize($r('app.float.page_text_font_size'))
    .fontWeight(FontWeight.Bold)
    .alignRules({
      center: { anchor: '__container__', align: VerticalAlign.Center },
      middle: { anchor: '__container__', align: HorizontalAlign.Center }
    })
    .selection(this.selectStart, this.selectEnd)
    .onTextSelectionChange((selectionStart: number, selectionEnd: number) => {
      MDLog.i(TAG, `onTextSelectionChange selectionStart:${selectionStart} selectionEnd:${selectionEnd}`);
      this.setSelectionRange(selectionStart, selectionEnd);
    })
    .copyOption(CopyOptions.LocalDevice)
    .bindSelectionMenu(TextSpanType.DEFAULT, this.LongPressCustomMenu, TextResponseType.LONG_PRESS, {
      // 移动端
      onDisappear: () => {
        MDLog.i(TAG, `bindSelectionMenu DEFAULT onDisappear for LONG_PRESS, id:${util.getHash(this)}`);
      },
      onAppear: () => {
        MDLog.i(TAG, `bindSelectionMenu DEFAULT onAppear for LONG_PRESS, id:${util.getHash(this)}`);
      }
    })
    .bindSelectionMenu(TextSpanType.DEFAULT, this.LongPressCustomMenu, TextResponseType.SELECT, {
      // pc
      onDisappear: () => {
        MDLog.i(TAG, `bindSelectionMenu DEFAULT onDisappear for SELECT, id:${util.getHash(this)}`);
      },
      onAppear: () => {
        MDLog.i(TAG, `bindSelectionMenu DEFAULT onAppear for SELECT, id:${util.getHash(this)}`);
      }
    })
    .bindSelectionMenu(TextSpanType.DEFAULT, this.LongPressCustomMenu, TextResponseType.DEFAULT, {
      // 双击
      onDisappear: () => {
        MDLog.i(TAG, `bindSelectionMenu DEFAULT onDisappear for DEFAULT, id:${util.getHash(this)}`);
      },
      onAppear: () => {
        MDLog.i(TAG, `bindSelectionMenu DEFAULT onAppear for DEFAULT, id:${util.getHash(this)}`);
      }
    })
```
