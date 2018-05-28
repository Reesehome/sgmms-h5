<template>
    <div id="inlineMap">
    </div>
</template>

<script>
    export default {
        name: 'inline-map',
        data() {
            return {
                geoInfo: {},
            }
        },
        methods: {
            // H5 地理的实现
            // init() {
            //     if (navigator.geolocation) {
            //         navigator.geolocation.getCurrentPosition(this.locationSuccess, this.locationError, {
            //             // 指示浏览器获取高精度的位置，默认为false  
            //             enableHighAccuracy: true,
            //             // 指定获取地理位置的超时时间，默认不限时，单位为毫秒  
            //             timeout: 5000,
            //             // 最长有效期，在重复获取地理位置时，此参数指定多久再次获取位置。  
            //             maximumAge: 3000
            //         });
            //     } else {
            //         alert("您浏览器不支持定位，请联系工作人员");
            //     }
            // },
            // locationError(error) {
            //     switch (error.code) {
            //         case error.TIMEOUT:
            //             Toast("请求获取用户位置超时");
            //             break;
            //         case error.POSITION_UNAVAILABLE:
            //             Toast('位置信息不可用');
            //             break;
            //         case error.PERMISSION_DENIED:
            //             Toast('用户拒绝请求地理定位');
            //             break;
            //         case error.UNKNOWN_ERROR:
            //             Toast('定位系统失效');
            //             break;
            //     }
            // }
            sendToParent(value) {
                this.$emit('geoInfo', value)
            },
            locationSuccess() {
                // let script = document.createElement("script")
                // script.src = "http://api.map.baidu.com/getscript?v=2.0&ak=qdcpFIpf64o2xBOKoQkpeN58A75qjMYq&services=&t=20180514182253"
                // document.body.appendChild(script)

                let _this = this;
                // 创建map实例
                let map = new BMap.Map("inlineMap");
                //绘制地图
                // let point = new BMap.Point(118, 39.897445);
                // map.centerAndZoom(point, 12);
                let geolocation = new BMap.Geolocation();
                geolocation.getCurrentPosition(function (r) {
                    if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                        _this.sendToParent(r)
                        // 绘制地图上的点
                        // let mk = new BMap.Marker(r.point);
                        // map.addOverlay(mk);
                        // map.panTo(r.point);
                    }
                    else {
                        alert('failed' + this.getStatus());
                    }
                }, { enableHighAccuracy: true })
            },
        },
        mounted() {
            this.locationSuccess()
        },
        beforeDestroy() {
            // 清除baidumap js文件引入
            // let s = document.getElementsByTagName('script');
            // document.body.removeChild(s[s.length - 1])
        }
    }
</script>

<style>
</style>