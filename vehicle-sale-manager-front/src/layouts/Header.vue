<template>
  <div class="header">
    <div class="header-left">
      <a
        href="javascript:"
        class="header-icon"
        @click="collapseTrigger"
        role="button"
      >
        <s-icon
          v-if="collapse"
          icon="suncaper-menu-fold"
        />
        <s-icon
          v-else
          icon="suncaper-menu-unfold"
        />
      </a>
      <span class="header-title text-center">欢迎您，{{userName}} {{roleName}}</span>
    </div>
    <div class="header-right">
      <el-tooltip class="item" effect="dark" v-if="this.useflag === 0" content="您没有待审核信息" placement="bottom" style="margin: 4px">
        <i class="el-icon-bell" ></i>
      </el-tooltip>
      <el-tooltip class="item" effect="dark" v-if="this.useflag === 1" placement="bottom" style="margin: 4px">
        <div slot="content">{{'您有'+this.unsolvedcount+'条待审核信息'}}</div>
        <i class="el-icon-message-solid" style="color: red" ></i>
      </el-tooltip>
      <s-icon
        icon="suncaper-user"
        class="text-center"
      />
      <span class="text-center" >
          {{userName}}
        </span>
      <a
        href="javascript:"
        class="header-logout"
        @click="logout"
        role="button"
      >
        <s-tooltip effect="dark" content="退出" placement="bottom">
          <s-icon
            icon="suncaper-quit"
          />
        </s-tooltip>
      </a>
    </div>
  </div>
</template>

<script>
import Icon from '@/components/Icon'
import {Tooltip} from 'element-ui'
import user from '../store/modules/user'
import {_clearStorage, _getLocalStorage} from '../tools/utils'

export default {
  data () {
    return {
      // 预留字段，后续如需增加新能源汽车相关通知可在此扩展
      toUseUserType: ''
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
  components: {
    's-icon': Icon,
    's-tooltip': Tooltip
  },
  methods: {
    // eslint-disable-next-line vue/no-dupe-keys
    logout () {
      user.state.id = null
      user.state.type = null
      user.state.loginName = null
      _clearStorage()
      this.$router.push({path: '/login'})
      this.$message.info('已退出登录')
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
    > span {
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
  .text-center{
    vertical-align: middle;
  }
</style>
