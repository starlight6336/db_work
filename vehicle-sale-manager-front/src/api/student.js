import http from '@http/http'

export const getReservationInfoByID = (id, errMsg) => {
  return http.GET('/api/user/reservationInfo', {id: id})
}

export const getReservationInfoByFID = (id, fid, errMsg) => {
  console.log(id)
  console.log(fid)
  return http.GET('/api/user/reservationInfo', {id: id, fid: fid})
}

export const saveDraft = (json, errMsg) => {
  console.log(json)
  return http.POST('api/firstVisit/draft', json)
}

export const getAvailableTimePeriods = (errMsg) => {
  return http.GET('/api/arrangement/reserveTimes')
}

export const submit = (json, errMsg) => {
  return http.POST('/api/firstVisit/reserve', json)
}
export const cancelByID = (id, errMsg) => {
  return http.POST('/api/firstVisit/cancelReservation', {id: id})
}
export const delDraftByID = (id, errMsg) => {
  return http.POST('/api/firstVisit/delete', {id: id})
}
export const getMyArrages = (id, errMsg) => {
  return http.GET('/api/user/myappointment', {stuid: id})
}
export const acceptThisShitByUsingFuckingFID = (id, errMsg) => {
  return http.POST('/api/firstVisit/accept', {id: id})
}
export const rejectThisShitByUsingFuckingFID = (id, errMsg) => {
  return http.POST('/api/firstVisit/wait', {id: id})
}
export const IGiveUpThisShitByUsingFuckingFID = (id, errMsg) => {
  return http.POST('/api/firstVisit/quit', {id: id})
}
export const checkIfCanContinue = (id, errMsg) => {
  return http.GET('/api/user/check', {id: id})
}

export const getTeacher = (errMsg) => {
  return http.GET('/api/user/allcounselor')
}
