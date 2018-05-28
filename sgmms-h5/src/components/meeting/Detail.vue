<template>
    <div id="meetingDetail">
        <card-preview title="基本信息" icon="iconfont icon-message" v-if="meetingData">
            <card-item icon="iconfont icon-youji" label="会议名称: " :value="meetingData.title"></card-item>
            <card-item icon="iconfont icon-time" label="开始时间: " :value="meetingData.begin_time"></card-item>
            <card-item icon="iconfont icon-time" label="结束时间: " :value="meetingData.end_time"></card-item>
            <card-item icon="iconfont icon-label" label="会议状态: " :value="meetingData.status"></card-item>
            <card-item icon="iconfont icon-group" label="会议人数: " :value="meetingData.total_users"></card-item>
            <card-item icon="iconfont icon-coordinates" label="会议地址: " :value="meetingData.venue"></card-item>
        </card-preview>
        <card-preview title="议程安排" icon="iconfont icon-createtask" v-if="meetingData.agendum">
            <p class="card_content_item" v-html="meetingData.agendum"></p>
        </card-preview>
        <card-preview title="注意事项" icon="iconfont icon-prompt" v-if="meetingData.attention">
            <p class="card_content_item" v-html="meetingData.attention"></p>
        </card-preview>
        <card-preview title="会议附件" icon="iconfont icon-fujian" v-if="meetingData.attachments&&meetingData.attachments.length>0">
            <a v-for="item in meetingData.attachments" :key="item.title" class="card_content_item attachments" :href="item.uri" :download="item.name">{{item.title}}</a>
        </card-preview>
    </div>
</template>

<script>
    import { CardPreview, CardItem } from '@cmpt/card'
    import { getMeetingDetail } from '@api/api'
    import { getMeetingStatName } from '@util/constants'
    
    export default {
        data() {
            return {
                conference_no: this.$route.params.conference_no,
                meetingData: {
                    agendum:null,
                    attention:null,
                    attachment:null
                }
            }
        },
        components: {
            CardPreview,
            CardItem
        },
        methods: {
            getMeetingDetail(){
                getMeetingDetail(this.conference_no).then(res=>{
                    this.meetingData = res;
                    this.meetingData.status = getMeetingStatName(this.meetingData.status)
                }).catch(err=>{
                    this.$toast(res.description)
                })
            }
        },
        mounted(){
            this.getMeetingDetail()
        }
    }
</script>

<style lang="less" scoped>
    @import url('../../assets/styles/meeting/detail.less');
</style>