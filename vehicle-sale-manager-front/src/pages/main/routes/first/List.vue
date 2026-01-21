<template>
  <div class="background-div">
    <el-main class="main-div">
      <el-button v-if="editDraftMode" plain type="primal" @click="handleBackToList" size="mini">返回列表</el-button>
      <Appointment_BUT_with_FID :fid_parent="selectedId" :editDraftMode="this.editDraftMode" v-if="editDraftMode"></Appointment_BUT_with_FID>
      <div v-else class="table-div">
        <el-table
            class="table"
            :data="tableData"
            height="600"
            border
            style="width: 100%">
          <el-table-column type="index" label="序号" width="60">
          </el-table-column>
          <el-table-column
              prop="createDate"
              label="创建时间"
              >
          </el-table-column>
          <el-table-column
              prop="updateDate"
              label="修改时间"
              >
          </el-table-column>
          <el-table-column
              prop="state"
              label="预约状态"
              >
            <template slot-scope="scope">
              <div v-if="scope.row.stateNum===9" style="color: red">{{ scope.row.state }}</div>
              <div v-else-if="scope.row.stateNum===2" style="color: green">{{ scope.row.state }}</div>
              <div v-else-if="scope.row.stateNum===3" style="color: greenyellow">{{ scope.row.state }}</div>
              <div v-else-if="scope.row.stateNum===7" style="color: sandybrown">{{ scope.row.state }}</div>
              <div v-else-if="scope.row.stateNum===1||scope.row.stateNum===4" style="color: gray">{{
                  scope.row.state
                }}
              </div>
              <div v-else>{{ scope.row.state }}</div>
            </template>
          </el-table-column>
          <el-table-column
              label="操作">
            <template slot-scope="scope">
              <div v-if="scope.row.stateNum===10">
                <!--如果是草稿，提交-->
                <el-button type="text" @click="startEditMyDraftByFID(scope.row.id)">编辑</el-button>
                <el-button type="text" @click="handleKillDraft(scope.row.id)" >删除</el-button>
              </div>
              <div
                  v-else-if="!(scope.row.stateNum>=5&&scope.row.stateNum<=9)">
                <!--可以取消的状态-->
                <el-button type="text" @click="handleCheck(scope.row,scope.$index)">查看详情</el-button>
                <el-button type="text" @click="handleCancel(scope.row.id)">撤销</el-button>
              </div>
              <div v-else>
                <!--无法取消的状态-->
                <el-button type="text" @click="handleCheck(scope.row,scope.$index)">查看详情</el-button>
              </div>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-main>
    <!--查看初访详情dialog-->
    <el-dialog
        :title="'查看初访详情【'+this.currState+'】'"
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
        <el-form-item v-if="this.currStateNum===2" label="需确认初访信息">
          <el-form size="small" class="inner-form" style="margin-left: 5%" label-width="100px" label-position="left"
                   :inline="true">
            <el-form-item label="时间" style="width: 100%">{{ this.date + ' ' }}(
              <el-div v-if="this.wkd===1">星期一</el-div>
              <el-div v-else-if="this.wkd===2">星期二</el-div>
              <el-div v-else-if="this.wkd===3">星期三</el-div>
              <el-div v-else-if="this.wkd===4">星期四</el-div>
              <el-div v-else-if="this.wkd===5">星期五</el-div>
              <el-div v-else-if="this.wkd===6">星期六</el-div>
              <el-div v-else-if="this.wkd===7">星期日</el-div>
              )
              {{ '' + this.time1 }}~{{ this.time2 }}
            </el-form-item>
            <el-form-item label="初访教师" style="width: 50%">
              {{ this.teacher }}
            </el-form-item>
            <el-form-item label="初访地点">
              {{ this.room }}
            </el-form-item>
          </el-form>
          <div style="margin-left: 35%">
            <el-button type="success" size="small" @click="_YES_OF_COURSE">接受安排</el-button>
            <el-button type="danger" size="small" @click="_FUCK_YOU_I_DONT_LIKE_THIS_TEACHER">拒绝安排</el-button>
            <el-button type="info" size="small" @click="_I_GIVE_UP">放弃排队</el-button>
          </div>

        </el-form-item>
      </el-form>
    </el-dialog>

  </div>
</template>

<script>
import {getPreVisitDetailByID, getQuestionPool} from '../../../../api/api'
import {
  addNewPreVisitArrange,
  getAvailablePreVisitTimeByFID,
  getAvailableRoomByDateTimeDay,
  getAvailableTeacherByDateTimeDay, getDuty, rejectManagementByFID
} from '../../../../api/scheduleManagement'
import {_getLocalStorage} from '../../../../tools/utils'
import {
  acceptThisShitByUsingFuckingFID, cancelByID, delDraftByID,
  getMyArrages,
  IGiveUpThisShitByUsingFuckingFID,
  rejectThisShitByUsingFuckingFID
} from '../../../../api/student'
// eslint-disable-next-line camelcase
import Appointment_BUT_with_FID from './Appointment_BUT_with_FID'

