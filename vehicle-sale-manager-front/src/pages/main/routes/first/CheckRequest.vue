<template>
  <div class="background-div">
    <el-header class="header" height="30px">审核请求</el-header>
    <el-main class="main-div">
      <!--大表格-->
      <el-table class="table"
                :data="tableData"
                height="97%"
                border
      >
        <el-table-column
            prop="cid"
            label="序号"
            width="80">
          <template slot-scope="scope">{{scope.row.id}}</template>
        </el-table-column>
        <el-table-column
            prop="name"
            label="咨询师姓名"
            width="180">
          <template slot-scope="scope">{{scope.row.consultation.teacher.name}}</template>
        </el-table-column>
        <el-table-column
            prop="loginName"
            label="工号"
            width="180"><template slot-scope="scope">{{scope.row.consultation.teacher.loginName}}</template>
        </el-table-column>
        <el-table-column
            prop="reason"
            label="申请理由"
            width="280"><template slot-scope="scope">{{scope.row.reason}}</template>
        </el-table-column>
        <el-table-column
                prop="times"
                label="申请新增次数"
                width="180"><template slot-scope="scope">{{scope.row.times}}</template>
        </el-table-column>
        <el-table-column
            prop="createdate"
            label="提交时间"
            width="280"><template slot-scope="scope">{{scope.row.consultation.createDate}}</template>
        </el-table-column>
        <el-table-column
            label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="text" v-if="scope.row.state === null" @click="update(scope.$index)">通过</el-button>
            <el-button size="mini" type="text" v-if="scope.row.state === null" @click="reject(scope.$index)">不通过</el-button>
            <a v-if="scope.row.state === true">已通过</a>
            <a v-if="scope.row.state === false">已拒绝</a>
          </template>
        </el-table-column>
      </el-table>
    </el-main>

  </div>
</template>

<script>

import {
  changeTeacherState,
  _getTeacherInfoDetail,
  updateTeacherInfo,
  getUserAvatar
} from '../../../../api/teacher'
import {getExtendRequest, updateExtendRequest} from '../../../../api/api'

export default {
  data () {
    return {
      formLabelWidth: '300',
      dialogVisible: false,
      search: '',
      tableData: {
        id: '',
        cid: '',
        times: '',
        reason: '',
        isSolved: '',
        state: '',
        consultation: {
          id: '',
          rid: '',
          room: '',
          fid: '',
          tid2: '',
          startDate: '',
          endDate: '',
          weekDay: '',
          startTime: '',
          endTime: '',
          state: '',
          consultTimes: '',
          detail: '',
          teacher: {
            id: 5,
            loginName: '',
            password: '',
            name: '',
            sex: '',
            birth: '',
            createDate: '',
            updateDate: '',
            deleted: '',
            role: '',
            arrangements: '',
            studentInfo: '',
            teacherInfo: {
              id: '',
              uid: '',
              avatar: '',
              title: '',
              school: '',
              detail: '',
              state: '',
              createDate: '',
              updateDate: '',
              deleted: ''
            }
          },
          createDate: '',
          updateDate: '',
          deleted: ''
        }
      },
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
  created () {
    getExtendRequest().then(res => {
      this.tableData = res.data
    })
  },
  methods: {
    find () {
      getExtendRequest().then(res => {
        this.tableData = res.data
      })
    },
    update (index) {
      console.log(this.tableData)
      updateExtendRequest(this.tableData[index].id, 1).then(res => {
        this.$message.success('已通过')
        this.find()
      })
    },
    reject (index1) {
      updateExtendRequest(this.tableData[index1].id, 0).then(resp => {
        this.$message.success('已拒绝')
        this.find()
      })
    },
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
      getUserAvatar(this.dialogData.teacherInfo).then(rep => {
        if (rep.status) {
          this.$message.success(rep.message)
        } else {
          this.$message.error(rep.message)
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
    getImg () {
      getUserAvatar(this.img).then(res => {
        console.log(res)
        if (res.status) {
          this.$message.success(res.massage)
        } else {
          this.$message.error(res.message)
        }
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
  height: 98%;
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
  height: 90%;
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
