<template>
  <div class="background-div">
    <el-main class="main-div">
      <div class="tool-bar">
        <el-input class="toolbar-input" size="small" placeholder="请输入学院" v-model="toolBarData_Pre.facility"
                  clearable></el-input>
        <el-input class="toolbar-input" size="small" placeholder="请输入姓名或学号" v-model="toolBarData_Pre.parm"
                  clearable></el-input>
        <el-select v-model="toolBarData_Pre.state" placeholder="请选择初访状态" size="small" clearable>
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
        <br>
        <el-select v-model="toolBarData_Pre.selfemergency" placeholder="请选择紧急程度" size="small" clearable>
          <el-option
              v-for="item in emergencyTemplate"
              :key="item.value"
              :label="item.label"
              :value="item.value">
          </el-option>
        </el-select>
        <el-select v-model="toolBarData_Pre.theme" placeholder="请选择咨询主题" size="small" clearable>
          <el-option
              v-for="item in themeTemplate"
              :key="item.value"
              :label="item.label"
              :value="item.value">
          </el-option>
        </el-select>
        <el-cascader
            v-model="toolBarData_Pre.temp"
            :options="problemTemplate"
            clearable
            placeholder="请选择问题类型"
            size="small"
            style="margin-right: 10px">
        </el-cascader>
        <el-button type="primary" size="small" @click="handleFind" class="btn">查询</el-button>
      </div>
      <div class="table-div">
        <el-table
            class="table"
            :data="tableData_Pre"
            height="590"
            border
            style="width: 100%">
          <el-table-column type="index" label="序号" fixed width="50px">
          </el-table-column>
          <el-table-column
              prop="id"
              label="学号"
              width="120">
          </el-table-column>
          <el-table-column
              prop="name"
              label="姓名"
              width="120">
          </el-table-column>
          <el-table-column
              prop="sex"
              label="性别"
              width="120">
          </el-table-column>
          <el-table-column
              prop="themeText"
              label="主题"
              width="120">
          </el-table-column>
          <el-table-column
              prop="score"
              label="问卷得分"
              width="100">
          </el-table-column>
          <el-table-column
              prop="selfEmergency"
              label="自述紧急程度"
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
              prop="room"
              label="初访地点"
              width="100">
          </el-table-column>
          <el-table-column
              prop="problem"
              label="来访者诊断"
              width="100">
          </el-table-column>
          <el-table-column
              prop="teacher"
              label="初访老师"
              width="100">
          </el-table-column>
          <el-table-column
              prop="state"
              label="初访状态"
              width="100">
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
              width="250"
          >
            <template slot-scope="scope">
              <div v-if="scope.row.state===8">
                <el-button type="text" @click="handleCheckConclusion(scope.row,scope.$index)">查看初访结果</el-button>
              </div>
              <div v-else-if="scope.row.state===7">
                <el-button type="text" @click="handleCheck(scope.row,scope.$index)">查看详情</el-button>
                <el-button type="text" @click="handleMakeConclusion(scope.row,scope.$index)">录入初访结论并结束初访</el-button>
              </div>
              <div v-else-if="scope.row.state===3">
                <el-button type="text" @click="handleCheck(scope.row,scope.$index)">查看详情</el-button>
                <el-button type="text" @click="handleStartPreConsult(scope.$index)">开始访谈</el-button>
              </div>
              <div v-else>
                <el-button type="text" @click="handleCheck(scope.row,scope.$index)">查看详情</el-button>
              </div>
            </template>
          </el-table-column>
        </el-table>
      </div>

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
        <el-form-item v-if="conclusionMode" label="初访信息">
          <el-form :inline="true">
            <el-select v-model="preVisitConclusionData.conclusion" :disabled="!modConclusionMode" placeholder="请选择初访结论" size="small">
              <el-option
                  v-for="item in conclusionTemplate"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
              </el-option>
            </el-select>
            <el-cascader
                :disabled="!modConclusionMode"
                v-model="preVisitConclusionData.temp"
                :options="problemTemplate"
                placeholder="请选择问题类型"
                size="small"
                style="margin-right: 10px">
            </el-cascader>
            <el-input v-model="preVisitConclusionData.consultationExpectation" :readonly="!modConclusionMode" type="textarea" style="margin-top: 1%" autosize placeholder="请输入咨询期望"></el-input>
          </el-form>
          <el-button v-if="modConclusionMode" style="float: right;margin-top: 1%" type="success" @click="saveConclusion">提交</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script>
