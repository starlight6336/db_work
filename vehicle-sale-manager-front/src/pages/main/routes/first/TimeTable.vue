<template>
    <div class="background-div">
        <el-header class="header" height="30px">预约时间表</el-header>
        <el-main class="main-div">
            <div class="table-div">
                    <el-table :data="dutyData"
                              :span-method="spanMtd"
                              border
                              style="height: 95%"
                    >
                        <el-table-column
                                label="日期"
                                prop="dayOfWeek">
                            <template slot-scope="scope">
                                <span v-if="scope.row.dayOfWeek === 1">星期一</span>
                                <span v-if="scope.row.dayOfWeek === 2">星期二</span>
                                <span v-if="scope.row.dayOfWeek === 3">星期三</span>
                                <span v-if="scope.row.dayOfWeek === 4">星期四</span>
                                <span v-if="scope.row.dayOfWeek === 5">星期五</span>
                                <span v-if="scope.row.dayOfWeek === 6">星期六</span>
                                <span v-if="scope.row.dayOfWeek === 7">星期日</span>
                        </template>
                        </el-table-column>
                        <el-table-column
                                label="咨询师姓名"
                                prop="teacherName">
                        </el-table-column>
                        <el-table-column
                                label="时段"
                                prop=""><template slot-scope="scope">{{scope.row.startTime.substring(0,5) + '~' + scope.row.endTime.substring(0,5)}}</template>
                        </el-table-column>
                        <el-table-column
                                label="占用教室"
                                prop="roomName">
                        </el-table-column>
                        <el-table-column label="等待释放周数" prop="restTimes"></el-table-column>
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
            </div>
        </el-main>
    </div>
</template>

<script>
import { getQuestionPool, getConsultDetailByID, getConsultRecordList } from '../../../../api/api'
import {getPreCheckDuration} from '../../../../api/schedule'
import {getTime, getAvailableConsultTimeByFID, getAvailableConsultTeacherByDateTimeDay,
  getAvailableConsultRoomByDateTimeDay, addNewConsultArrange, getConsult} from '../../../../api/scheduleManagement'
import {getConsultArrange, getAllConsultArrange, getConsultArrangeByID, getConsultResultByID} from '../../../../api/teacher'

