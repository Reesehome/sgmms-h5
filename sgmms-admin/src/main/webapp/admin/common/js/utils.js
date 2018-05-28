/**
 * Auther
 * Date 2018/5/10
 * Description
 */

class Utils {

    constructor() {

    }

    static getQueryString(name) {
        let reg = new RegExp(`(^|&)${name}=([^&]*)(&|$)`);
        let r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURIComponent(r[2]);
        return null;
    }

    static getMinuteOfOneDay(start, end, interval, el) {
        start = !start || start < 0 || start > 24 ? 0 : start;
        end = !end || end < 0 || end > 24 ? 24 : end;
        interval = !interval || interval < 0 || interval > 60 ? 1 : interval;
        let minutes = [], cycle = 60;
        while (start < end) {
            let hour = start < 10 ? `0${start}` : `${start}`;
            for (let i = 0; i < cycle / interval; i++) {
                let text = `${hour}:${i * interval < 10 ? '0' + i * interval : i * interval}`;
                minutes.push(el ? `<${el} value="${text}">${text}</${el}>` : text);
            }
            start++;
        }
        return minutes;
    }

    static getDate2Date(begin, end) {
        let unixDb = new Date(begin).getTime(), unixDe = new Date(end).getTime(), dates = [];
        for (let k = unixDb; k <= unixDe;) {
            let date = (new Date(parseInt(k))).format();
            if (date) {
                dates.push(date);
            }
            k = k + 24 * 60 * 60 * 1000;
        }
        return dates;
    }

    static base64Img2Blob(code) {
        let parts = code.split(';base64,');
        let contentType = parts[0].split(':')[1];
        let raw = window.atob(parts[1]);
        let rawLength = raw.length;
        let uInt8Array = new Uint8Array(rawLength);
        for (let i = 0; i < rawLength; ++i) {
            uInt8Array[i] = raw.charCodeAt(i);
        }
        return new Blob([uInt8Array], {type: contentType});
    }

    static downloadFile(fileName, content) {
        let aLink = document.createElement('a');
        let blob = Utils.base64Img2Blob(content); //new Blob([content]);
        let evt = document.createEvent("HTMLEvents");
        evt.initEvent("click", false, false);//initEvent 不加后两个参数在FF下会报错
        aLink.download = fileName;
        aLink.href = URL.createObjectURL(blob);
        aLink.dispatchEvent(evt);
        aLink.click();
    }

    /*downloadFile('ship.png', canvas.toDataURL("image/png"));*/

}
