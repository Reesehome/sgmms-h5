<template>
    <div id="mealrecord">
        <card-preview v-for="item in mealRecordData" :key="item.meal_time" :title="item.begin_date" icon="iconfont icon-activity">
            <card-item icon="iconfont icon-time" label="就餐时间: " :value="item.begin_time">
                <span class="card_content_data">～{{item.end_time}}</span>
            </card-item>
            <card-item icon="iconfont icon-coordinates" label="就餐地点: " :value="item.location"></card-item>
            <card-item icon="iconfont icon-yuding" label="您的就餐时间: " :value="item.meal_time" v-show="item.meal_time"></card-item>
            <card-item icon="iconfont icon-wucan" label="就餐状态: " value="已就餐"  v-show="item.meal_time"><i class="iconfont icon-success_fill col_green"></i></card-item>
            <card-item icon="iconfont icon-wucan" label="就餐状态: " value="未就餐"  v-show="!item.meal_time"><i class="iconfont icon-offline_fill col_red"></i></card-item>
        </card-preview>
    </div>
</template>

<script>
    import { CardPreview, CardItem } from '@cmpt/card'
    import { getMealRecord } from '@api/api'
    export default {
        data() {
            return {
                conference_no: this.$route.params.conference_no,
                mealsuccess: true,
                mealRecordData: null,
            }
        },
        components: {
            CardPreview,
            CardItem
        },
        methods: {
            getMealRecord(){
                getMealRecord(this.conference_no).then(res=>{
                    this.mealRecordData = res.content
                }).catch(err=>{
                    this.$toast(err.message)
                })
            }
        },
        mounted(){
            this.getMealRecord()
        }
    }

</script>

<style lang="less" scoped>
</style>