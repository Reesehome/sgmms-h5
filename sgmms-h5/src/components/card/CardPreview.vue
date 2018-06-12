<template>
    <transition :name="transition">  
        <section class="card line-tb" @click="jumpToDetail">
            <div class="card_head">
                <i v-show="icon" :class="icon" class="col_theme"></i>
                {{title}}
            </div>
            <mark class="card_status line-all" v-show="statText" :class="statColor">{{statText}}</mark>
            <div class="card_content">
                <slot></slot>
            </div>
        </section>
    </transition>
</template>

<script>
    export default {
        name: 'card-preview',
        props: {
            title: {
                type: String,
                default: '默认标题'
            },
            icon: {
                type: String,
                default: ''
            },
            statText: {
                type: String,
                default: ''
            },
            statColor:{
                type: String,
                default: ''
            },
            transition: String,
        },
        methods: {
            jumpToDetail() {
                this.$emit('jumpToDetail')
            },
        }
    }
</script>

<style lang="less" scoped>
    @import url('../../assets/styles/common/style.less');
</style>