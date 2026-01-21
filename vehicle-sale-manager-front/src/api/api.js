import http from '@http/http'

export const getAllPreVisitList = (errMsg) => {
  return http.GET('/api/firstVisit/all', {facility: '', parm: '', teachername: '', state: '', conclusion: ''})
} // 初访列表
export const getPreVisitList = (json, errMsg) => {
  return http.GET('/api/firstVisit/all', json)
} // 初访列表
export const getPreVisitDetailByID = (id, errMsg) => {
  return http.GET('/api/firstVisit/getInfo', {id: id})
} // 查看初访详情
export const getQuestionPool = (errMsg) => {
  return http.GET('/api/question/questionlist')
} // 所有问题

export const getAllConsultList = (errMsg) => {
  return http.GET('/api/consultation/consultlist', {danger: '', parm: '', problem: '', disease: '', state: '', facility: '', teachername: ''})
} // 咨询列表
export const getConsultList = (json, errMsg) => {
  if (json.temp[1] === undefined) {
    return http.GET('/api/consultation/consultlist', {danger: json.danger, parm: json.parm, problem: json.temp[0], state: json.state, facility: json.facility, teachername: json.teachername})
  }
  return http.GET('/api/consultation/consultlist', {danger: json.danger, parm: json.parm, problem: json.temp[0], disease: json.temp[1], state: json.state, facility: json.facility, teachername: json.teachername})
} // 咨询列表
export const getConsultDetailByID = (id, errMsg) => {
  return http.GET('/api/consultation/getInfo', {id: id})
} // 查看咨询详情

export const getConsultRecordList = (id, errMsg) => {
  return http.GET('/api/consultationRecord/list', {id: id})
} // 获取咨询记录列表

export const getExtendRequest = (errMsg) => {
  return http.GET('/api/consultationExtendRequest/list')
} // 获取待审核列表

export const updateExtendRequest = (id, state, errMsg) => {
  return http.POST('/api/consultationExtendRequest/update', {id: id, state: state})
}
