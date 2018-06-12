// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import { Toast,InfiniteScroll } from 'mint-ui'
import { Auth } from './util/dataHandle.js'

import 'mint-ui/lib/style.css'
import '@style/common/reset.less'// 重置浏览器样式以及mint样式替换
import '@style/iconfont/iconfont.css'// 字体图标样式文件
Vue.config.productionTip = false

Vue.prototype.$toast = Toast;
Vue.use(InfiniteScroll)

// 路由没配noLogin(需要登录)的都判断是否有token。若无则跳转登录页面
router.beforeEach(function (to, from, next) {
  if(!to.meta.noLogin && !Auth.getToken()){
    Toast('未登录')
    setTimeout(() => {
      next({
        path:'/login'
      })
    }, 1000);
  }
  next()
});

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { 
    App,
    Toast},
  template: '<App/>'
})
