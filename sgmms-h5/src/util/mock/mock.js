import Mock from 'mockjs';
let baseUrl = 'http://localhost:8080/sgmms-admin'
let Random = Mock.Random
/**
 * 获取短信验证码
 * @param params
 * @returns {AxiosPromise<any>}
 */
// Mock.mock(`${baseUrl}/api/verificationCode`, {
//     'success': true
// });

/**
 * 根据手机号和验证码登录
 * @param params
 * @returns {AxiosPromise<any>}
 */
// Mock.mock(`${baseUrl}/api/authentication`, {
//     'success': true,
//     'expires_in': 7200,
//     "access_token": 'eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJpbmZpbml0dXMiLCJpYXQiOjE1MjIwMzUxNTUsImV4cCI6MTU1MzU3MTE1NSwiYXVkIjoidGlzc2lvbiIsInN1YiI6IkMwMDAwMDAwMjczIn0.Ml_yEAQgCyBy6WzF2XmCsegOATQZcKCUvcnqGoRE518'
// });

/**
 * 获取会议列表
 * @param params
 * @returns {AxiosPromise<any>}
 */
// Random.extend({
//     // 扩展会议状态随机值
//     meetingStat: function () {
//         var stats = ['ENDED', 'STARTED', 'UNSTART']
//         return this.pick(stats)
//     }
// })
// Mock.mock(`${baseUrl}/api/conference`, {
//     "success": true,
//     "total_pages": 1,
//     "total_elements": 1,
//     "content|1-10": [
//         {
//             "title": Random.cword(5, 20),
//             "code": "7a470f6c3b2b4e33bb6ecf7c9fec2b5d",
//             "begin_time": Random.datetime('yyyy-MM-dd HH:mm:ss'),
//             "end_time": Random.datetime('yyyy-MM-dd HH:mm:ss'),
//             "status": Random.meetingStat(),
//             "location": Random.cword(5, 30),
//             "total_users": Random.natural()
//         }
//     ]
// });
/**
 * 获取会议详情
 * @param params
 * @returns {AxiosPromise<any>}
 */
// Mock.mock(`${baseUrl}/api/conference/7a470f6c3b2b4e33bb6ecf7c9fec2b5d`, {
//     "title": Random.cword(5, 20),
//     "begin_time": Random.datetime('yyyy-MM-dd HH:mm:ss'),
//     "end_time": Random.datetime('yyyy-MM-dd HH:mm:ss'),
//     "status": Random.meetingStat(),
//     "venue": Random.cword(5, 30),
//     "agendum": Random.cparagraph(),
//     "attention": Random.cparagraph(),
//     "total_users": Random.natural(),
//     "attachment|1-5": [
//         {
//             "title": Random.cword(5, 10),
//             "name": "a5c27d1ed21b0ef48c509cecd1c451da80cb3ec3.jpg",
//             "uri": "http://h.hiphotos.baidu.com/image/pic/item/a5c27d1ed21b0ef48c509cecd1c451da80cb3ec3.jpg"
//         }
//     ]
// });
/**
 * 获取签到记录
 * @param params
 * @returns {AxiosPromise<any>}
 */
// Random.extend({
//     // 扩展会议状态随机值
//     signStat: function () {
//         var stats = ['Y', 'W', 'C']
//         return this.pick(stats)
//     }
// })
// Mock.mock(`${baseUrl}/api/conference/12312312312/attendance`, {
//     "success": true,
//     "content|1-5": [
//         {
//             "begin_date": Random.datetime('yyyy-MM-dd A'),
//             "begin_time": Random.time('HH:mm:ss'),
//             "end_time": Random.time('HH:mm:ss'),
//             "attendance_result": Random.signStat(),
//             "arrival_time": Random.datetime('yyyy-MM-dd HH:mm:ss')
//         }
//     ]
// });
/**
 * 获取就餐记录
 * @param params
 * @returns {AxiosPromise<any>}
 */
// Mock.mock(`${baseUrl}/api/conference/12312312312/meal`, {
//     "success": true,
//     "content|1-5": [
//         {
//             "begin_date": Random.datetime('yyyy-MM-dd A'),
//             "begin_time": Random.time('HH:mm:ss'),
//             "end_time": Random.time('HH:mm:ss'),
//             "location": Random.cword(5, 30),
//             "meal_time": Random.datetime('yyyy-MM-dd HH:mm:ss')
//         }
//     ]
// });
/**
 * 提交就餐记录
 * @param params
 * @returns {AxiosPromise<any>}
 */
// Random.extend({
//     // 扩展餐馆状态随机值
//     meal_status: function () {
//         var stats = ['REST', 'OPEN']
//         return this.pick(stats)
//     },
//     // 扩展能否订餐随机值
//     meal_reserve: function () {
//         var stats = ['Y', 'N']
//         return this.pick(stats)
//     },
// })
// Mock.mock(`${baseUrl}/api/conference/12312312312/meal?meal_id=123123123`, {
//     "success": true,
//     "conference_title": Random.cword(5, 10),
//     "compellation": Random.cword(2, 6),
//     "mobile": Random.natural(11),
//     "meal_status": Random.meal_status(),
//     "meal_location": Random.cword(5, 30),
//     "meal_reserve": Random.meal_reserve(),
//     "total_scan": Random.natural()
// });
/**
 * 提交签到记录
 * @param params
 * @returns {AxiosPromise<any>}
 */
// Random.extend({
//     // 扩展签到状态随机值
//     attendance_result: function () {
//         var stats = ['Y', 'C', 'W']
//         return this.pick(stats)
//     },
// })
// Mock.mock(`${baseUrl}/api/conference/12312312312/attendance?attendance_id=123123123`, {
//     "success": true,
//     "conference_title": Random.cword(5, 10),
//     "compellation": Random.cword(2, 6),
//     "mobile": Random.natural(11),
//     "begin_time": Random.datetime('yyyy-MM-dd HH:mm:ss'),
//     "end_time": Random.datetime('yyyy-MM-dd HH:mm:ss'),
//     "arrival_time": Random.time('HH:mm:ss'),
//     "attendance_result": Random.attendance_result()
// });