export default {
  components: {
    Appointment_BUT_with_FID
  },
  data () {
    return {
      editDraftMode: false,
      currState: '',
      currStateNum: '',
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
          label: '非常紧急'
        },
        {
          value: 2,
          label: '紧急'
        },
        {
          value: 3,
          label: '一般'
        }
      ],
      teacher: '',
      room: '',
      time1: [],
      time2: [],
      date: [],
      wkd: [],
      formLabelWidth: '120px',
      tableData: [],
      timeOptions: [],
      teacherOptions: [],
      roomOptions: [],
      selectedId: '',
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
    this.load()
    console.log(this.tableData)
    getQuestionPool().then(res => {
      this.questionPool = res.data
    })
    this.dutyData = []
    getDuty().then(res => {
      res.data.map(day => {
        day.map(duty => {
          this.dutyData.push({
            weekday: duty.dayOfWeek,
            name: duty.teacherName,
            time: duty.startTime + duty.endTime,
            classroom: duty.roomName,
            status: (duty.roomName === null)
          })
        })
      })
    })
  },
  methods: {
    _YES_OF_COURSE () {
      acceptThisShitByUsingFuckingFID(this.selectedId).then(res => {
        if (res.status === true) {
          this.$message.success(res.message)
          this.load()
          this.preCheckDialogEnabled = false
        } else {
          this.$message.error(res.message)
        }
      })
    },
    _FUCK_YOU_I_DONT_LIKE_THIS_TEACHER () {
      rejectThisShitByUsingFuckingFID(this.selectedId).then(res => {
        if (res.status === true) {
          this.$message.success(res.message)
          this.load()
          this.preCheckDialogEnabled = false
        } else {
          this.$message.error(res.message)
        }
      })
    },
    _I_GIVE_UP () {
      this.$confirm('确定要放弃排队吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        IGiveUpThisShitByUsingFuckingFID(this.selectedId).then(res => {
          if (res.status === true) {
            this.$message.success(res.message)
            this.load()
            this.preCheckDialogEnabled = false
          } else {
            this.$message.error(res.message)
          }
        })
      })
    },
    spanMtd ({row, column, rowIndex, columnIndex}) {
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
      let timeAttr = this.schedulingForm.time.split('|')
      addNewPreVisitArrange(timeAttr[0], parseInt(timeAttr[1]), timeAttr[2], timeAttr[3], this.schedulingForm.teacherUID, this.schedulingForm.roomID, this.selectedId).then(res => {
        if (res.data === true) {
          this.$message.success(res.message)
          this.schedulingDialogEnabled = false
        } else {
          this.$message.error(res.message)
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
      this.myID = _getLocalStorage('id')
      return getMyArrages(_getLocalStorage('id')).then(res => {
        this.tableData = []
        this.tableData = this.parseResponse(res.data)
      })
    },
    handleCancel (id) {
      this.$confirm('此操作将取消本次预约，是否继续？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        cancelByID(id).then(res => {
          if (res.status === true) {
            this.$message.success(res.message)
          } else {
            this.$message.error(res.message)
          }
          this.load()
        })
      })
    },
    startEditMyDraftByFID (id) {
      this.selectedId = id
      this.editDraftMode = true
    },
    handleBackToList () {
      this.$confirm('确定要返回列表吗？未保存的表单项将会丢失！', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.editDraftMode = false
      })
    },
    handleKillDraft (id) {
      this.$confirm('此操作将永久删除草稿，是否继续？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        delDraftByID(id).then(res => {
          if (res.status === true) {
            this.$message.success(res.message)
          } else {
            this.$message.error(res.message)
          }
          this.load()
        })
      })
    },
    handleCheck (row, index) {
      this.currState = row.state
      this.currStateNum = row.stateNum
      this.questionInfo = []
      this.selectedId = this.tableData[index].id
      this.time1 = row.time1
      this.time2 = row.time2
      this.wkd = row.wkd
      this.date = row.date
      return getPreVisitDetailByID(this.selectedId).then(res => {
        console.log('1')
        console.log(res)
        if (res.data.teacher === null || res.data.teacher === undefined || res.data.teacher === '') {
          this.teacher = ''
        } else {
          this.teacher = res.data.teacher.name
        }
        if (res.data.room === null || res.data.room === undefined || res.data.room === '') {
          this.room = ''
        } else {
          this.room = res.data.room.name
        }

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
        this.preCheckDialogEnabled = true
      })
    },
    stateTranslater (stateid) {
      let _state = ''
      switch (stateid) {
        case 1:
          _state = '等待安排'
          break
        case 2:
          _state = '待确认'
          break
        case 3:
          _state = '已匹配'
          break
        case 4:
          _state = '等待新安排'
          break
        case 5:
          _state = '放弃排队'
          break
        case 6:
          _state = '已拒绝'
          break
        case 7:
          _state = '访谈中'
          break
        case 8:
          _state = '已结束'
          break
        case 9:
          _state = '已取消'
          break
        case 10:
          _state = '未提交'
          break
      }
      return _state
    },
    parseResponse (resp) {
      console.log(resp)
      let parsedData = []
      resp.map(item => {
        console.log(item)
        let stateText = this.stateTranslater(item.state)
        let teacher = ''
        if (item.teacher === null || item.teacher === undefined || item.teacher === '') {
          teacher = ''
        } else {
          teacher = item.teacher.name
        }
        parsedData.push({
          fid: item.fid,
          id: item.id,
          stateNum: item.state,
          state: stateText,
          createDate: item.createDate,
          updateDate: item.updateDate,
          telephone: item.telephone,
          date: item.firstVisitDate,
          time1: item.startTime,
          time2: item.endTime,
          wkd: item.weekDay,
          teacher: teacher
        })
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

.timeSelct {
  width: 80%;
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

.table {
  height: 100%;
}

.submit-btn {
  float: right;
}
.main-div{
  width: 100%;
  height: 95%;
}
</style>
