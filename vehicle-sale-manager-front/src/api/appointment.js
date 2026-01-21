import http from '@http/http'

export const getFirstVisitInfo = (facility, selfemergency, theme, parm, errMsg) => {
  console.log({facility: facility, selfemergency: selfemergency, theme: theme, parm: parm})
  return http.GET('/api/firstVisit/allappointment', {
    facility: facility,
    selfemergency: selfemergency,
    theme: theme,
    parm: parm
  })
} // 获取初访预约列表
export const getAllFirstVisitInfo = (errMsg) => {
  return http.GET('/api/firstVisit/allappointment', {
    facility: '',
    selfemergency: '',
    theme: '',
    parm: ''
  })
} // 获取初访预约列表

export const getSuccessAppointment = (theme, selfemergency, parm, facility, state, errMsg) => {
  return http.GET('/api/firstVisit/successappointment', {
    theme: theme,
    selfemergency: selfemergency,
    parm: parm,
    facility: facility,
    state: state
  })
} // 预约成功列表

export const getAllSuccessAppointment = (errMsg) => {
  return http.GET('/api/firstVisit/successappointment', {
    theme: '',
    selfemergency: '',
    parm: '',
    facility: '',
    state: ''
  })
} // 预约成功列表
