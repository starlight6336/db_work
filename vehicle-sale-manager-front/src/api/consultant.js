import http from '@http/http'
export const getAllMyConsultList = (id, errMsg) => {
  return http.GET('/api/consultation/consultmanagelist', {teacherid: id, theme: '', danger: '', problem: '', disease: '', parm: '', facility: '', conclusion: '', state: ''})
} // 初访列表
export const getMyConsultList = (teacherid, theme, danger, problem, disease, parm, facility, conclusion, state, errMsg) => {
  return http.GET('/api/consultation/consultmanagelist', {teacherid: teacherid, theme: theme, danger: danger, problem: problem, disease: disease, parm: parm, facility: facility, conclusion: conclusion, state: state})
}

export const startConsult = (id) => {
  return http.POST('/api/consultation/start', {id: id})
}

export const saveConsultConclusion = (json) => {
  console.log(json)
  return http.POST('/api/consultation/start', json)
}
export const applyforAddition = (cid, times, reason, errMsg) => {
  console.log({cid: cid, times: times, reason: reason})
  return http.POST('/api/consultationExtendRequest/request', {cid: cid, times: times, reason: reason})
}
export const updatePiece = (id, result, record, consultDate, startTime, endTime, errMsg) => {
  console.log({id: id, result: result, record: record, consultDate: consultDate, startTime: startTime, endTime: endTime})
  return http.POST('/api/consultationRecord/update', {id: id, result: result, record: record, consultDate: consultDate, startTime: startTime, endTime: endTime})
}
export const getConsultConclusion = (id, errMsg) => {
  return http.GET('/api/consultation/getInfo', {id: id})
}
export const getConsultList = (id, errMsg) => {
  return http.GET('/api/consultationRecord/list', {id: id})
}

export const getApplyResp = (id, errMsg) => {
  return http.GET('/api/consultationExtendRequest/result', {id: id})
}
export const endReport = (id, detail, errMsg) => {
  return http.POST('/api/consultation/end', {id: id, detail: detail})
}
