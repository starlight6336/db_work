import http from '@http/http'

export const getConsultSchedule = (id, errMsg) => {
  return http.GET('/api/arrangement/get', {id: id})
}
export const getConsultDuration = (errMsg) => {
  return http.GET('/api/setting/getConsultationTime')
}
export const insertConsultSchedule = (id, time1, time2, weekday, errMsg) => {
  return http.POST('/api/arrangement/addConsultation', {uid: id, dayOfWeek: weekday, startTime: time1, endTime: time2})
}

export const delConsultSchedule = (scheduleID, errMsg) => {
  return http.POST('/api/arrangement/deleteConsult', {id: scheduleID})
}
// 初访员的

export const getPreCheckSchedule = (id, errMsg) => {
  return http.GET('/api/arrangement/get', {id: id})
}
export const getPreCheckDuration = (errMsg) => {
  return http.GET('/api/setting/getFirstVisitTime')
}
export const insertPreCheckSchedule = (id, time1, time2, weekday, errMsg) => {
  return http.POST('/api/arrangement/addFirst', {uid: id, dayOfWeek: weekday, startTime: time1, endTime: time2})
}

export const delPreCheckSchedule = (scheduleID, errMsg) => {
  return http.POST('/api/arrangement/deleteFirst', {id: scheduleID})
}
