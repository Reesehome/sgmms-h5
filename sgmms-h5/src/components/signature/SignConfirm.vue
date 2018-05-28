<template>
    <div id="signconfirm">
        <card-preview :title="signData.conference_title" icon="iconfont icon-youji" v-if="signData">
            <card-item icon="iconfont icon-people" label="姓名: " :value="signData.compellation"></card-item>
            <card-item icon="iconfont icon-mobilephone" label="电话: " :value="signData.mobile"></card-item>
            <card-item icon="iconfont icon-time" label="考勤时间段: " :value="signData.begin_time">
                <span class="card_content_data">～{{signData.end_time}}</span>
            </card-item>
        </card-preview>
        <section class="scanConfirm line-tb" v-if="signData">
            <p class="sign_date">
                <i class="iconfont icon-activity"></i>{{curDate}}</p>
            <!-- 可签到 -->
            <div v-show="signStat">
                <div class="tips_welcome" :class="{'bg_org':signData.attendance_result === 'C'}">
                    <span>{{signStat}}
                        <br>{{signData.arrival_time}}</span>
                </div>
                <p class="sign_add">
                    <i class="iconfont icon-coordinates"></i>{{params.location}}</p>
            </div>
            <!-- 未到考勤时间 -->
            <p v-show="!signStat" class="tips_err">
                <i class="iconfont icon-prompt"></i>
                请在考勤时间段签到</p>
        </section>
        <!-- 业务关系，将子组件写在父组件里 -->
        <!-- <inline-map @geoInfo="getGeoInfo"></inline-map> -->
        <div id="inlineMap"></div>
    </div>
</template>

<script>
    import { CardPreview, CardItem } from '@cmpt/card'
    import { postSign } from '@api/api'
    import { DateHandle } from '@util/dataHandle'
    import { InlineMap } from '@cmpt/map'

    export default {
        data() {
            return {
                params: {
                    conference_no: this.$route.query.cf,
                    attendance_id: this.$route.query.at,
                    lat: 0,//纬度
                    lng: 0,//经度
                    location: '获取不到用户位置'
                },
                signData: null,
                curDate: DateHandle.GetToday(),
                signStat: '',
            }
        },
        components: {
            CardPreview,
            CardItem,
            InlineMap,
        },
        methods: {
            postSign() {
                postSign(this.params).then(res => {
                    this.signData = res
                    // 处理会议状态，只有openning才有签到状态
                    if (this.signData.attendance_status === 'OPENING') {
                        // 处理签到状态
                        switch (this.signData.attendance_result) {
                            case 'Y':
                            this.signStat = '已签到'
                                break;
                            case 'C':
                            this.signStat = '迟到'
                                break;
                            case 'W':
                            this.signStat = false
                                break;
                        }
                        return;
                    }
                    this.signStat = false
                }).catch(err => {
                    this.$toast(err.message)
                })
            },
            getLocation(resolve, reject) {
                let _this = this;
                // 创建map实例
                var map = new BMap.Map("inlineMap");
                var geolocation = new BMap.Geolocation();
                // 开启SDK辅助定位
                geolocation.enableSDKLocation();
                geolocation.getCurrentPosition(function (r) {
                    if (this.getStatus() == BMAP_STATUS_SUCCESS) {
                        resolve({
                            location: r.address.province + r.address.city + r.address.district + r.address.street + r.address.street_number,
                            lat: r.point.lat,
                            lng: r.point.lng
                        });
                    }
                    else {
                        reject('failed' + this.getStatus())
                    }
                });
            },
        },
        mounted() {
            // 先查百度地图api获取用户地址，再发送请求
            new Promise(this.getLocation).then(res => {
                Object.assign(this.params, res)
                this.postSign()
            }, err => {
                this.$toast(err)
            })
        }
    }
</script>

<style lang="less" scoped>
    @import url('../../assets/styles/meeting/mylist.less');
    @import url('../../assets/styles/signature/signconfirm.less');
</style>