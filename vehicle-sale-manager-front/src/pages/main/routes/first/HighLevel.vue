<template>
  <div class="background-div">
    <el-header class="header" height="30px">高级配置</el-header>
    <el-main class="main-div">
      <el-form label-position="left" size="medium">
        <el-form-item class="form-item" label="咨询室配置"><br>
          <el-button class="add-classroom-btn" type="success" size="mini" @click="handleAddClassroom">+添加</el-button>
          <el-table
              :data="tableData"
              border
              height="250"
              size="small"
              style="width: 600px">
            <el-table-column
                size="small"
                prop="name"
                label="教室名称"
                width="180">
            </el-table-column>
            <el-table-column
                size="medium"
                label="启用状态"
                width="180">
              <template slot-scope="scope">
                <el-switch
                    size="small"
                    v-model="scope.row.enabled"
                    @change="applyChange(scope.row)"
                    active-color="#13ce66"
                    inactive-color="#ff4949"
                    active-text="启用"
                    inactive-text="停用">
                </el-switch>
              </template>
            </el-table-column>
            <el-table-column
                size="small"
                label="更多操作">
              <template slot-scope="scope">
                <el-button type="text" @click="handleEdit(scope.row)">编辑</el-button>
                <el-button type="text" @click="handleDel(scope.row)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-form-item>
        <el-form-item class="form-item" label="咨询时段设置"><br>
          <br>
          <sadasdsa class="input-div">初访时长:<el-input class="inputs" v-model="termInfo.firstVisitTime"></el-input>分钟</sadasdsa>
          <dsasfasf class="input-div">咨询时长:<el-input class="inputs" v-model="termInfo.consultationTime"></el-input>分钟</dsasfasf>
          <br>
          <br>
          <el-form-item label="学期名称:" class="seasonselect">
            <el-input v-model="semester" placeholder="例：2023学年秋季学期" style="width: 200px"></el-input>
          </el-form-item>
          <br>
          <div class="block">
            <el-form-item class="demonstration" label="日期选择:">
            <el-date-picker
                    v-model="value1"
                    type="daterange"
                    value-format="yyyy-MM-dd"
                    range-separator="至"
                    start-placeholder="开始日期"
                    end-placeholder="结束日期">
            </el-date-picker>
            </el-form-item>
          </div>
          <br>
          <el-button class="duration-save-btn" type="primary" @click="handleSubmit">添加</el-button>
        </el-form-item>
      </el-form>
    </el-main>
  </div>
</template>

<script>

import {
  addClassroom,
  delClassroom,
  getClassroom,
  getTermInfo, setDuration,
  toggleClassroom,
  updateClassroom
} from '../../../../api/classroom'

export default {
  data () {
    return {
      tableData: '',
      tableDataTemplate: [{
        status: true,
        enabled: 'C-204',
        id: 1
      }],
      termInfo: {
        firstVisitTime: '',
        consultationTime: ''
      },
      semester: '',
      seletedClassroomId: '',
      value1: '',
      dialogData: {
        season: ''
      }
    }
  },
  created () {
    getClassroom().then(res => {
      this.tableData = res.data
      getTermInfo().then(res => {
        if (res.status === true) {
          this.termInfo = res.data
        } else {
          this.$message.error(res.message)
        }
      })
    })
    console.log(this.termInfo)
  },
  methods: {
    handleSubmit () {
      if (this.value1 === null || this.value1 === undefined || this.value1 === '' || this.semester === null || this.semester === undefined || this.semester === '' || this.termInfo.firstVisitTime === null || this.termInfo.firstVisitTime === undefined || this.termInfo.firstVisitTime === '' || this.termInfo.consultationTime === null || this.termInfo.consultationTime === undefined || this.termInfo.consultationTime === '') {
        this.$message.error('学期名或时间不得为空')
      } else {
        return setDuration(this.semester, this.termInfo.firstVisitTime, this.termInfo.consultationTime, this.value1[0], this.value1[1]).then(res => {
          console.log(res)
          if (res.status) {
            this.$message.success(res.message)
          } else {
            this.$message.error(res.message)
          }
        })
      }
    },
    getTermInfo () {
      return getTermInfo().then(res => {
        if (res.status === true) {
          this.termInfo.firstVisitTime = res.data.firstVisitTime
          this.termInfo.consultationTime = res.data.consultationTime
        } else {
          this.$message.error(res.message)
        }
      })
    },
    refresh () {
      this.getClassroomPrimary()
      this.getTermInfo()
    },
    handleEdit (row) {
      this.$prompt('教室名称', '编辑教室', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        inputPlaceholder: '请输入新的教室名称',
        inputValue: row.name
      }).then(({value}) => {
        let classroomName = value
        if (classroomName === '' || classroomName === undefined || classroomName === null) {
          this.$message.error('教室名称不能为空')
          return
        }
        if (classroomName === row.name) {
          this.$message.info('教室名称未改动')
          return
        }
        return updateClassroom(row.id, classroomName).then(res => {
          if (res.data === true) {
            this.$message.success(res.message)
            this.refresh()
          } else {
            this.$message.error(res.message)
          }
        })
      })
    },
    handleDel (row) {
      this.$confirm('确认删除教室' + row.name + '?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delClassroom(row.id).then(res => {
          if (res.data === true) {
            this.$message.success(res.message)
            this.refresh()
          } else {
            this.$message.error(res.message)
          }
        })
      })
    },
    applyChange (row) {
      return toggleClassroom(row.id, row.enabled).then(res => {
        if (res.data === true) {
          this.$message.success(res.message)
        } else {
          this.message.error(res.message)
        }
      })
    },
    getClassroomPrimary () {
      return getClassroom().then(res => {
        this.tableData = res.data
      })
    },
    handleAddClassroom () {
      this.$prompt('教室名称', '添加新教室', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        inputPlaceholder: '请输入教室名称'
      }).then(({value}) => {
        let classroomName = value
        if (classroomName === '' || classroomName === undefined || classroomName === null) {
          this.$message.error('教室名称不能为空')
          return
        }
        return addClassroom(classroomName).then(res => {
          if (res.data === true) {
            this.$message.success(res.message)
            this.refresh()
          } else {
            this.$message.error(res.message)
          }
        })
      })
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
.info-btn{
  margin-left: 5%;
}
.header {
  box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.1);
  line-height: 30px;
  font-size: 20px;
  background-color: white;
}

.main-div {
  margin: 2%;
  padding-left: 5%;
  box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.1);
  background-color: white;
}

.form-item {
}

.add-classroom-btn {
  margin-bottom: 1%;
}
.inputs{
  width: 10%;
  margin: 1%;
}
.duration-save-btn{
  margin-left: 5%;
}
.input-div{
  width: 10%;
  margin-left: 5%;
}
  .el-main{
    height: 91%;
  }
  .seasonselect{
    margin-left: 5%;
  }
  .block{
    margin-left: 5%;
  }
</style>