import {getPreVisitDetailByID, getQuestionPool} from '../../../../api/api'
import {getPreCheckDuration} from '../../../../api/schedule'
import {_getLocalStorage} from '../../../../tools/utils'
import {
  getAllMyPreVisitList, getConclusion,
  getMyPreVisitList,
  savePreVisitConclusion,
  startPreVisit
} from '../../../../api/preVisitor'

export default {
  data () {
    return {
      preVisitConclusionData: {
        danger: '',
        consultationExpectation: '',
        conclusion: '',
        problem: '',
        disease: '',
        temp: [],
        id: ''
      },
      activeName: 'previsit',
      toolBarData_Pre: {
        theme: '',
        selfemergency: '',
        problem: '',
        disease: '',
        parm: '',
        facility: '',
        conclusion: '',
        state: '',
        temp: ''
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
      emergencyTemplate: [
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
      themeTemplate: [
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
        }, {
          value: 10,
          label: '家庭问题'
        },
        {
          value: 11,
          label: '其他'
        }

      ],
      stateTemplate: [
        {
          value: 1,
          label: '等待安排'
        },
        {
          value: 2,
          label: '待确认'
        },
        {
          value: 3,
          label: '已匹配'
        },
        {
          value: 4,
          label: '等待新安排'
        },
        {
          value: 5,
          label: '放弃排队'
        },
        {
          value: 6,
          label: '已拒绝'
        },
        {
          value: 7,
          label: '访谈中'
        },
        {
          value: 8,
          label: '已结束'
        },
        {
          value: 9,
          label: '已取消'
        }
      ],
      problemTemplate: [
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
      state: '',
      myID: '',
      conclusionMode: false,
      modConclusionMode: false,
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
    this.myID = _getLocalStorage('id')
    getPreCheckDuration().then(res => {
      this.durationPreCheck = res.data
      getAllMyPreVisitList(this.myID).then(res => {
        console.log(res)
        this.tableData_Pre = res.data
        this.parseData(this.tableData_Pre)
      })
    })

    getQuestionPool().then(res => {
      this.questionPool = res.data
    })
  },
  methods: {
    saveConclusion () {
      if (this.preVisitConclusionData.temp === null || this.preVisitConclusionData.temp === '' || this.preVisitConclusionData.temp === '' || this.preVisitConclusionData.conclusion === null || this.preVisitConclusionData.conclusion === '' || this.preVisitConclusionData.conclusion === '' || this.preVisitConclusionData.consultationExpectation === null || this.preVisitConclusionData.consultationExpectation === '' || this.preVisitConclusionData.consultationExpectation === '') {
        this.$message.error('请完整填写初访结论')
        return
      }
      this.$confirm('确认提交初访结论并结束初访?', '结束初访', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        if (this.preVisitConclusionData.temp.length === 2) {
          this.preVisitConclusionData.problem = this.preVisitConclusionData.temp[0]
          this.preVisitConclusionData.disease = this.preVisitConclusionData.temp[1]
        } else {
          this.preVisitConclusionData.problem = this.preVisitConclusionData.temp[0]
        }
        let json = {
          id: this.selectedId,
          danger: this.preVisitConclusionData.danger,
          disease: this.preVisitConclusionData.disease,
          conclusion: this.preVisitConclusionData.conclusion,
          consultationExpectation: this.preVisitConclusionData.consultationExpectation
        }
        savePreVisitConclusion(json).then(res => {
          if (res.data === true) {
            this.$message.success(res.message)
            this.handleFind()
            this.preCheckDialogEnabled = false
            this.modConclusionMode = false
            this.conclusionMode = false
          } else {
            this.$message.error(res.message)
          }
        })
      })
    },
    handleClick (tab, event) {
      console.log(tab, event)
    },
    handleStartPreConsult (index) {
      this.selectedId = this.tableData_Pre[index].fid
      startPreVisit(this.selectedId).then(res => {
        console.log(this.selectedId)
        console.log(res)
        console.log('sfsdf')
        if (res.data === true) {
          this.$message.success(res.message)
        } else {
          this.$message.error(res.message)
        }
        this.handleFind()
      })
    },
    handleCheck (row, index) {
      this.conclusionMode = false
      this.modConclusionMode = false
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
    handleCheckConclusion (row, index) {
      this.conclusionMode = true
      this.modConclusionMode = false
      this.questionInfo = []
      this.selectedId = this.tableData_Pre[index].fid
      return getPreVisitDetailByID(this.selectedId).then(res => {
        getConclusion(this.selectedId).then(res => {
          this.preVisitConclusionData.conclusion = res.data.conclusion
          this.preVisitConclusionData.danger = res.data.danger
          this.preVisitConclusionData.temp = []
          this.preVisitConclusionData.temp.push(res.data.problem)
          if (res.data.disease === null) {} else {
            this.preVisitConclusionData.temp.push(res.data.disease)
          }
          this.preVisitConclusionData.consultationExpectation = res.data.consultationExpectation
        })
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
    handleMakeConclusion (row, index) {
      this.conclusionMode = true
      this.modConclusionMode = true
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
      this.toolBarData_Pre.problem = this.toolBarData_Pre.temp[0]
      this.toolBarData_Pre.disease = this.toolBarData_Pre.temp[1]
      return getMyPreVisitList(this.myID, this.toolBarData_Pre.theme, this.toolBarData_Pre.selfemergency, this.toolBarData_Pre.problem, this.toolBarData_Pre.disease, this.toolBarData_Pre.parm, this.toolBarData_Pre.facility, this.toolBarData_Pre.conclusion, this.toolBarData_Pre.state).then(res => {
        console.log(this.toolBarData_Pre)
        this.tableData_Pre = res.data
        this.parseData(this.tableData_Pre)
      })
    },
    parseData (data) {
      console.log(data)
      let parsedData = []
      data.map(item => {
        // 处理显示日期
        if (item.date === null) {
          let textDanger = ''
          switch (item.selfemergency) {
            case 1:
              textDanger = '一般'
              break
            case 2:
              textDanger = '紧急'
              break
            case 3:
              textDanger = '非常紧急'
              break
          }
          let problemText = ''
          switch (item.problem) {
            case 1:
              problemText = '自我问题'
              break
            case 2:
              problemText = '恋爱与性心理'
              break
            case 3:
              problemText = '性别认同与同性恋'
              break
            case 4:
              problemText = '人际关系问题'
              break
            case 5:
              problemText = '学习问题'
              break
            case 6:
              problemText = '家庭矛盾问题'
              break
            case 7:
              problemText = '新生适应问题'
              break
            case 8:
              problemText = '应激反应'
              break
            case 9:
              problemText = '疑似'
              switch (item.disease) {
                case 1:
                  problemText += '-抑郁症'
                  break
                case 2:
                  problemText += '-焦虑症'
                  break
                case 3:
                  problemText += '-双向情感障碍'
                  break
                case 4:
                  problemText += '-精神分裂症'
                  break
                case 5:
                  problemText += '-人格障碍'
                  break
                case 6:
                  problemText += '-强迫症'
                  break
                case 7:
                  problemText += '-恶劣环境'
                  break
                case 8:
                  problemText += '-适应障碍'
                  break
                case 9:
                  problemText += '-进食障碍'
                  break
                case 10:
                  problemText += '-社交恐惧症'
                  break
              }

              break
            case 10:
              problemText = '确诊'
              switch (item.disease) {
                case 1:
                  problemText += '-抑郁症'
                  break
                case 2:
                  problemText += '-焦虑症'
                  break
                case 3:
                  problemText += '-双向情感障碍'
                  break
                case 4:
                  problemText += '-精神分裂症'
                  break
                case 5:
                  problemText += '-人格障碍'
                  break
                case 6:
                  problemText += '-强迫症'
                  break
                case 7:
                  problemText += '-恶劣环境'
                  break
                case 8:
                  problemText += '-适应障碍'
                  break
                case 9:
                  problemText += '-进食障碍'
                  break
                case 10:
                  problemText += '-社交恐惧症'
                  break
              }
              break
            case 11:
              problemText = '其他'
              break
          }
          parsedData.push({
            room: item.room,
            problem: problemText,
            score: item.score,
            theme: item.theme,
            sex: item.sex,
            fid: item.fid,
            id: item.id,
            name: item.name,
            facility: item.facility,
            state: item.state,
            conclusion: item.conclusion,
            date: '',
            telephone: item.telephone,
            teacher: item.teacher,
            selfEmergency: textDanger
          })
        } else {
          console.log(item)

          let s1 = item.date
          let s2 = item.time.substring(0, 5)
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
          console.log(item.conclusion)
          console.log(_conclusion)
          let textDanger = ''
          switch (item.selfemergency) {
            case 1:
              textDanger = '一般'
              break
            case 2:
              textDanger = '紧急'
              break
            case 3:
              textDanger = '非常紧急'
              break
          }
          console.log(textDanger)
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
          console.log(_state)
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
          let problemText = ''
          switch (item.problem) {
            case 1:
              problemText = '自我问题'
              break
            case 2:
              problemText = '恋爱与性心理'
              break
            case 3:
              problemText = '性别认同与同性恋'
              break
            case 4:
              problemText = '人际关系问题'
              break
            case 5:
              problemText = '学习问题'
              break
            case 6:
              problemText = '家庭矛盾问题'
              break
            case 7:
              problemText = '新生适应问题'
              break
            case 8:
              problemText = '应激反应'
              break
            case 9:
              problemText = '疑似'
              switch (item.disease) {
                case 1:
                  problemText += '-抑郁症'
                  break
                case 2:
                  problemText += '-焦虑症'
                  break
                case 3:
                  problemText += '-双向情感障碍'
                  break
                case 4:
                  problemText += '-精神分裂症'
                  break
                case 5:
                  problemText += '-人格障碍'
                  break
                case 6:
                  problemText += '-强迫症'
                  break
                case 7:
                  problemText += '-恶劣环境'
                  break
                case 8:
                  problemText += '-适应障碍'
                  break
                case 9:
                  problemText += '-进食障碍'
                  break
                case 10:
                  problemText += '-社交恐惧症'
                  break
              }

              break
            case 10:
              problemText = '确诊'
              switch (item.disease) {
                case 1:
                  problemText += '-抑郁症'
                  break
                case 2:
                  problemText += '-焦虑症'
                  break
                case 3:
                  problemText += '-双向情感障碍'
                  break
                case 4:
                  problemText += '-精神分裂症'
                  break
                case 5:
                  problemText += '-人格障碍'
                  break
                case 6:
                  problemText += '-强迫症'
                  break
                case 7:
                  problemText += '-恶劣环境'
                  break
                case 8:
                  problemText += '-适应障碍'
                  break
                case 9:
                  problemText += '-进食障碍'
                  break
                case 10:
                  problemText += '-社交恐惧症'
                  break
              }
              break
            case 11:
              problemText = '其他'
              break
          }
          parsedData.push({
            room: item.room,
            problem: problemText,
            score: item.score,
            themeText: themeText,
            theme: item.theme,
            sex: item.sex,
            fid: item.fid,
            id: item.id,
            name: item.name,
            facility: item.facility,
            state: item.state,
            conclusion: item.conclusion,
            date: output,
            telephone: item.telephone,
            teacher: item.teacher,
            selfEmergency: textDanger
          })
        }
      })
      this.tableData_Pre = parsedData
      console.log(this.tableData_Pre)
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
  height: 98%;
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
