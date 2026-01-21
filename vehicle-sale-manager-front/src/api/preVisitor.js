import http from '@http/http'
export const getAllMyPreVisitList = (id, errMsg) => {
  return http.GET('/api/firstVisit/selectbyteacher', {teacherid: id})
} // 初访列表
export const getMyPreVisitList = (teacherid, theme, selfemergency, problem, disease, parm, facility, conclusion, state, errMsg) => {
  return http.GET('/api/firstVisit/selectbyteacher', {teacherid: teacherid, theme: theme, selfemergency: selfemergency, problem: problem, disease: disease, parm: parm, facility: facility, conclusion: conclusion, state: state})
}

export const startPreVisit = (id) => {
  return http.POST('/api/firstVisit/start', {id: id})
}

export const savePreVisitConclusion = (json) => {
  console.log(json)
  return http.POST('/api/firstVisit/end', json)
}
export const getConclusion = (id, errMsg) => {
  return http.GET('/api/firstVisit/getInfo', {id: id})
}
