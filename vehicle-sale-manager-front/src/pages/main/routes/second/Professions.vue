<template>
  <div class="background-div">
    <el-header class="header" height="30px">咨询师列表</el-header>
    <el-main class="main-div">
      <el-row class="tool-bar">
        <el-input class="search-name-input"
                  placeholder="请输入姓名或工号"
                  v-model="searchName"
                  clearable>
        </el-input>
        <el-button class="btn" type="primary" @click="find">查询</el-button>
      </el-row>

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
            prop="totaldutynumber"
            label="值班时段总数"
            width="180">
        </el-table-column>
        <el-table-column
            prop="totalconsultnumber"
            label="咨询人次"
            width="180">
        </el-table-column>
        <el-table-column
            label="操作">
          <template slot-scope="scope">
            <el-button
                size="mini"
                @click="handleCheck(scope.row.id)">配置咨询时间
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-main>
    <!--对齐-->
    <el-dialog title="配置咨询时间" :visible.sync="dialogTableVisible" width="80%">
      <el-table :data="gridData" :header-cell-style="{'text-align':'center'}" border="1px">
        <el-table-column property="dayOfWeek" width="150px" align="center"></el-table-column>
        <el-table-column property="periods" label="咨询时间" width="800px">
          <template slot-scope="scope">
            <div>
              <el-tag disable-transitions
                  v-for="tag in gridData[scope.$index].tags"
                  :key="tag.name"
                  closable
                  @close="handleClose(scope.$index,tag.name,tag.id)"
                  :type="tag.type">
                {{ tag.name }}
              </el-tag>
              <!--              {{ scope.$index }}-->
            </div>
          </template>

        </el-table-column>
        <el-table-column property="operation" label="操作" align="center">
          <template slot-scope="scope">
            <el-button type="text" @click="handleOpenAddTimeDialog(scope.$index)">添加</el-button>
          </template>
        </el-table-column>
        <el-dialog
            width="30%"
            title="添加咨询时段"
            :visible.sync="innerVisible"
            append-to-body>
          <el-form>
            <el-form-item label="咨询时长" :label-width="formLabelWidth">
              {{ consultDuration }}分钟
            </el-form-item>
            <el-form-item :label-width="formLabelWidth" label="开始时间">
              <el-time-picker v-model="consultStartTime" placeholder="请选择咨询时间" :clearable="false" format="HH:mm"
                              value-format="HH:mm">
              </el-time-picker>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="innerVisible = false">取消</el-button>
            <el-button v-if="isReady" type="primary" @click="handleAddTime">确定</el-button>
            <el-button v-else type="primary" icon="el-icon-loading"></el-button>
          </div>
        </el-dialog>
      </el-table>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="dialogTableVisible = false">返回</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {_getConsultants} from '../../../../api/teacher'
import {getConsultSchedule, getConsultDuration, insertConsultSchedule, delConsultSchedule} from '../../../../api/schedule'

