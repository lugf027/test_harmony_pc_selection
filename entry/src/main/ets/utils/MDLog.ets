export class MDLog {
  public static logProxy: IMDLogProxy | undefined = undefined;

  public static isDebugLog(): boolean {
    return MDLog.logProxy?.isDebugLog() ?? false;
  }

  public static d(tag: string, content: string) {
    MDLog.logProxy?.d(tag, content);
  }

  public static i(tag: string, content: string) {
    MDLog.logProxy?.d(tag, content);
  }

  public static w(tag: string, content: string) {
    MDLog.logProxy?.d(tag, content);
  }

  public static e(tag: string, content: string) {
    MDLog.logProxy?.d(tag, content);
  }
}

export interface IMDLogProxy {
  isDebugLog: () => boolean;
  d: (tag: string, content: string) => void;
  i: (tag: string, content: string) => void;
  w: (tag: string, content: string) => void;
  e: (tag: string, content: string) => void;
}