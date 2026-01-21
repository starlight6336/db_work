import http from '@http/http'
import user from '../store/modules/user'

export const _getUserInfo = (id, errMsg) => http.GET('/api/user/userInfo', {id: user.state.id}, errMsg)

export const userLogin = user => {
  return http.POST('/api/user/login', user)
}