export default {
  data () {
    return {
      dutyData: {
        arrangementDate: '',
        dayOfWeek: '',
        startTime: '',
        endTime: '',
        fid: '',
        uid: '',
        rid: '',
        cid: '',
        teacherName: '',
        roomName: '',
        restTimes: '',
        status: ''
      },
      resultDialogEnabled: false,
      schedulingForm: {
        time: '',
        teacherUID: '',
        roomID: '',
        toggleTeacherSelect: true,
        toggleRoomSelect: true,
        toggleSubmitBtn: true
      },
      resultForm: {
        time: '',
        teacherUID: '',
        roomID: '',
        toggleTeacherSelect: false,
        toggleRoomSelect: false,
        toggleSubmitBtn: true
      },
      timeOptions: [],
      teacherOptions: [],
      roomOptions: [],
      schedulingDialogEnabled: false,
      timeData: {
        arrangementDate: '',
        week: '',
        dayOfWeek: '',
        startTime: '',
        endTime: '',
        uid: '',
        fid: '',
        rid: '',
        cid: '',
        teacherName: '',
        roomName: '',
        restTime: ''
      },
      timeVisible: false,
      activeName: 'previsit',
      consultData: {
        id: '',
        cid: '',
        idDone: '',
        weekDay: '',
        startTime: '',
        endTime: '',
        consultTimes: '',
        consultDate: '',
        result: '',
        record: ''
      },
      consultVisible: false,
      reportVisible: false,
      toolBarData_Pre: {
        danger: '',
        result: '',
        temp: [],
        problem: '',
        disease: '',
        facility: '',
        parm: '',
        teachername: '',
        state: ''
      },
      options: [
        {
          value: 1,
          label: '自我问题'
        },
        {
          value: 2,
          label: '恋爱与性心理'
        },
        {
          value: 3,
          label: '性别认同与同性恋'
        },
        {
          value: 4,
          label: '人际关系问题'
        },
        {
          value: 5,
          label: '学习问题'
        },
        {
          value: 6,
          label: '家庭矛盾问题'
        },
        {
          value: 7,
          label: '新生适应问题'
        },
        {
          value: 8,
          label: '应激反应'
        },
        {
          value: 9,
          label: '疑似',
          children: [{
            value: 1,
            label: '抑郁症'
          },
          {
            value: 2,
            label: '焦虑症'
          },
          {
            value: 3,
            label: '双向情感障碍'
          },
          {
            value: 4,
            label: '精神分裂症'
          },
          {
            value: 5,
            label: '人格障碍'
          },
          {
            value: 6,
            label: '强迫症'
          },
          {
            value: 7,
            label: '恶劣环境'
          },
          {
            value: 8,
            label: '适应障碍'
          },
          {
            value: 9,
            label: '进食障碍'
          },
          {
            value: 10,
            label: '社交恐惧症'
          }]
        },
        {
          value: 10,
          label: '确诊',
          children: [{
            value: 1,
            label: '抑郁症'
          },
          {
            value: 2,
            label: '焦虑症'
          },
          {
            value: 3,
            label: '双向情感障碍'
          },
          {
            value: 4,
            label: '精神分裂症'
          },
          {
            value: 5,
            label: '人格障碍'
          },
          {
            value: 6,
            label: '强迫症'
          },
          {
            value: 7,
            label: '恶劣环境'
          },
          {
            value: 8,
            label: '适应障碍'
          },
          {
            value: 9,
            label: '进食障碍'
          },
          {
            value: 10,
            label: '社交恐惧症'
          }]
        }],
      resultTemplate: [
        {
          label: '无需咨询',
          value: 1
        },
        {
          label: '安排咨询',
          value: 2
        },
        {
          label: '转介送诊',
          value: 3
        }
      ],
      dangerTemplate: [
        {
          label: '低',
          value: 1
        },
        {
          label: '中',
          value: 2
        },
        {
          label: '高',
          value: 3
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
      problemInfo: [{
        checked1: '',
        name1: '',
        red1: '',
        checked2: '',
        name2: '',
        red2: ''
      }],
      reportData: {
        id: '',
        rid: '',
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
          id: '',
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
        firstVisit: {
          id: '',
          rid: '',
          sid: '',
          tid1: '',
          selfEmergency: '',
          theme: '',
          expectTime1: '',
          expectTime2: '',
          expectTime3: '',
          submitTime: '',
          score: '',
          firstVisitDate: '',
          weekDay: '',
          startTime: '',
          endTime: '',
          state: '',
          danger: '',
          problem: '',
          disease: '',
          consultationExpectation: '',
          conclusion: '',
          student: {
            id: '',
            loginName: '',
            password: '',
            name: '',
            sex: '',
            birth: '',
            role: '',
            arrangements: '',
            studentInfo: {
              id: '',
              uid: '',
              entrance: '',
              residence: '',
              facility: '',
              telephone: '',
              degree: '',
              emergentContactor: '',
              emergentTelephone: '',
              relationship: '',
              email: ''
            }
          }
        }
      },
      dialogData_Pre: {
        id: '',
        rid: '',
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
          id: '',
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
        firstVisit: {
          id: '',
          rid: '',
          sid: '',
          tid1: '',
          selfEmergency: '',
          theme: '',
          expectTime1: '',
          expectTime2: '',
          expectTime3: '',
          submitTime: '',
          score: '',
          firstVisitDate: '',
          weekDay: '',
          startTime: '',
          endTime: '',
          state: '',
          danger: '',
          problem: '',
          disease: '',
          consultationExpectation: '',
          conclusion: '',
          student: {
            id: '',
            loginName: '',
            password: '',
            name: '',
            sex: '',
            birth: '',
            role: '',
            arrangements: '',
            studentInfo: {
              id: '',
              uid: '',
              entrance: '',
              residence: '',
              facility: '',
              telephone: '',
              degree: '',
              emergentContactor: '',
              emergentTelephone: '',
              relationship: '',
              email: ''
            }
          }
        }
      },
      preCheckDialogEnabled: false,
      stateTemplate: [
      ],
      state: '',
      conclusion: '',
      danger: '',
      tableData_Pre: {
        id: '',
        fid: '',
        cid: '',
        name: '',
        sex: '',
        danger: '',
        problem: '',
        disease: '',
        facility: '',
        telephone: '',
        date: '',
        day: '',
        time: '',
        conclusion: '',
        state: '',
        consulttimes: ''
      },
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
      durationPreCheck: '',
      selectedId: '',
      questionPool: [
        {
          name: '',
          emergent: false,
          selected: false
        }
      ]
    }
  },
  created () {
    getConsult().then(res => {
      this.dutyData = res.data
      console.log(this.dutyData)
      this.parseData1(this.dutyData)
    })
    getPreCheckDuration().then(res => {
      this.durationPreCheck = res.data
    })
    getAllConsultArrange().then(res => {
      console.log(res)
      this.tableData_Pre = res.data
      this.parseData(this.tableData_Pre)
      console.log(this.tableData_Pre)
    })
    getQuestionPool().then(res => {
      this.questionPool = res.data
    })
    getTime().then(duty => {
      this.timeData = duty.data
      this.timeData.week = duty.arrangementDate + duty.dayOfWeek
      console.log(this.timeData)
    })
  },
  methods: {
    handleOpen (row, index) {
      getConsultResultByID(this.tableData_Pre[index].cid).then(res => {
        console.log(res)
        this.resultForm = res.data
        this.parseData1(this.resultForm)
      })
      this.resultDialogEnabled = true
    },
    parseData1 (data) {
      console.log(data)
      // 处理显示日期
      let parsedData = []
      data.map(item => {
        let _status
        if (item.roomName === null) {
          _status = '可用'
        } else {
          _status = '占用'
        }
        parsedData.push({
          arrangementDate: item.arrangementDate,
          dayOfWeek: item.dayOfWeek,
          startTime: item.startTime,
          endTime: item.endTime,
          fid: item.fid,
          uid: item.uid,
          rid: item.rid,
          cid: item.cid,
          teacherName: item.teacherName,
          roomName: item.roomName,
          restTimes: item.restTimes,
          status: _status
        })
      })
      this.dutyData = parsedData
    },
    spanMtd ({row, column, rowIndex, columnIndex}) {
    },
    handleCheckTime () {
      getTime().then(duty => {
        this.timeData = duty.data
        console.log(duty)
      })
      this.timeVisible = true
    },
    handleChange (value) {
      console.log(value)
    },
    handleClick (tab, event) {
      console.log(tab, event)
    },
    reportCheck (row, index) {
      this.selectedId = this.tableData_Pre[index].cid
      getConsultDetailByID(this.selectedId).then(res => {
        console.log(res)
        console.log(12321321)
        this.reportData = res.data
      })
      this.reportVisible = true
    },
    submitScheduleForm () {
      console.log(this.selectedId)
      let timeAttr = this.schedulingForm.time.split('|')
      let temp = this.selectedId
      addNewConsultArrange(timeAttr[0], parseInt(timeAttr[1]), timeAttr[2], timeAttr[3], this.schedulingForm.teacherUID, temp, this.schedulingForm.roomID).then(res => {
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
      getAvailableConsultTeacherByDateTimeDay(timeAttr[0], parseInt(timeAttr[1]), timeAttr[2], timeAttr[3]).then(res => {
        res.data.map(item => {
          this.teacherOptions.push({label: item.name, value: item.id})
        })
      })
      getAvailableConsultRoomByDateTimeDay(timeAttr[0], parseInt(timeAttr[1]), timeAttr[2], timeAttr[3]).then(res => {
        console.log(res)
        res.data.map(item => {
          this.roomOptions.push({label: item.name, value: item.id})
        })
      })
      this.schedulingForm.toggleTeacherSelect = false
      this.schedulingForm.toggleRoomSelect = false
    },
    handleEnableScheduling (row, index) {
      console.log(this.tableData_Pre)
      console.log(this.tableData_Pre[index].fid)
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
      this.selectedId = this.tableData_Pre[index].fid
      console.log(this.selectedId)
      getAvailableConsultTimeByFID(this.selectedId).then(res => {
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
      return getConsultArrangeByID(this.selectedId).then(res => {
        this.dialogData_Pre = res.data
        this.schedulingDialogEnabled = true
      })
    },
    handleCheck (row, index) {
      this.questionInfo = []
      this.selectedId = this.tableData_Pre[index].cid
      console.log(this.tableData_Pre[index])
      return getConsultArrangeByID(this.selectedId).then(res => {
        this.dialogData_Pre = res.data
        console.log(res)
        console.log(this.dialogData_Pre.firstVisit.student.studentInfo.facility)
        this.stuInfo[0].value1 = this.dialogData_Pre.firstVisit.student.name
        this.stuInfo[0].value2 = this.dialogData_Pre.firstVisit.student.sex
        this.stuInfo[1].value1 = this.dialogData_Pre.firstVisit.student.birth
        this.stuInfo[1].value2 = this.dialogData_Pre.firstVisit.student.id
        this.stuInfo[2].value1 = this.dialogData_Pre.firstVisit.student.studentInfo.facility
        this.stuInfo[2].value2 = this.dialogData_Pre.firstVisit.student.studentInfo.telephone
        this.stuInfo[3].value1 = this.dialogData_Pre.firstVisit.student.studentInfo.degree
        this.stuInfo[3].value2 = this.dialogData_Pre.firstVisit.student.studentInfo.emergentContactor
        this.stuInfo[4].value1 = this.dialogData_Pre.firstVisit.student.studentInfo.emergentTelephone
        this.stuInfo[4].value2 = this.dialogData_Pre.firstVisit.student.studentInfo.relationship
        // 咨询板块
        let string = ''
        switch ('' + this.dialogData_Pre.firstVisit.theme) {
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
        if (this.dialogData_Pre.firstVisit.consultationExpectation === null || this.dialogData_Pre.firstVisit.consultationExpectation === undefined || this.dialogData_Pre.firstVisit.consultationExpectation === '') {
          this.consultInfo[0].value2 = '暂无'
        } else {
          this.consultInfo[0].value2 = this.dialogData_Pre.firstVisit.consultationExpectation
        }
        // 紧急状态
        switch ('' + this.dialogData_Pre.firstVisit.selfEmergency) {
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
        if (this.dialogData_Pre.firstVisit.score === null || this.dialogData_Pre.firstVisit.score === undefined || this.dialogData_Pre.firstVisit.score === '') {
          this.consultInfo[1].value2 = '暂无'
        } else {
          this.consultInfo[1].value2 = this.dialogData_Pre.firstVisit.score
        }
        // 问题检测
        res.data.firstVisit.questions.map(item => {
          this.questionPool.map(item2 => {
            if (item.id === item2.id) {
              item2.selected = true
            }
          })
        })
        console.log(this.questionPool)
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
              console.log(temp)
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
    handleFind () {
      return getConsultArrange(this.toolBarData_Pre).then(res => {
        this.tableData_Pre = res.data
        this.parseData(this.tableData_Pre)
      })
    },
    getrecordlist (row, index) {
      this.selectedId = this.tableData_Pre[index].cid
      getConsultRecordList(this.selectedId).then(res => {
        console.log(res)
        this.consultData = res.data
      })
      this.consultVisible = true
    },
    parseData (data) {
      console.log('s')
      console.log(data)
      let parsedData = []
      data.map(item => {
        console.log(item)
        // 处理显示日期
        if (item.data === null) {
          let _danger
          switch (item.danger) {
            case 1:
              _danger = '低'
              break
            case 2:
              _danger = '中'
              break
            case 3:
              _danger = '高'
              break
          }
          parsedData.push({
            fid: item.fid,
            cid: item.cid,
            sex: item.sex,
            problem: item.problem,
            disease: item.disease,
            id: item.id,
            name: item.name,
            facility: item.facility,
            danger: _danger,
            date: '',
            state: '',
            time: '',
            telephone: item.telephone,
            conclusion: item.conclusion,
            teachername: item.teachername,
            consulttimes: item.consulttimes
          })
        } else {
          let s1 = item.date
          let s2 = item.time
          let hour = parseInt(s2.substring(0, 2))
          let mnt = parseInt(s2.substring(3, 5))
          let duration = parseInt(this.durationPreCheck)
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
          let submitTime1 = s2.substring(0, 5)
          let submitTime2 = hour + ':' + mnt
          let labelText = submitTime1 + '~' + submitTime2
          // submitTime1 = submitTime1 + ':00'
          // submitTime2 = submitTime2 + ':00'
          let weekdays = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日']
          let wkd = weekdays[new Date(s1).getDay() - 1]
          let output = s1 + '(' + wkd + ')' + labelText
          let _danger
          switch (item.danger) {
            case 1:
              _danger = '低'
              break
            case 2:
              _danger = '中'
              break
            case 3:
              _danger = '高'
              break
          }
          parsedData.push({
            fid: item.fid,
            cid: item.cid,
            id: item.id,
            sex: item.sex,
            state: item.state,
            problem: item.problem,
            disease: item.disease,
            name: item.name,
            facility: item.facility,
            danger: _danger,
            date: output,
            conclusion: item.conclusion,
            telephone: item.telephone,
            teachername: item.teachername,
            consulttimes: item.consulttimes
          })
        }
      })
      this.tableData_Pre = parsedData
    }
  }
}
</script>
<style scoped>
    .inner-form {
        width: 100%;
    }

    .inner-form d {
        font-size: 12px;
        width: 20%;
    }

    .inner-form a {
        font-size: 12px;
        width: 20%;
    }

    .background-div {
        background-color: ghostwhite;
        height: 100%;
        width: 100%;
    }

    .header {
        box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.1);
        line-height: 30px;
        font-size: 20px;
        background-color: white;
    }

    .main-div {
        margin: 0.5%;
        padding: 0.5% 0.5% 0.5% 1%;
        box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.1);
        background-color: white;
        height: 92%;
    }

    .menu-item :hover {
        color: white
    }

    .toolbar-input {
        width: 15%;
    }

    .btn {
        margin-left: 1%;
        float: right;
    }

    .table {
        margin-top: 0.5%;
    }

    .background-div {
        background-color: ghostwhite;
        height: 100%;
        width: 100%;
    }

    .header {
        box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.1);
        line-height: 30px;
        font-size: 20px;
        background-color: white;
    }

    .main-div {
        margin: 0.5%;
        padding: 0.5% 0.5% 0.5% 1%;
        box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.1);
        background-color: white;
    }

    .label {
        color: darkgray;
        font-weight: bolder;
        margin: 0;
        padding: 0;
    }

    .value {
        margin: 0;
        padding: 0;
    }

    .red {
        color: red;
    }
    .green{
        color:green;
    }
    .norm {
        color: black;
    }
</style>
