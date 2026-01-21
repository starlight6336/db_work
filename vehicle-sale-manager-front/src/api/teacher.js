import http from '@http/http'

export const _getTeacherInfo = (keyword, errMsg) => {
  return http.GET('/api/teacherInfo/allTeacher', {parm: keyword})
} // 教师用户列表

export const _getTeacherInfoDetail = (id, errMsg) => {
  return http.GET('/api/teacherInfo/get', {id: id})
} // 教师详情信息

export const _getConsultants = (keyword, errMsg) => {
  return http.GET('/api/consultation/page', {parm: keyword})
} // 获取咨询师列表

export const updateTeacherInfo = (json, errMsg) => {
  return http.POST('/api/teacherInfo/update', json)
} // 修改教师信息

export const changeTeacherState = (teacherinfoid, state, errMsg) => {
  return http.POST('/api/teacherInfo/state', {teacherInfoId: teacherinfoid, state: state})
}

export const _getPreVisitor = (keyword, errMsg) => {
  return http.GET('/api/firstVisit/page', {parm: keyword})
} // 获取初访员列表

export const getUserAvatar = (file, errMsg) => {
  console.log(this.file)
  return http.POST('/api/file/upload', {file: file})
}

export const getAllConsultArrange = (errMsg) => {
  return http.GET('/api/consultation/consultarrangelist', {danger: '', parm: '', problem: '', disease: '', state: '', facility: '', conclusion: ''})
} // 查看咨询安排列表
export const getConsultArrange = (json, errMsg) => {
  if (json.temp[1] === undefined) {
    return http.GET('/api/consultation/consultarrangelist', {danger: json.danger, parm: json.parm, problem: json.temp[0], state: json.state, facility: json.facility, conclusion: json.conclusion})
  }
  return http.GET('/api/consultation/consultarrangelist', {danger: json.danger, parm: json.parm, problem: json.temp[0], disease: json.temp[1], state: json.state, facility: json.facility, conclusion: json.conclusion})
} // 查看咨询安排列表

export const getConsultArrangeByID = (id, errMsg) => {
  return http.GET('/api/consultation/getInfo', {id: id})
} // 查看咨询安排详情

export const getConsultResultByID = (id, errMsg) => {
  return http.GET('/api/consultation/arrangeResult', {id: id})
} // 查看咨询安排结果
