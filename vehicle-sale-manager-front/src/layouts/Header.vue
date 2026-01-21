<template>
  <div class="header">
    <div class="header-left">
      <a href="javascript:" class="header-icon" @click="collapseTrigger" role="button">
        <s-icon v-if="collapse" icon="suncaper-menu-fold" />
        <s-icon v-else icon="suncaper-menu-unfold" />
      </a>
      <span class="header-title text-center">欢迎您，{{ profile.name || userName }}</span>
    </div>
    <div class="header-right">
      <el-tooltip class="item" effect="dark" v-if="this.useflag === 0" content="您没有待审核信息" placement="bottom"
        style="margin: 4px">
        <i class="el-icon-bell"></i>
      </el-tooltip>
      <el-tooltip class="item" effect="dark" v-if="this.useflag === 1" placement="bottom" style="margin: 4px">
        <div slot="content">{{ '您有' + this.unsolvedcount + '条待审核信息' }}</div>
        <i class="el-icon-message-solid" style="color: red"></i>
      </el-tooltip>
      <div class="user-info" @click="showProfileDialog = true">
        <s-icon icon="suncaper-user" class="text-center" />
        <span class="text-center">
          {{ profile.name || userName }}
        </span>
      </div>
      <a href="javascript:" class="header-logout" @click="logout" role="button">
        <s-tooltip effect="dark" content="退出" placement="bottom">
          <s-icon icon="suncaper-quit" />
        </s-tooltip>
      </a>
    </div>

    <!-- 个人信息修改弹窗 -->
    <el-dialog title="个人信息修改" :visible.sync="showProfileDialog" width="500px">
      <el-form :model="profile" label-width="80px" size="small">
        <el-form-item label="姓名">
          <el-input v-model="profile.name" />
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="profile.phone" />
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="profile.address" />
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="showProfileDialog = false">取消</el-button>
        <el-button type="primary" @click="saveProfileInfo">保存</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import Icon from '@/components/Icon'
import { Tooltip } from 'element-ui'
import user from '../store/modules/user'
import { _clearStorage, _getLocalStorage } from '../tools/utils'
import { saveProfile, getProfile } from '../api/ev'

export default {
  data() {
    return {
      // 预留字段，后续如需增加新能源汽车相关通知可在此扩展
      toUseUserType: '',
      showProfileDialog: false,
      profile: {
        name: '',
        phone: '',
        address: ''
      }
    }
  },
  name: 's-header',
  props: {
    collapseTrigger: Function,
    collapse: Boolean,
    logout: Function,
    userName: String,
    roleName: String
  },
  computed: {
    userId() {
      return user.state.id
    }
  },
  created() {
    this.loadProfile()
  },
  components: {
    's-icon': Icon,
    's-tooltip': Tooltip
  },
  methods: {
    // eslint-disable-next-line vue/no-dupe-keys
    logout() {
      user.state.id = null
      user.state.type = null
      user.state.loginName = null
      _clearStorage()
      this.$router.push({ path: '/login' })
      this.$message.info('已退出登录')
    },
    async saveProfileInfo() {
      const res = await saveProfile({ ...this.profile, id: this.userId })
      if (res.status) {
        this.$message.success('个人信息已更新')
        this.showProfileDialog = false
      }
    },
    async loadProfile() {
      if (!this.userId) return
      const res = await getProfile(this.userId)
      if (res.status && res.data) {
        this.profile = { ...this.profile, ...res.data }
      }
    }
  }
}
</script>

<style lang="less" scoped>
@import "../assets/styles/var";

.header {
  width: 100%;
  height: 60px;
  padding: 0 23px;
  line-height: 59px;
  box-sizing: border-box;
  background: #ffffff;
  border-bottom: 1px solid @borderBottomColor;
  overflow: hidden;

  >span {
    vertical-align: middle;
  }
}

.header-left {
  display: inline-block;
}

.header-right {
  font-size: 14px;
  float: right;
  display: inline-block;
}

.header-title {
  font-size: 14px;
  margin-left: 10px;
}

.header-icon {
  font-size: 22px;
  color: inherit;
  outline: none;
  display: inline-block;
  text-decoration: none;
  vertical-align: top;

  &:hover {
    color: @dch;
  }
}

.user-info {
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  margin-right: 10px;

  &:hover {
    color: @dch;
  }
}

.header-logout {
  .header-icon;
  .text-center;
  font-size: 14px;
  margin-left: 10px;
  line-height: normal;

  &:hover {
    color: red;
  }
}

.text-center {
  vertical-align: middle;
}
</style>
