<template>
    <div id="mealconfirm" v-if="mealData">
        <card-preview :title="mealData.conference_title" icon="iconfont icon-youji">
            <card-item icon="iconfont icon-people" label="姓名: " :value="mealData.compellation"></card-item>
            <card-item icon="iconfont icon-mobilephone" label="电话: " :value="mealData.mobile"></card-item>
            <card-item icon="iconfont icon-wucan" label="就餐地点: " :value="mealData.meal_location"></card-item>
        </card-preview>
        <section class="scanConfirm line-tb">
            <!-- 可以就餐 -->
            <div v-show="mealStat && mealReserve">
                <div class="tips_welcome tips_pic">欢迎就餐!</div>
                <p class="tips_times" >第{{mealData.total_scan}}次扫码</p>
            </div>
            
            <!-- 没有订餐记录 -->
            <div v-show="mealStat && !mealReserve">
                <div class="tips_norecord tips_pic"></div>
                <p class="tips_err">
                    <i class="iconfont icon-prompt"></i> 
                    没有您的订餐记录，请联系主办方</p>
            </div>
            
            <!-- 没到时间 -->
            <div v-show="!mealStat">
                <div class="tips_untimely tips_pic"></div>
                <p class="tips_err" v-show="!mealStat">
                    <i class="iconfont icon-prompt"></i> 
                    非用餐时间，请在用餐时间就餐</p>
            </div>
        </section>
    </div>
</template>

<script>
    import { CardPreview, CardItem } from '@cmpt/card'
    import { postMeal } from '@api/api'
    
    export default {
        data() {
            return {
                params:{
                    conference_no: this.$route.query.cf,
                    meal_id: this.$route.query.ml,
                },
                mealStat: true,// true:营业中,false:休息
                mealReserve: true,// true:有订餐,false:没订餐
                mealData: null,
            }
        },
        components: {
            CardPreview,
            CardItem
        },
        methods:{
            postMeal(){
                postMeal(this.params).then(res=>{
                    this.mealData = res
                    // 转换数据
                    this.mealStat = this.mealData.meal_status == 'OPEN' ? true : false                    
                    this.mealReserve = this.mealData.meal_reserve == 'Y' ? true : false                    
                }).catch(err=>{
                    this.$toast(err.message)
                })
            },
        },
        mounted(){
            this.postMeal()
        }
    }
</script>

<style lang="less" scoped>
    @import url('../../assets/styles/meeting/mylist.less');
    @import url('../../assets/styles/meal/mealconfirm.less');
</style>