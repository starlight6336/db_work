<template>
  <div class="background-div">
    <el-header class="header" height="30px">咨询管理</el-header>
    <el-main class="main-div">
      <el-tabs v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="初访列表" name="previsit">
          <div class="tool-bar">
            <el-input class="toolbar-input" size="small" placeholder="请输入学院" v-model="toolBarData_Pre.facility"
                      clearable></el-input>
            <el-input class="toolbar-input" size="small" placeholder="请输入姓名或学号" v-model="toolBarData_Pre.parm"
                      clearable></el-input>
            <el-input class="toolbar-input" size="small" placeholder="请输入初访员姓名"
                      v-model="toolBarData_Pre.teachername" clearable></el-input>
            <el-select v-model="toolBarData_Pre.state" placeholder="请选择初访结果" size="small" clearable>
              <el-option
                  v-for="item in stateTemplate"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
              </el-option>
            </el-select>
            <el-select v-model="toolBarData_Pre.conclusion" placeholder="请选择初访结论" size="small" clearable>
              <el-option
                  v-for="item in conclusionTemplate"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
              </el-option>
            </el-select>
            <el-button type="primary" size="small" @click="handleFind" class="btn">查询</el-button>
          </div>
          <div class="table-div">
            <el-table
                class="table"
                :data="tableData_Pre"
                height="500"
                border
                style="width: 100%">
              <el-table-column type="index" label="序号" fixed width="50px">
              </el-table-column>
              <el-table-column
                  prop="loginName"
                  label="学号"
                  width="120">
              </el-table-column>
              <el-table-column
                  prop="name"
                  label="姓名"
                  width="120">
              </el-table-column>
              <el-table-column
                  prop="facility"
                  label="学院"
                  width="180">
              </el-table-column>
              <el-table-column
                  prop="telephone"
                  label="联系方式"
                  width="120">
              </el-table-column>
              <el-table-column
                  prop="date"
                  label="初访时间"
                  width="150">
              </el-table-column>
              <el-table-column
                  prop="teacher"
                  label="初访老师"
                  width="100">
              </el-table-column>
              <el-table-column
                  prop="state"
                  label="初访状态"
                  width="180">
                <template slot-scope="scope">
                  <span v-if="scope.row.state === 1">等待安排</span>
                  <span v-if="scope.row.state === 2">待确认</span>
                  <span v-if="scope.row.state === 3">匹配成功 等待访谈</span>
                  <span v-if="scope.row.state === 4">等待新安排</span>
                  <span v-if="scope.row.state === 5">放弃排队</span>
                  <span v-if="scope.row.state === 6">已拒绝</span>
                  <span v-if="scope.row.state === 7">访谈中</span>
                  <span v-if="scope.row.state === 8">已结束</span>
                  <span v-if="scope.row.state === 9">已取消</span>
                  <span v-if="scope.row.state === 10">未提交</span>
                </template>
              </el-table-column>
              <el-table-column
                  prop="conclusion"
                  label="初访结论">
                <template slot-scope="scope">
                  <span v-if="scope.row.conclusion === 1">无需咨询</span>
                  <span v-if="scope.row.conclusion === 2">安排咨询</span>
                  <span v-if="scope.row.conclusion === 3">转介送诊</span>
                </template>
              </el-table-column>
              <el-table-column
                  label="操作"
              >
                <template slot-scope="scope">
                  <el-button @click="handleCheck(scope.row,scope.$index)" size="mini">查看详情</el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </el-tab-pane>
        <el-tab-pane label="心理咨询列表" name="consults">
          <ConsultManageSub></ConsultManageSub>
        </el-tab-pane>
      </el-tabs>
      <div class="line"></div>
    </el-main>
    <el-dialog
        :title="'查看初访详情:'"
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
  </div>
</template>

<script>
import {getAllPreVisitList, getPreVisitDetailByID, getPreVisitList, getQuestionPool} from '../../../../api/api'
import {getPreCheckDuration} from '../../../../api/schedule'
import ConsultManageSub from './ConsultManageSub'

