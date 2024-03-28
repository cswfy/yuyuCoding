<template>
    <span class="donut-chart" style="--c:#40aafc; --p:80" ref="chart">
        <span class="center">
            <span class="text">
                <slot></slot>
            </span>
        </span>
   </span>
</template>

<script setup>
import { defineProps, onMounted, ref, watch } from 'vue';

const props = defineProps({
    max: Number,
    min: Number,
    value: Number,
    colorChangeMode: Boolean
})

const chart = ref();
console.log(props.value/(props.max-props.min) * 100)

onMounted(()=>{
    changeDonutChart();
})

const changeDonutChart = ()=>{
    let p = (props.value-props.min)/(props.max-props.min);
    chart.value.style.setProperty("--p", p * 100);
    if(props.colorChangeMode)
        chart.value.style.setProperty("--c", 'hsl('+ Math.floor(230-250*p) +'deg, 100%, 50%)');

}

watch(()=>props.value, (newVal)=>{
    console.log(newVal)
    changeDonutChart();
})

</script>

<style>

.donut-chart{
    position: relative;
    display: block;
    height: 100%;
    aspect-ratio: 1/1;
    background: conic-gradient(var(--c) calc((var(--p) + 1)*1%),transparent 0);
    border-radius: 50%;
    overflow: hidden;
}

.donut-chart .center{
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    display: block;
    background: white;
    border-radius: 50%;
    width: 80%;
    aspect-ratio: 1/1;
    text-align: center;
}

.donut-chart .center .text{
    position: absolute;
    top: 50%;
    left: 50%;
    color: rgb(60, 60, 60);
    transform: translate(-50%, -50%);
    font-weight: bold;
    user-select: none;
}
	
</style>