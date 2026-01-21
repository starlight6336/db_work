import axios from 'axios'
import Vue from 'vue'
import { Message } from 'element-ui'
import NProgress from 'nprogress'

axios.defaults.baseURL = process.env.BASE_URL
axios.interceptors.request.use(config => {
  NProgress.start()
  return config
}, error => {
  return Promise.reject(error)
})

axios.interceptors.response.use(response => response, error => Promise.resolve(error.response))

function checkStatus(response) {
  NProgress.done()
  if (response.status === 200 || response.status === 304) {
    return response
  }
  // 尝试解析响应体，获取后端返回的具体错误信息
  try {
    if (response.data) {
      return {
        data: {
          code: -1,
          status: false,
          message: response.data.message || response.statusText,
          data: response.data.message || response.statusText
        }
      }
    }
  } catch (e) {
    // 解析失败，使用默认错误信息
  }
  if (response.status >= 500) {
    return {
      data: {
        code: -500,
        status: false,
        message: response.statusText,
        data: response.statusText
      }
    }
  }
  return {
    data: {
      code: -404,
      status: false,
      message: response.statusText,
      data: response.statusText
    }
  }
}

function checkCode(res, errMsg) {
  if (!res.data.status) {
    switch (res.data.code) {
      case -404:
        Message.error(res.data.message || '未知异常')
        break
      case -500:
        // 显示后端返回的具体错误信息，而不是固定的错误信息
        Message.error(res.data.message || '服务器连接错误！')
        break
      case 70005:
        Message.error('您需要重新登录！')
        break
      default:
        errMsg ? Message.error(errMsg) : Message.error(res.data.message || '未知异常')
    }
  }
  return res.data
}

export default {
  POST(url, data, errMsg) {
    const CancelToken = axios.CancelToken
    return axios.post(url, data, {
      timeout: 30000,
      cancelToken: new CancelToken(function executor(c) {
        Vue.$httpRequestList.push(c)
      })
    }).then(checkStatus).then(res => checkCode(res, errMsg))
  },
  GET(url, params, errMsg) {
    const CancelToken = axios.CancelToken
    return axios.get(url, {
      params: {
        _t: +(new Date()),
        ...params
      },
      timeout: 30000,
      cancelToken: new CancelToken(function executor(c) {
        Vue.$httpRequestList.push(c)
      })
    }).then(checkStatus).then(res => checkCode(res, errMsg))
  },
  DELETE(url, errMsg) {
    const CancelToken = axios.CancelToken
    return axios.delete(url, {
      timeout: 30000,
      cancelToken: new CancelToken(function executor(c) {
        Vue.$httpRequestList.push(c)
      })
    }).then(checkStatus).then(res => checkCode(res, errMsg))
  },
  PUT(url, data, errMsg) {
    const CancelToken = axios.CancelToken
    return axios.put(url, data, {
      timeout: 30000,
      cancelToken: new CancelToken(function executor(c) {
        Vue.$httpRequestList.push(c)
      })
    }).then(checkStatus).then(res => checkCode(res, errMsg))
  },
  EXPORT(url, data, errMsg) {
    const CancelToken = axios.CancelToken
    return axios.post(url, data, {
      responseType: 'blob',
      timeout: 30000,
      cancelToken: new CancelToken(function executor(c) {
        Vue.$httpRequestList.push(c)
      })
    }).then(checkStatus).then(res => res.data)
  }
}