export default {
  data () {
    return {
      inputVisible: false,
      inputValue: '',
      currentPage: 9,
      searchName: '',
      dialogTableVisible: false,
      innerVisible: false,
      formLabelWidth: '120px',
      gridData: [],
      tagGroup: [],
      consultDuration: this.getConsultDuration(),
      consultStartTime: '08:00',
      selectedIndex: '',
      selectedId: '',
      isReady: true,
      form: {
        name: '',
        region: '',
        date1: '',
        date2: '',
        delivery: false,
        type: [],
        resource: '',
        desc: '',
        time: ''
      },
      tableData: this.find()
    }
  },
  methods: {
    handleOpenAddTimeDialog (index) {
      this.selectedIndex = index
      this.innerVisible = true
    },
    handleAddTime () {
      this.isReady = false
      if (this.consultStartTime === null || this.consultStartTime === undefined || this.consultStartTime === '') {
        this.$message.error('数据库错误')
        this.innerVisible = false
        this.isReady = true
        return
      }
      let startTime = this.consultStartTime
      let hour = parseInt(startTime.substring(0, 2))
      let mnt = parseInt(startTime.substring(3, 5))
      let duration = parseInt(this.consultDuration)
      let mnt2 = duration % 60
      let hour2 = (duration - mnt2) / 60
      hour += hour2
      mnt += mnt2
      if (mnt >= 60) {
        mnt -= 60
        hour += 1
      }
      if (hour >= 24) {
        hour -= 24
      }
      if (mnt < 10) {
        mnt = '' + '0' + mnt
      } else {
        mnt = '' + mnt
      }

      if (hour < 10) {
        hour = '' + '0' + hour
      } else {
        hour = '' + hour
      }
      let submitTime1 = this.consultStartTime
      let submitTime2 = hour + ':' + mnt
      let labelText = submitTime1 + '~' + submitTime2
      submitTime1 = submitTime1 + ':00'
      submitTime2 = submitTime2 + ':00'
      insertConsultSchedule(this.selectedId, submitTime1, submitTime2, parseInt(this.selectedIndex) + 1).then(res => {
        console.log(res)
        if (res.status === true) {
          this.$message.success(res.message)
          this.gridData[this.selectedIndex].tags.push({name: labelText, type: '', id: res.data.id})
          console.log(this.gridData[this.selectedIndex].tags)
          this.innerVisible = false
        } else {
          this.$message.error(res.message)
        }
      })
      this.isReady = true
      this.$nextTick(() => {
        this.handleCheck(this.selectedId)
      })
    },
    getConsultDuration () {
      return getConsultDuration().then(res => {
        // console.log(res)
        this.consultDuration = res.data
      })
    },
    find () {
      return _getConsultants(this.searchName).then(res => {
        // console.log(res)
        this.tableData = res.data
      })
    },
    handleSizeChange (val) {
      // console.log(`每页 ${val} 条`)
    },
    handleCurrentChange (val) {
      // console.log(`当前页: ${val}`)
    },
    handleCheck (id) {
      this.selectedId = id
      getConsultSchedule(id).then(res => {
        this.gridData = this.parseResponse(res.data)
      })
      // console.log(this.gridData)
      this.dialogTableVisible = true
    },
    parseResponse (resp) {
      let weekdays = [
        {
          dayOfWeek: '星期一',
          periods: [],
          tags: []
        },
        {
          dayOfWeek: '星期二',
          periods: [],
          tags: []
        },
        {
          dayOfWeek: '星期三',
          periods: [],
          tags: []
        },
        {
          dayOfWeek: '星期四',
          periods: [],
          tags: []
        },
        {
          dayOfWeek: '星期五',
          periods: [],
          tags: []
        },
        {
          dayOfWeek: '星期六',
          periods: [],
          tags: []
        },
        {
          dayOfWeek: '星期日',
          periods: [],
          tags: []
        }
      ]

      resp.map(item => {
        let id = item.id
        let currWeekday = item.dayOfWeek
        weekdays[currWeekday - 1].periods.push({timeStart: item.startTime, timeEnd: item.endTime})
        weekdays[currWeekday - 1].tags.push({
          name: '' + (item.startTime.substring(0, 5)) + '~' + (item.endTime.substring(0, 5)),
          type: '',
          id: id
        })
      })
      return weekdays
    },
    handleClose (i, name, id) {
      console.log('i=' + i + ' name=' + name + ' id=' + id)
      delConsultSchedule(id).then(res => {
        if (res.data === true) {
          this.$message.success(res.message)
          this.gridData[i].tags.splice(this.gridData[i].tags.indexOf(name), 1)
        } else {
          this.$message.error(res.message)
        }
        this.$nextTick(() => {
          this.handleCheck(this.selectedId)
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

.search-name-input {
  width: 15%;
  margin-right: 2%;
}

.btn {
  margin-left: 2%;
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

.search-date {
  width: 12%;
}

.el-tag + .el-tag {
  margin-left: 10px;
}
</style>
