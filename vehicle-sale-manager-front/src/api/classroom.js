import http from '@http/http'

export const getClassroom = (errMsg) => {
  return http.GET('/api/room/get')
} // 获取教室列表

export const getTermInfo = (errMsg) => {
  return http.GET('/api/setting/get')
} // 获取当前最新学期信息

export const toggleClassroom = (id, enabled, errMsg) => {
  return http.POST('/api/room/updateState', {id: id, enabled: enabled})
} // 修改教室启用状态

export const addClassroom = (name, errMsg) => {
  return http.POST('/api/room/add', {name: name})
} // 添加咨询室

export const updateClassroom = (id, name, errMsg) => {
  return http.POST('/api/room/update', {id: id, name: name})
} // 修改咨询室信息

export const delClassroom = (id, errMsg) => {
  return http.POST('/api/room/delete', {id: id})
} // 删除咨询室

export const setDuration = (semester, firstVisitTime, consultationTime, semesterStartDate, semesterEndDate, errMsg) => {
  console.log({semester: semester, firstVisitTime: firstVisitTime, consultationTime: consultationTime, semesterStartDate: semesterStartDate, semesterEndDate: semesterEndDate})
  return http.POST('/api/setting/add', {semester: semester, firstVisitTime: firstVisitTime, consultationTime: consultationTime, semesterStartDate: semesterStartDate, semesterEndDate: semesterEndDate})
} // 新学期设置