export default {
  components: {ConsultManageSub},
  data () {
    return {
      activeName: 'previsit',
      toolBarData_Pre: {
        facility: '',
        parm: '',
        teachername: '',
        conclusion: '',
        state: ''
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
      dialogData_Pre: {
        expectTime1: '',
        expectTime2: '',
        expectTime3: '',
        student: {
          name: '',
          sex: '',
          birth: '',
          id: '',
          studentInfo: {
            facility: '',
            telephone: '',
            degree: '',
            emergentContactor: '',
            emergentTelephone: '',
            relationship: ''
          }
        },
        theme: '',
        questions: [{
          name: '',
          emergent: ''
        }],
        selfEmergency: '',
        score: '',
        consultationExpectation: ''
      },
      preCheckDialogEnabled: false,
      conclusionTemplate: [
        {
          value: 1,
          label: '无需咨询'
        },
        {
          value: 2,
          label: '安排咨询'
        },
        {
          value: 3,
          label: '转介送诊'
        }
      ],
      stateTemplate: [
        {
          value: 3,
          label: '匹配成功 等待访谈'
        },
        {
          value: 7,
          label: '访谈中'
        },
        {
          value: 8,
          label: '已结束'
        }
      ],
      state: '',
      conclusion: '',
      tableData_Pre: [],
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
    getPreCheckDuration().then(res => {
      this.durationPreCheck = res.data
    })
    getAllPreVisitList().then(res => {
      console.log(res)
      this.tableData_Pre = res.data
      this.parseData(this.tableData_Pre)
    })
    getQuestionPool().then(res => {
      this.questionPool = res.data
    })
  },
  methods: {
    handleClick (tab, event) {
      console.log(tab, event)
    },
    handleCheck (row, index) {
      this.questionInfo = []
      this.selectedId = this.tableData_Pre[index].fid
      return getPreVisitDetailByID(this.selectedId).then(res => {
        console.log(this.selectedId)
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
      return getPreVisitList(this.toolBarData_Pre).then(res => {
        this.tableData_Pre = res.data
        this.parseData(this.tableData_Pre)
      })
    },
    parseData (data) {
      console.log('s')
      console.log(data)
      let parsedData = []
      data.map(item => {
        // 处理显示日期
        if (item.date === null) {
          let _conclusion
          switch (item.conclusion) {
            case 1:
              _conclusion = '无需咨询'
              break
            case 2:
              _conclusion = '安排咨询'
              break
            case 3:
              _conclusion = '转介送诊'
              break
          }
          let _state
          switch (item.state) {
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
          }
          parsedData.push({
            fid: item.fid,
            id: item.id,
            name: item.name,
            facility: item.facility,
            state: _state,
            conclusion: _conclusion,
            date: '',
            telephone: item.telephone,
            teacher: item.teacher
          })
        } else {
          console.log(item.date)
          let s1 = item.date.split('T')[0]
          let s2 = item.date.split('T')[1].substring(0, 5)
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
          let submitTime1 = s2
          let submitTime2 = hour + ':' + mnt
          let labelText = submitTime1 + '~' + submitTime2
          // submitTime1 = submitTime1 + ':00'
          // submitTime2 = submitTime2 + ':00'
          let weekdays = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日']
          let wkd = weekdays[new Date(s1).getDay() - 1]
          let output = s1 + '(' + wkd + ')' + labelText
          let _conclusion
          switch (item.conclusion) {
            case 1:
              _conclusion = '无需咨询'
              break
            case 2:
              _conclusion = '安排咨询'
              break
            case 3:
              _conclusion = '转介送诊'
              break
          }
          let _state
          switch (item.state) {
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
          }
          parsedData.push({
            fid: item.fid,
            id: item.id,
            name: item.name,
            facility: item.facility,
            state: _state,
            conclusion: _conclusion,
            date: output,
            telephone: item.telephone,
            teacher: item.teacher
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

.norm {
  color: black;
}
</style>
