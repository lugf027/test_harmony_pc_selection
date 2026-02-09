import { IMDLogProxy, MDLog } from './MDLog';
import { hilog } from '@kit.PerformanceAnalysisKit';

const DOMAIN = 0x0000;

export function initDefaultLogProxy() {
  MDLog.logProxy = {
    isDebugLog: () => {
      return false;
    },
    d: (tag: string, content: string) => {
      hilog.debug(DOMAIN, tag, '%{public}s', content);
    },
    i: (tag: string, content: string) => {
      hilog.info(DOMAIN, tag, '%{public}s', content);
    },
    w: (tag: string, content: string) => {
      hilog.warn(DOMAIN, tag, '%{public}s', content);
    },
    e: (tag: string, content: string) => {
      hilog.error(DOMAIN, tag, '%{public}s', content);
    },
  } as IMDLogProxy
}