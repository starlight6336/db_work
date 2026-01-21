<template>
  <div class="background-div">
    <el-header class="header" height="30px">初访预约管理</el-header>
    <el-main class="main-div">
      <el-row class="tool-bar">
        <el-select v-model="toolBar.theme" placeholder="咨询主题" size="small" clearable style="margin-right: 10px">
          <el-option
              v-for="item in stateTemplate"
              :key="item.value"
              :label="item.label"
              :value="item.value">
          </el-option>
        </el-select>
        <el-select v-model="toolBar.emer" placeholder="自述紧急程度" size="small" clearable style="margin-right: 10px">
          <el-option
              v-for="item in emergeTemplate"
              :key="item.value"
              :label="item.label"
              :value="item.value">
          </el-option>
        </el-select>
        <el-input class="search-name-input"
                  placeholder="请输入姓名或学号"
                  v-model="toolBar.parm"
                  size="small"
                  clearable
                  style="margin-right: 10px">
        </el-input>
        <el-input placeholder="请输入学院" class="search-facility" size="small" clearable v-model="toolBar.facility"
                  style="margin-right: 10px"></el-input>
        <el-button class="btn1" type="primary" size="small" @click="find">查询</el-button>
        <el-button class="btn2" type="primary" size="small" @click="handleCheckDuty">查看当前值班情况</el-button>
      </el-row>

      <div class="table-div">
        <el-table
            class="table"
            :data="tableData"
            height="530"
            border
            style="width: 100%">
          <el-table-column label="序号" width="60">
            <template slot-scope="scope">
              <div v-if="scope.row.red===true" style="color: red">{{scope.$index+1}}</div>
              <div v-else style="color: black">{{scope.$index+1}}</div>
            </template>
          </el-table-column>
          <el-table-column
              prop="loginName"
              label="学号"
              width="160">
          </el-table-column>
          <el-table-column
              prop="name"
              label="姓名"
              width="100">
          </el-table-column>
          <el-table-column
              prop="sex"
              label="性别"
              width="50">
          </el-table-column>
          <el-table-column
              prop="theme"
              label="来访者咨询主题"
              width="150">
          </el-table-column>
          <el-table-column
              prop="selfemergency"
              label="自述紧急程度"
              width="110">
          </el-table-column>
          <el-table-column
              prop="score"
              label="问卷总得分"
              width="95">
          </el-table-column>
          <el-table-column
              prop="facility"
              label="学院"
              width="170">
          </el-table-column>
          <el-table-column
              prop="telephone"
              label="电话"
              width="150">
          </el-table-column>
          <el-table-column
              prop="submittime"
              label="提交时间"
              width="270">
          </el-table-column>
          <el-table-column width="250"
                           label="操作">
            <template slot-scope="scope">
              <el-button type="text" size="mini" @click="handleCheck(scope.row,scope.$index)">查看详情</el-button>
              <el-button type="text" size="mini" @click="handleEnableScheduling(scope.row,scope.$index)" v-if="scope.row.state === 1">安排初访
              </el-button>
              <el-button disabled type="text" size="mini" v-if="scope.row.state === 6">安排出访</el-button>
              <el-button type="text" size="mini" @click="handleReject(scope.row,scope.$index)" v-if="scope.row.state === 1">拒绝安排</el-button>
              <el-button type="text" size="mini" disabled v-if="scope.row.state === 6">已拒绝</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-main>
    <!--查看初访详情dialog-->
    <el-dialog
        title="查看初访详情"
        :visible.sync="preCheckDialogEnabled"
        width="80%"
    >
      <el-form label-width="200" label-position="top">
        <el-form-item label="初访预约时间段">
          {{ dialogData_Pre.expectTime1 }}<br>
          {{ dialogData_Pre.expectTime2 }}<br>
          {{ dialogData_Pre.expectTime3 }}
        </el-form-item>
        <el-form-item label="基本信息">
          <el-table
              :highlight-current-row="false"
              :show-header="false"
              :data="stuInfo"
              style="width: 100%">
            <el-table-column
                align="right"
                width="120">
              <template slot-scope="scope">
                <p class="label">
                  {{ scope.row.label1 }}
                </p>
              </template>
            </el-table-column>
            <el-table-column>
              <template slot-scope="scope">
                <p class="value">
                  {{ scope.row.value1 }}
                </p>
              </template>
            </el-table-column>
            <el-table-column
                align="right"
                width="100">
              <template slot-scope="scope">
                <p class="label">
                  {{ scope.row.label2 }}
                </p>
              </template>
            </el-table-column>
            <el-table-column>
              <template slot-scope="scope">
                <p class="value">
                  {{ scope.row.value2 }}
                </p>
              </template>
            </el-table-column>
          </el-table>
        </el-form-item>
        <el-form-item label="咨询期望">
          <el-table
              :highlight-current-row="false"
              :show-header="false"
              :data="consultInfo"
              style="width: 100%">
            <el-table-column
                align="right"
                width="120">
              <template slot-scope="scope">
                <p class="label">
                  {{ scope.row.label1 }}
                </p>
              </template>
            </el-table-column>
            <el-table-column>
              <template slot-scope="scope">
                <p class="value">
                  {{ scope.row.value1 }}
                </p>
              </template>
            </el-table-column>
            <el-table-column
                align="right"
                width="100">
              <template slot-scope="scope">
                <p class="label">
                  {{ scope.row.label2 }}
                </p>
              </template>
            </el-table-column>
            <el-table-column>
              <template slot-scope="scope">
                <p class="value">
                  {{ scope.row.value2 }}
                </p>
              </template>
            </el-table-column>
          </el-table>
        </el-form-item>
        <el-form-item label="自我状态评估量表">
          <el-table
              :highlight-current-row="false"
              :show-header="false"
              :data="questionInfo"
              style="width: 100%">
            <el-table-column
                align="right"
                width="120">
              <template slot-scope="scope">
                <p v-if="scope.row.checked1" class="el-icon-check">
                </p>
                <p v-else class="el-icon-close">
                </p>
              </template>
            </el-table-column>
            <el-table-column>
              <template slot-scope="scope">
                <p v-if="scope.row.red1" class="red">
                  {{ scope.row.name1 }}
                </p>
                <p v-else class="norm">
                  {{ scope.row.name1 }}
                </p>
              </template>
            </el-table-column>
            <el-table-column
                align="right"
                width="100">
              <template slot-scope="scope">
                <p v-if="scope.row.checked2" class="el-icon-check">
                </p>
                <p v-else class="el-icon-close">
                </p>
              </template>
            </el-table-column>
            <el-table-column>
              <template slot-scope="scope">
                <p v-if="scope.row.red1" class="red">
                  {{ scope.row.name2 }}
                </p>
                <p v-else class="norm">
                  {{ scope.row.name2 }}
                </p>
              </template>
            </el-table-column>
          </el-table>
        </el-form-item>
      </el-form>
    </el-dialog>
    <!--安排初访dialog-->
    <el-dialog title="安排初访"
               :visible.sync="schedulingDialogEnabled"
               width="40%">
      <el-form label-width="200" label-position="top">
        <el-form-item label="学生预约时间">
          {{ dialogData_Pre.expectTime1 }}<br>
          {{ dialogData_Pre.expectTime2 }}<br>
          {{ dialogData_Pre.expectTime3 }}
        </el-form-item>
        <el-form-item label="选择初访时间">
          <el-select class="timeSelct" v-model="schedulingForm.time" placeholder="请选择可用的初访时间"
                     @change="schedulingFormStep1Finished">
            <el-option
                v-for="item in timeOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="选择初访员">
          <el-select class="timeSelct" v-model="schedulingForm.teacherUID" placeholder="请选择初访教师"
                     :disabled="schedulingForm.toggleTeacherSelect">
            <el-option
                v-for="item in teacherOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="选择初访地点">
          <el-select class="timeSelct" v-model="schedulingForm.roomID" placeholder="请选择初访教室"
                     :disabled="schedulingForm.toggleRoomSelect">
            <el-option
                v-for="item in roomOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="success"
                     class="submit-btn"
                     @click="submitScheduleForm"
                     :disabled="this.schedulingForm.time===''||this.schedulingForm.roomID===''||this.schedulingForm.teacherUID===''"
                     size="medium">
            确定
          </el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
    <!--查看值班情况-->
    <el-dialog title="查看当前值班情况" :visible.sync="dutyDialogEnabled"
               width="90%">
      <el-table :data="dutyData"
                :span-method="spanMtd"
                border
      >
        <el-table-column
            label="日期"
            prop="weekday">
        </el-table-column>
        <el-table-column
            label="咨询师姓名"
            prop="name">
        </el-table-column>
        <el-table-column
            label="时段"
            prop="time">
        </el-table-column>
        <el-table-column
            label="占用教室"
            prop="classroom">
        </el-table-column>
        <el-table-column
            label="状态"
            prop="status">
          <template slot-scope="scope">
            <div :style="{color: scope.row.status == '可用' ? 'green' : 'red'}">
              {{scope.row.status}}
            </div>
          </template>
        </el-table-column>
      </el-table>

    </el-dialog>
  </div>
