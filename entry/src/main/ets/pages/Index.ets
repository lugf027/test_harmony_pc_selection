import { MDLog } from '../utils/MDLog';
import { util } from '@kit.ArkTS';

const TAG = 'IndexPage'

// 长按菜单
export interface IMDTextLongPressMenuItem {
  menuName: ResourceStr;
  onClick: (name: string, selectedContent: string) => void;
}

@Entry
@ComponentV2
struct Index {
  @Local message: string = 'Hello World! Hello World! Hello World! Hello World! Hello World! Hello World! Hello World!';
  @Local selectStart: number = -1;
  @Local selectEnd: number = -1;
  @Local longPressMenus: IMDTextLongPressMenuItem[] = [];
  private controller: TextController = new TextController();
  private options: TextOptions = { controller: this.controller };

  aboutToAppear(): void {
    this.longPressMenus = [
      {
        menuName: '选项1',
        onClick: ((name: string, selectedContent: string) => {
          MDLog.d(TAG, `onClickMD menuName:${name} selectedContent:${selectedContent}`);
        })
      },
      {
        menuName: '选项2',
        onClick: ((name: string, selectedContent: string) => {
          MDLog.d(TAG, `onClickMD menuName:${name} selectedContent:${selectedContent}`);
        })
      },
    ]
  }

  build() {
    RelativeContainer() {
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
    }
    .height('100%')
    .width('100%')
  }


  /**
   * 长按文本的选择菜单（下面称之为 SelectionMenu ）
   */
  @Builder
  LongPressCustomMenu() {
    Row() {
      ForEach(this.longPressMenus,
        (item: IMDTextLongPressMenuItem, index: number) => {
          if (index > 0) {
            Divider()
              .height('100%')
              .width(1)
              .vertical(true)
              .flexShrink(1)
              .strokeWidth(1)
              .color('#1F000000')
              .margin({
                left: 5, right: 5,
              });
          }
          Text(item.menuName)
            .height('100%')
            .width(70)
            .textAlign(TextAlign.Center)
            .fontSize(17)
            .fontColor('#DB000000')
            .onClick(() => {
              const content = this.message.substring(this.selectStart, this.selectEnd);
              MDLog.i(TAG, `longPressMenus range:${this.selectStart}~${this.selectEnd} content:'${content}'`);
              this.resetSelectionRange();
              this.controller.closeSelectionMenu();
              item.onClick(item.menuName.toString(), content);
            });
        });
    }
    .clip(true)
    .height(40)
    .borderRadius(8)
    .backgroundColor('#FFFFFF')
    .shadow({
      radius: 32,
      color: '#26000000',
    })
  }

  public setSelectionRange(selectStart: number, selectEnd: number) {
    this.selectStart = selectStart;
    this.selectEnd = selectEnd;
  }

  public resetSelectionRange() {
    this.selectStart = -1;
    this.selectEnd = -1;
  }
}