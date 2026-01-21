import { _getUserInfo } from '../../../api/user'
import types from './types'
import { _getLocalStorage } from '../../../tools/utils'
export default {
  async fetchUserInfo({ commit }) {
    let res = await _getUserInfo()
    return res
  },
  async fetchUserInfo2({ commit }) {
    commit(types.SET_USER_ID, _getLocalStorage('id'))
    commit(types.SET_USER_NAME, _getLocalStorage('name'))
    commit(types.SET_USER_TYPE, _getLocalStorage('type'))
    return { status: true, code: 70005 }
  }
}
