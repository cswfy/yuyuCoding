import axios from 'axios'
import {host,port} from '@/apis/constant.js'

export function createOrderData(username,token){
  return axios.post(`http://${host()}:${port()}/userorder`,{
    "username":username
  },{
    headers:{
      "AUTHORIZATION":token
    }
  })
}