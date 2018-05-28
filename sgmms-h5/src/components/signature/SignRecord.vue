<template>
    <div id="signrecord">
        <card-preview v-for="item in recordData" :key="item.arrival_time" :title="item.begin_date" icon="iconfont icon-activity" :statText="getStatName(item.attendance_result)" :statColor="item.attendance_result">
            <card-item icon="iconfont icon-time" label="考勤时间: " :value="item.begin_time">
                <span class="card_content_data">～{{item.end_time}}</span>
            </card-item>
            <card-item icon="iconfont icon-yuding" label="您的签到时间: " :value="item.arrival_time"></card-item>
        </card-preview>
    </div>
</template>

<script>
    import { CardPreview, CardItem } from '@cmpt/card'
    import { getSignStatName } from '@util/constants'
    import { getSignRecord } from '@api/api'
    export default {
        data() {
            return {
                conference_no: this.$route.params.conference_no,
                recordData: null,
            }
        },
        components: {
            CardPreview,
            CardItem
        },
        methods: {
            getSignRecord() {
                getSignRecord(this.conference_no).then(res => {
                    this.recordData = res.content;
                }).catch(err=>{
                    this.$toast(err.message)
                })
            },
            getStatName(value){
                return getSignStatName(value)
            }
        },
        mounted() {
            this.getSignRecord()
        }
    }
</script>

<style>
</style>