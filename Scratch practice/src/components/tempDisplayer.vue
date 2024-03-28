<template>

<div class="displayer">
    <div>
        <span class="name">{{ props.name }}</span>
        <span class="time">最後更新時間:<br>{{ props.time.replace("T", " ").split(".")[0] }}</span>
    </div>
    
    <donutChart max="40" min="0" :value="props.temp" color-change-mode="true">{{ Number(props.temp).toFixed(2) + "℃" }}</donutChart>
    <donutChart max="100" min="0" :value="props.water">{{ Number(props.water).toFixed(2) + "%" }}</donutChart>
</div>

</template>

<script setup>
import donutChart from './donutChart.vue';
import { defineProps } from 'vue';

const props = defineProps({
    temp:{
        type: Number,
        default: 20
    },
    water:{
        type: Number,
        default: 50
    },
    time:{
        type: String,
        default: "xxxx-xx-xx"
    },
    name:{
        type: String,
        default: "未命名"
    }
})

</script>

<style>

.displayer{
    /* background: rgb(241, 245, 248); */
    background: white;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    border-radius: 1rem;
    padding: 1rem;
    display: grid;
    gap: 0.5rem;
    grid-template-columns: 1fr 1fr 1fr;
    transition: 0.2s;
    margin-bottom: 1rem;
}
/* 
.displayer:hover{
    opacity: 0.8;
} 
*/

.displayer .name{
    color: rgb(60, 60, 60);
    font-size: bold;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.displayer .time{
    color: rgb(150, 150, 150);
    font-weight: lighter;
    font-size: 0.5rem;
}

</style>