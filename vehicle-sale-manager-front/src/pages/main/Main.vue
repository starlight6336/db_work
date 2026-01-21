<template>
  <suncaper-layout
    theme="dark"
    :logo="logo"
    :sidebar-list="sidebarList"
    :logout="logout"
  />
</template>

<script>
import {mapGetters} from 'vuex'
import Layout from '@/layouts/Layout'
import logo from '@/assets/images/logo.png'
import user from '../../store/modules/user'
import {_clearStorage} from '../../tools/utils'

export default {
  name: 'Main',
  data () {
    return {
      logo: {
        src: logo,
        alt: '♥',
        firstDes: '新能源汽车销售',
        secondDes: ''
      }
    }
  },
  computed: {
    ...mapGetters({
      userType: 'user/getUserType',
      getSidebarList: 'sidebar/getSidebarList'
    }),
    sidebarList () {
      return this.getSidebarList(this.userType).main
    }
  },
  methods: {
    logout () {
      user.state.id = null
      user.state.type = null
      user.state.loginName = null
      _clearStorage()
      this.$router.push({path: '/login'})
      this.$message.info('已退出登录')
    }
  },
  components: {
    'suncaper-layout': Layout
  }
}
</script>
