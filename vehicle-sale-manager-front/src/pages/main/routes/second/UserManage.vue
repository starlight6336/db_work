<template>
  <div class="background-div">
    <el-header class="header" height="30px">用户管理</el-header>
    <el-main class="main-div">
      <el-row class="tool-bar">
        <el-input class="search-input"
                  placeholder="请输入姓名或工号"
                  v-model="search"
                  clearable>
        </el-input>
        <el-button class="search-btn" type="primary" @click="find">查询</el-button>
      </el-row>
      <el-dialog
          title="新增咨询师"
          :visible.sync="dialogVisible"
          width="40%"
      >
        <!--弹出的对话框的内容-->
        <el-form ref="form" :model="dialogData">
          <el-form-item label="上传头像:">
            <el-upload
                class="avatar-uploader"
                action="/api/file/upload"
                :show-file-list="false"
                :on-success="getImg"
                :before-upload="beforeAvatarUpload">
            <img v-if="dialogData.teacherInfo.avatar" :src="dialogData.teacherInfo.avatar" class="avatar">
                <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
          </el-form-item>
          <el-form-item label="工号:" :label-width="formLabelWidth">
            <el-input v-model="dialogData.id" autocomplete="off" :disabled="true"></el-input>
          </el-form-item>
          <el-form-item label="姓名:" :label-width="formLabelWidth">
            <el-input v-model="dialogData.name" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="性别:" :label-width="formLabelWidth">
            <el-select v-model="dialogData.sex" placeholder="请选择角色">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="角色:" :label-width="formLabelWidth">
            <el-select :disabled="true" v-model="dialogData.role.name" muliple placeholder="请选择角色">

            </el-select>
          </el-form-item>
          <el-form-item label="个人简介:" :label-width="formLabelWidth">
            <el-input
                type="textarea"
                size="medium"
                placeholder="请输入个人简介"
                v-model="dialogData.teacherInfo.detail"
                maxlength="200"
                autosize
            >
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="applyUpdate">新增/修改</el-button>
            <el-button @click="dialogVisible = false">取消</el-button>
          </el-form-item>
        </el-form>
      </el-dialog>
      <!--大表格-->
      <el-table class="table"
                :data="tableData"
                height="90%"
                border
      >
        <el-table-column
            prop="loginName"
            label="工号"
            width="180">
        </el-table-column>
        <el-table-column
            prop="name"
            label="咨询师姓名"
            width="180">
        </el-table-column>
        <el-table-column
            prop="sex"
            label="性别"
            width="180">
        </el-table-column>
        <el-table-column
            prop="role.name"
            label="角色"
            width="180">
        </el-table-column>
        <el-table-column
            prop="teacherInfo.state"
            label="启用状态"
            width="180">
          <template slot-scope="scope">
            <el-switch
                style="display: block"
                v-model="scope.row.teacherInfo.state"
                @change="applyChange(scope.row)"
                active-color="#13ce66"
                inactive-color="#ff4949"
                active-text="启用"
                inactive-text="停用">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column
            label="操作">
          <template slot-scope="scope">
            <el-button
                size="mini"
                @click="handleCheck(scope.row.id)">查看详情
            </el-button>
          </template>
        </el-table-column>
      </el-table>

    </el-main>

  </div>
</template>

<script>

import {
  _getTeacherInfo,
  changeTeacherState,
  _getTeacherInfoDetail,
  updateTeacherInfo
} from '../../../../api/teacher'

export default {
  data () {
    return {
      img: {},
      formLabelWidth: '300',
      imageUrl: '',
      dialogVisible: false,
      currentPage: 9,
      search: '',
      tableData: this.load(),
      dialogData: {
        name: '',
        id: '',
        sex: '',
        teacherInfo: {
          detail: '',
          avatar: ''
        },
        role: ''
      }
    }
  },
  methods: {
    handleSubmit () {
      this.dialogVisible = false
    },
    applyChange (row) {
      if (row.teacherInfo.state) {
        changeTeacherState(row.teacherInfo.id, 1).then(res => {
          if (res.data === true) {
            this.$message.success(res.message)
          } else {
            this.$message.error(res.message)
          }
        })
      } else {
        changeTeacherState(row.teacherInfo.id, 0).then(res => {
          if (res.data === true) {
            this.$message.success(res.message)
          } else {
            this.$message.error(res.message)
          }
        })
      }
    },
    applyUpdate () {
      updateTeacherInfo(this.dialogData).then(res => {
        if (res.status) {
          this.$message.success(res.message)
        } else {
          this.$message.error(res.message)
        }
      })
    },
    handleSizeChange (val) {
      console.log(`每页 ${val} 条`)
    },
    handleCurrentChange (val) {
      console.log(`当前页: ${val}`)
    },
    handleCheck (id) {
      _getTeacherInfoDetail(id).then(res => {
        console.log(res)
        this.dialogData = res.data
      })
      this.dialogVisible = true
    },
    getImg (res) {
      console.log(res)
      this.dialogData.teacherInfo.avatar = res.url
    },
    find () {
      return _getTeacherInfo(this.search).then(res => {
        this.tableData = res.data
      })
    },
    load () {
      return this.find()
    },
    handleAvatarSuccess (res, file) {
      this.dialogData.teacherInfo.avatar = URL.createObjectURL(file.raw)
    },
    beforeAvatarUpload (file) {
      const isJPG = file.type === 'image/jpeg'
      const isLt2M = file.size / 1024 / 1024 < 2

      if (!isJPG) {
        this.$message.error('上传头像图片只能是 JPG 格式!')
      }
      if (!isLt2M) {
        this.$message.error('上传头像图片大小不能超过 2MB!')
      }
      return isJPG && isLt2M
    }

  }
}
</script>

<style scoped>

.background-div {
  background-color: ghostwhite;
  height: 100%;
  width: 100%;
}

.header {
  box-shadow: 0px 0px 2px 2px rgba(0, 0, 0, 0.1);
  line-height: 30px;
  font-size: 20px;
  background-color: white;
}

.main-div {
  margin: 1% 1% 0px;
  padding: 0.5%;
  box-shadow: 0px 0px 2px 2px rgba(0, 0, 0, 0.1);
  background-color: white;
}

.table {
  width: 100%;
  margin-top: 1%;
}

.search-input {
  width: 20%;
  margin-right: 2%;
}

.paging {
  margin-top: 1%;
  width: 99%;
  text-align: center;
}

.tool-bar {
}

.el-main {
  height: 93%;
}

.avatar-uploader  {
    cursor: pointer;
    position: relative;
    overflow: hidden;
}
.avatar-uploader-icon {
     font-size: 28px;
     border: 1px dashed #d9d9d9;
     border-radius: 6px;
     color: #8c939d;
     width: 178px;
     height: 178px;
     line-height: 178px;
     text-align: center;
 }
.avatar-uploader-icon:hover {
    border-color: #409EFF;
}
.avatar {
    width: 178px;
    height: 178px;
    display: block;
}

</style>
