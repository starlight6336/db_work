import http from '@http/http'
export const getAvailablePreVisitTimeByFID = (id, errMsg) => {
  return http.GET('/api/arrangement/getFirstVisitTimes', {id: id})
} // 获取所有可用访问时间

export const getAvailableTeacherByDateTimeDay = (arrDate, wkd, time1, time2, errMsg) => {
  return http.GET('/api/user/getFreeTeachers', {arrangementDate: arrDate, dayOfWeek: wkd, startTime: time1, endTime: time2})
} // 获取指定时段空闲老师

export const getAvailableRoomByDateTimeDay = (arrDate, wkd, time1, time2, errMsg) => {
  return http.GET('/api/room/getFreeRooms', {arrangementDate: arrDate, dayOfWeek: wkd, startTime: time1, endTime: time2})
} // 获取指定时段空闲教室

export const addNewPreVisitArrange = (arrDate, wkd, time1, time2, teacherID, visitID, roomID, errMsg) => {
  return http.POST('/api/firstVisit/arrange', {arrangementDate: arrDate, dayOfWeek: wkd, startTime: time1, endTime: time2, uid: teacherID, rid: roomID, fid: visitID})
} // 添加初访安排

export const rejectManagementByFID = (fid, errMsg) => {
  return http.POST('/api/firstVisit/refuse', {id: fid})
} // 拒绝安排初访

export const getDuty = (errMsg) => {
  return http.GET('/api/arrangement/firstVisitTable')
} // 获取初访时间表

export const cancelManagementByFID = (fid, errMsg) => {
  return http.POST('/api/firstVisit/cancel', {id: fid})
}
export const getTime = (errMsg) => {
  return http.GET('/api/arrangement/consultTable')
} // 获取咨询时间表

export const getAvailableConsultTimeByFID = (id, errMsg) => {
  return http.GET('/api/arrangement/getConsultTimes', {id: id})
} // 获取所有可用咨询时间

export const getAvailableConsultTeacherByDateTimeDay = (arrDate, wkd, time1, time2, errMsg) => {
  return http.GET('/api/user/getConsultTeachers', {arrangementDate: arrDate, dayOfWeek: wkd, startTime: time1, endTime: time2})
} // 获取指定时段咨询空闲老师

export const getAvailableConsultRoomByDateTimeDay = (arrDate, wkd, time1, time2, errMsg) => {
  return http.GET('/api/room/getConsultRooms', {arrangementDate: arrDate, dayOfWeek: wkd, startTime: time1, endTime: time2})
} // 获取指定时段咨询空闲教室

export const addNewConsultArrange = (arrangementDate, dayOfWeek, startTime, endTime, uid, rid, cid, errMsg) => {
  return http.POST('/api/consultation/arrange', {arrangementDate: arrangementDate, dayOfWeek: dayOfWeek, startTime: startTime, endTime: endTime, uid: uid, rid: rid, cid: cid})
} // 添加咨询安排

export const getConsult = (errMsg) => {
  return http.GET('/api/arrangement/consultTable')
} // 获取初访时间表