</template>

<script>
import {getAllFirstVisitInfo, getFirstVisitInfo} from '../../../../api/appointment'
import {getPreVisitDetailByID, getQuestionPool} from '../../../../api/api'
import {
  addNewPreVisitArrange,
  getAvailablePreVisitTimeByFID,
  getAvailableRoomByDateTimeDay,
  getAvailableTeacherByDateTimeDay, getDuty, rejectManagementByFID
} from '../../../../api/scheduleManagement'
import {getPreCheckDuration} from '../../../../api/schedule'

export default {
  data () {
    return {
      dutyData: [],
      schedulingDialogEnabled: false,
      preCheckDialogEnabled: false,
      consultInfo: [
        {
          label1: '来访主题',
          value1: '',
          label2: '来访期望',
          value2: ''
        },
        {
          label1: '自述紧急程度',
          value1: '',
          label2: '问卷得分',
          value2: ''
        }
      ],
      stuInfo: [
        {
          label1: '姓名',
          value1: '',
          label2: '性别',
          value2: ''
        },
        {
          label1: '出生年月',
          value1: '',
          label2: '学号',
          value2: ''
        },
        {
          label1: '院系',
          value1: '',
          label2: '联系方式',
          value2: ''
        },
        {
          label1: '身份',
          value1: '',
          label2: '紧急联系人',
          value2: ''
        },
        {
          label1: '联系人电话',
          value1: '',
          label2: '与本人关系',
          value2: ''
        }
      ],
      questionInfo: [{
        checked1: '',
        name1: '',
        red1: '',
        checked2: '',
        name2: '',
        red2: ''
      }],
      toolBar: {
        facility: '',
        emer: '',
        theme: '',
        parm: '',
        dateRange: ''
      },
      questionPool: [],
      dialogData_Pre: [],
      stateTemplate: [
        {
          value: 1,
          label: '自我探索与成长'
        },
        {
          value: 2,
          label: '感情问题'
        },
        {
          value: 3,
          label: '人际关系'
        },
        {
          value: 4,
          label: '心理测试解释'
        },
        {
          value: 5,
          label: '性别认同与同性恋'
        },
        {
          value: 6,
          label: '情绪困扰'
        },
        {
          value: 7,
          label: '学习问题'
        },
        {
          value: 8,
          label: '心理治疗问题'
        },
        {
          value: 9,
          label: '生涯规划和未来'
        },
        {
          value: 10,
          label: '家庭问题'
        },
        {
          value: 11,
          label: '其它'
        }
      ],
      emergeTemplate: [
        {
          value: 1,
          label: '一般'
        },
        {
          value: 2,
          label: '紧急'
        },
        {
          value: 3,
          label: '非常紧急'
        }
      ],
      formLabelWidth: '120px',
      tableData: this.load(),
      timeOptions: [],
      teacherOptions: [],
      roomOptions: [],
      selectedId: '',
      durationPreCheck: '',
      dutyDialogEnabled: false,
      schedulingForm: {
        time: '',
        teacherUID: '',
        roomID: '',
        toggleTeacherSelect: true,
        toggleRoomSelect: true,
        toggleSubmitBtn: true
      }
    }
  },
  created () {
    getPreCheckDuration().then(res => {
      this.durationPreCheck = res.data
    })
    this.find()
    getQuestionPool().then(res => {
      this.questionPool = res.data
    })
    this.dutyData = []
    console.log(this.dutyData)
    getDuty().then(res => {
      res.data.map(day => {
        day.map(duty => {
          this.dutyData.push({
            weekday: duty.dayOfWeek,
            name: duty.teacherName,
            time: duty.startTime + '~' + duty.endTime,
            classroom: duty.roomName,
            status: (duty.roomName === null)
          })
        })
      })
    })
  },
  methods: {
    spanMtd ({row, column, rowIndex, columnIndex}) {
    },
    handleCheckDuty () {
      this.dutyData = []
      console.log(this.dutyData)
      getDuty().then(res => {
        res.data.map(day => {
          day.map(duty => {
            let output
            switch (duty.dayOfWeek) {
              case 1:
                output = '星期一'
                break
              case 2:
                output = '星期二'
                break
              case 3:
                output = '星期三'
                break
              case 4:
                output = '星期四'
                break
              case 5:
                output = '星期五'
                break
              case 6:
                output = '星期六'
                break
              case 7:
                output = '星期日'
                break
            }
            let _status
            if (duty.roomName === null) {
              _status = '可用'
            } else {
              _status = '占用'
            }
            this.dutyData.push({
              weekday: duty.arrangementDate + '(' + output + ')',
              name: duty.teacherName,
              time: duty.startTime + '~' + duty.endTime,
              classroom: duty.roomName,
              status: _status
            })
          })
        })
      })
      this.dutyDialogEnabled = true
    },
    handleReject (row, index) {
      this.$confirm('是否确认拒绝安排?', '拒绝安排', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.selectedId = this.tableData[index].fid
        rejectManagementByFID(this.selectedId).then(res => {
          if (res.data === true) {
            this.$message.success(res.message)
          } else {
            this.$message.error(res.message)
          }
          this.tableData = this.find()
        })
      })
    },
    submitScheduleForm () {
      console.log(this.selectedId)
      let timeAttr = this.schedulingForm.time.split('|')
      let temp = this.selectedId
      addNewPreVisitArrange(timeAttr[0], parseInt(timeAttr[1]), timeAttr[2], timeAttr[3], this.schedulingForm.teacherUID, temp, this.schedulingForm.roomID).then(res => {
        if (res.data === true) {
          this.$message.success(res.message)
          this.schedulingDialogEnabled = false
          this.find()
        } else {
          this.$message.error(res.message)
          this.find()
        }
      })
    },
    schedulingFormStep1Finished () {
      this.teacherOptions = []
      this.roomOptions = []
      let timeAttr = this.schedulingForm.time.split('|')
      getAvailableTeacherByDateTimeDay(timeAttr[0], parseInt(timeAttr[1]), timeAttr[2], timeAttr[3]).then(res => {
        res.data.map(item => {
          this.teacherOptions.push({label: item.name, value: item.id})
        })
      })
      getAvailableRoomByDateTimeDay(timeAttr[0], parseInt(timeAttr[1]), timeAttr[2], timeAttr[3]).then(res => {
        console.log(res)
        res.data.map(item => {
          this.roomOptions.push({label: item.name, value: item.id})
        })
      })
      this.schedulingForm.toggleTeacherSelect = false
      this.schedulingForm.toggleRoomSelect = false
    },
    handleEnableScheduling (row, index) {
      console.log(this.tableData)
      console.log(this.tableData[index].fid)
      this.schedulingForm = {
        time: '',
        teacherUID: '',
        roomID: '',
        toggleTeacherSelect: true,
        toggleRoomSelect: true,
        toggleSubmitBtn: true
      }
      this.timeOptions = []
      this.teacherOptions = []
      this.roomOptions = []
      this.selectedId = this.tableData[index].fid
      console.log(this.selectedId)
      getAvailablePreVisitTimeByFID(this.selectedId).then(res => {
        res.data.map(item => {
          // console.log(item)
          let wkd = ''
          switch (item.dayOfWeek) {
            case 1:
              wkd = '星期一'
              break
            case 2:
              wkd = '星期二'
              break
            case 3:
              wkd = '星期三'
              break
            case 4:
              wkd = '星期四'
              break
            case 5:
              wkd = '星期五'
              break
            case 6:
              wkd = '星期六'
              break
            case 7:
              wkd = '星期日'
              break
          }
          let label = item.arrangementDate + ' (' + wkd + ') ' + item.startTime.substring(0, 5) + '~' + item.endTime.substring(0, 5)
          let value = '' + item.arrangementDate + '|' + item.dayOfWeek + '|' + item.startTime + '|' + item.endTime
          this.timeOptions.push({label: label, value: value})
        })
      })
      return getPreVisitDetailByID(this.selectedId).then(res => {
        this.dialogData_Pre = res.data
        this.schedulingDialogEnabled = true
      })
    },
    load () {
      return getAllFirstVisitInfo().then(res => {
        this.tableData = this.parseResponse(res.data)
      })
    },
    find () {
      return getFirstVisitInfo(this.toolBar.facility, this.toolBar.emer, this.toolBar.theme, this.toolBar.parm).then(res => {
        this.tableData = this.parseResponse(res.data)
      })
    },
    handleCheck (row, index) {
      this.questionInfo = []
      this.selectedId = this.tableData[index].fid
      return getPreVisitDetailByID(this.selectedId).then(res => {
        this.dialogData_Pre = res.data
        this.stuInfo[0].value1 = this.dialogData_Pre.student.name
        this.stuInfo[0].value2 = this.dialogData_Pre.student.sex
        this.stuInfo[1].value1 = this.dialogData_Pre.student.birth
        this.stuInfo[1].value2 = this.dialogData_Pre.student.id
        this.stuInfo[2].value1 = this.dialogData_Pre.student.studentInfo.facility
        this.stuInfo[2].value2 = this.dialogData_Pre.student.studentInfo.telephone
        this.stuInfo[3].value1 = this.dialogData_Pre.student.studentInfo.degree
        this.stuInfo[3].value2 = this.dialogData_Pre.student.studentInfo.emergentContactor
        this.stuInfo[4].value1 = this.dialogData_Pre.student.studentInfo.emergentTelephone
        this.stuInfo[4].value2 = this.dialogData_Pre.student.studentInfo.relationship
        // 咨询板块
        let string = ''
        switch ('' + this.dialogData_Pre.theme) {
          case '1':
            string = '自我探索与成长'
            break
          case '2':
            string = '感情问题'
            break
          case '3':
            string = '人际关系'
            break
          case '4':
            string = '心理测试解释'
            break
          case '5':
            string = '性别认同与同性恋'
            break
          case '6':
            string = '情绪困扰'
            break
          case '7':
            string = '学习问题'
            break
          case '8':
            string = '心理治疗问题'
            break
          case '9':
            string = '生涯规划和未来'
            break
          case '10':
            string = '家庭问题'
            break
          case '11':
            string = '其他'
            break
        }
        this.consultInfo[0].value1 = string
        if (this.dialogData_Pre.consultationExpectation === null || this.dialogData_Pre.consultationExpectation === undefined || this.dialogData_Pre.consultationExpectation === '') {
          this.consultInfo[0].value2 = '暂无'
        } else {
          this.consultInfo[0].value2 = this.dialogData_Pre.consultationExpectation
        }
        // 紧急状态
        switch ('' + this.dialogData_Pre.selfEmergency) {
          case '1':
            string = '一般'
            break
          case '2':
            string = '紧急'
            break
          case '3':
            string = '非常紧急'
            break
        }
        this.consultInfo[1].value1 = string
        // 问卷分数
        if (this.dialogData_Pre.score === null || this.dialogData_Pre.score === undefined || this.dialogData_Pre.score === '') {
          this.consultInfo[1].value2 = '暂无'
        } else {
          this.consultInfo[1].value2 = this.dialogData_Pre.score
        }
        // 问题检测
        res.data.questions.map(item => {
          this.questionPool.map(item2 => {
            if (item.id === item2.id) {
              item2.selected = true
            }
          })
        })
        this.questionPool.map(item => {
          if (item.selected === true) {
          } else {
            item.selected = false
          }
        })
        let i = 1
        this.questionInfo = []
        let temp = {checked: '', name: '', emergent: ''}
        this.questionPool.map(item => {
          switch (i) {
            case 1:
              temp.checked = item.selected
              temp.emergent = item.emergent
              temp.name = item.name
              i++
              break
            case 2:
              this.questionInfo.push({
                checked1: temp.checked,
                red1: temp.emergent,
                name1: temp.name,
                checked2: item.selected,
                red2: item.emergent,
                name2: item.name
              })
              temp = {checked: '', name: '', emergent: ''}
              i = 1
          }
        })
        console.log(this.questionInfo)
        this.preCheckDialogEnabled = true
      })
    },
    parseResponse (resp) {
      let duration = this.durationPreCheck
      let parsedData = []
      resp.map(item => {
        console.log(item)
        if (item.submittime === null) {
          let emerText = ''
          switch (item.selfemergency) {
            case 1:
              emerText = '一般'
              break
            case 2:
              emerText = '紧急'
              break
            case 3:
              emerText = '非常紧急'
              break
          }
          let themeText = ''
          switch ('' + item.theme) {
            case '1':
              themeText = '自我探索与成长'
              break
            case '2':
              themeText = '感情问题'
              break
            case '3':
              themeText = '人际关系'
              break
            case '4':
              themeText = '心理测试解释'
              break
            case '5':
              themeText = '性别认同与同性恋'
              break
            case '6':
              themeText = '情绪困扰'
              break
            case '7':
              themeText = '学习问题'
              break
            case '8':
              themeText = '心理治疗问题'
              break
            case '9':
              themeText = '生涯规划和未来'
              break
            case '10':
              themeText = '家庭问题'
              break
            case '11':
              themeText = '其他'
              break
          }
          parsedData.push({
            state: item.state,
            red: item.red,
              fid: item.fid,
            loginName: item.loginName,
            name: item.name,
            sex: item.sex,
            theme: themeText,
            selfemergency: emerText,
            telephone: item.telephone,
            submittime: '',
            score: item.score,
            facility: item.facility
          })
        } else {
          console.log(item.submittime)
          let s1 = item.submittime.substring(0, 10)
          let s2 = item.submittime.substring(11, 16)
          console.log(s1 + s2)
          let hour = parseInt(s2.substring(0, 2))
          let mnt = parseInt(s2.substring(3, 5))
          console.log(hour + '' + mnt)
          console.log(duration)
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
          let submitTime1 = s2
          let labelText = submitTime1
          // submitTime1 = submitTime1 + ':00'
          // submitTime2 = submitTime2 + ':00'
          //  weekday
          let weekdays = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日']
          let wkd = weekdays[new Date(s1).getDay() - 1]
          let output = s1 + ' (' + wkd + ') ' + labelText
          let emerText = ''
          switch (item.selfemergency) {
            case 1:
              emerText = '一般'
              break
            case 2:
              emerText = '紧急'
              break
            case 3:
              emerText = '非常紧急'
              break
          }
          let themeText = ''
          switch ('' + item.theme) {
            case '1':
              themeText = '自我探索与成长'
              break
            case '2':
              themeText = '感情问题'
              break
            case '3':
              themeText = '人际关系'
              break
            case '4':
              themeText = '心理测试解释'
              break
            case '5':
              themeText = '性别认同与同性恋'
              break
            case '6':
              themeText = '情绪困扰'
              break
            case '7':
              themeText = '学习问题'
              break
            case '8':
              themeText = '心理治疗问题'
              break
            case '9':
              themeText = '生涯规划和未来'
              break
            case '10':
              themeText = '家庭问题'
              break
            case '11':
              themeText = '其他'
              break
          }
          parsedData.push({
            state:item.state,
            red : item.red,
              fid: item.fid,
            loginName: item.loginName,
            name: item.name,
            sex: item.sex,
            theme: themeText,
            selfemergency: emerText,
            telephone: item.telephone,
            submittime: output,
            score: item.score,
            facility: item.facility
          })
        }
      })
      return parsedData
    }
    // methods中写方法
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
}

.timeSelct {
  width: 80%;
}

.btn {
  margin-left: 1%;
  margin-top: 0.5%;
}

.btn1 {
  margin-left: 1%;
}

.btn2 {
  float: right;
}

.paging {
  margin-top: 1%;
  width: 99%;
  text-align: center;
}

.tool-bar {
}

.search-facility {
  width: 15%;
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

.red {
  color: red;
}

.norm {
  color: black;
}

.submit-btn {
  float: right;
}
  .red{
    color:red;
  }
  .green{
    color:green;
  }
</style>
