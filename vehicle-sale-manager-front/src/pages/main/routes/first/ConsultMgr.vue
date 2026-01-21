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
        <el-select v-model="toolBarData_Pre.danger" style="margin-top: 1%" placeholder="请选择危机等级" size="small"
                   clearable>
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
              width="80">
          </el-table-column>
          <el-table-column
              prop="danger"
              label="紧急程度"
              width="100">
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
              prop="problem"
              label="来访者诊断"
              width="100">
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
              prop="state"
              label="咨询状态"
              width="100">
            <template slot-scope="scope">
              <span v-if="scope.row.state === 1">等待安排</span>
              <span v-if="scope.row.state === 2">等待咨询</span>
              <span v-if="scope.row.state === 3">咨询中</span>
              <span v-if="scope.row.state === 4">已结案</span>
              <span v-if="scope.row.state === 5">脱落</span>
            </template>
          </el-table-column>
          <el-table-column prop="consulttimes" label="咨询次数">

          </el-table-column>
          <el-table-column
              label="操作"
              width="250"
          >
            <template slot-scope="scope">
              <div v-if="scope.row.state===2">
                <el-button type="text" @click="handleCheck(scope.row,scope.$index)">查看详情</el-button>
                <el-button type="text" @click="handleStartPreConsult(scope.$index)">开始咨询</el-button>
              </div>
              <div v-else-if="scope.row.state===4||scope.row.state===5">
                <el-button type="text" @click="handleCheck(scope.row,scope.$index)">查看详情</el-button>
                <el-button type="text" @click="handleSeeListEnd(scope.row,scope.$index)">查看咨询结果
                </el-button>
                <el-button type="text" @click="handleReport(scope.row,scope.$index)">填写咨询结案报告
                </el-button>
              </div>
              <div v-else-if="scope.row.state===3">
                <el-button type="text" @click="handleCheck(scope.row,scope.$index)">查看详情</el-button>
                <el-button type="text" @click="handleSeeList(scope.row,scope.$index)">编辑咨询记录</el-button>
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
    <el-dialog title="填写咨询结案报告"
               :visible.sync="reportEnabled"
               width="60%">
      <el-form label-position="top" style="margin-left: 5%">
        <el-form-item label="来访者学号">
          {{reportDialogData.stuId}}
        </el-form-item>
        <el-form-item label="来访者姓名">
          {{reportDialogData.name}}
        </el-form-item>
        <el-form-item label="来访者院系">
          {{reportDialogData.facility}}
        </el-form-item>
        <el-form-item label="来访者电话">
          {{reportDialogData.telephone}}
        </el-form-item>
        <el-form-item label="问题">
          {{reportDialogData.questionName}}
        </el-form-item>
        <el-form-item label="咨询总次数">
          {{reportDialogData.totalCount}}
        </el-form-item>
        <el-form-item label="咨询起止日期">
          {{reportDialogData.fromto}}
        </el-form-item>
        <el-form-item label="咨询总结">
          <el-input type="textarea" :readonly="readOnly"  v-model="reportDialogData.comment"></el-input>
        </el-form-item>
        <el-form-item v-if="!readOnly">
          <el-button type="success" @click="endReport">提交</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
    <el-dialog
        :title="'查看详情:'"
        :visible.sync="preCheckDialogEnabled"
        width="80%"
    >
      <el-form label-width="200" label-position="top">
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
        <el-form-item label="初访结论">
          <el-form :inline="true">
            <el-select v-model="preVisitConclusionData.conclusion" :disabled="true"
                       placeholder="请选择初访结论" size="small">
              <el-option
                  v-for="item in conclusionTemplate"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
              </el-option>
            </el-select>
            <el-select v-model="preVisitConclusionData.danger" :disabled="true"
                       placeholder="请选择紧急程度" size="small">
              <el-option
                  v-for="item in emergencyTemplate"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
              </el-option>
            </el-select>
            <el-cascader
                :disabled="true"
                v-model="preVisitConclusionData.temp"
                :options="problemTemplate"
                placeholder="请选择问题类型"
                size="small"
                style="margin-right: 10px">
            </el-cascader>
            <el-input v-model="preVisitConclusionData.consultationExpectation" :readonly="!modConclusionMode"
                      type="textarea" autosize placeholder="请输入咨询期待"></el-input>
          </el-form>
        </el-form-item>
      </el-form>
    </el-dialog>
    <el-dialog
        title="咨询记录"
        :visible.sync="seeListDialogEnabled"
        width="80%"
    >
      <el-dialog
          width="50%"
          title="添加/修改咨询记录"
          :visible.sync="innerVisible"
          append-to-body>
        <el-form label-position="top">
          <el-form-item label="咨询结果">
            <el-select v-model="innerData.result" style="width: 50%" placeholder="请选择咨询状态">
              <el-option value="1" label="完成咨询"></el-option>
              <el-option value="2" label="旷约"></el-option>
              <el-option value="3" label="请假"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="咨询时间">
            <el-date-picker value-format="yyyy-MM-dd HH:mm:ss" type="datetime" v-model="innerData.time"
                            style="width: 50%" placeholder="请选择咨询时间"></el-date-picker>
          </el-form-item>
          <el-form-item label="咨询记录">
            <el-input type="textarea" placeholder="请填写咨询记录" :autosize="{ minRows: 4, maxRows:18}"
                      v-model="innerData.comment" style="height: 100%"></el-input>
          </el-form-item>
          <div>
            <el-button @click="handleCloseInner" plain style="margin-left: 78%" type="primary">取消</el-button>
            <el-button @click="submitInnerDialog" type="primary">确定</el-button>
          </div>

        </el-form>
      </el-dialog>
      <el-dialog
          width="50%"
          title="申请添加咨询次数"
          :visible.sync="addBonusVisible"
          append-to-body>
        <el-form label-position="top">
          <el-form-item label="申请添加咨询次数">
            <el-input-number v-model="bonusData.count" :min="1"></el-input-number>
          </el-form-item>
          <el-form-item label="添加理由">
            <el-input type="textarea" v-model="bonusData.reason" placeholder="请填写增加咨询原因"></el-input>
          </el-form-item>
          <div>
            <el-button @click="submitBonusDialog" type="primary">确定</el-button>
          </div>

        </el-form>
      </el-dialog>
      <div v-if="!end">
        <div style="width: 40%" v-if="response">申请添加进度：已审核</div>
        <div style="width: 40%" v-else>申请添加进度：未审核</div>
        <br>
        <div style="width: 40%" v-if="response">回复：
          <div v-if="okay">已通过</div>
          <div v-else>未通过</div>
        </div>
      </div>

      <el-button v-if="!end" icon="el-icon-plus" size="mini" type="primary" @click="handleAddAdditional"
                 style="margin-bottom: 1%;float: right">申请添加咨询记录
      </el-button>
      <el-table :data="listData" border>
        <el-table-column prop="index" label="咨询次数" width="50">

        </el-table-column>
        <el-table-column prop="time" label="咨询时间" width="300">

        </el-table-column>
        <el-table-column prop="status" label="咨询结果" width="100">

        </el-table-column>
        <el-table-column prop="record" label="咨询记录">

        </el-table-column>
        <el-table-column label="操作" width="100" v-if="!end">
          <template slot-scope="scope">
            <el-button v-if="scope.row.have===true" type="text" @click="handleMod(scope.row,scope.$index)">修改
            </el-button>
            <el-button v-else @click="handleMod(scope.row,scope.$index)" type="text">添加</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import {getConsultRecordList, getQuestionPool} from '../../../../api/api'
import {getConsultDuration} from '../../../../api/schedule'
import {_getLocalStorage} from '../../../../tools/utils'
import {
  applyforAddition, endReport,
  getAllMyConsultList, getApplyResp,
  getConsultConclusion,
  getMyConsultList,
  saveConsultConclusion,
  startConsult, updatePiece
} from '../../../../api/consultant'

export default {
  data () {
    return {
      reportDialogData: {
        totalCount: '',
        name: '',
        stuId: '',
        questionName: '',
        comment: '',
        fromto: '',
        telephone: '',
        facility: '',
        sex: ''
      },
      response: '',
      okay: '',
      preVisitConclusionData: {
        danger: '',
        consultationExpectation: '',
        conclusion: '',
        problem: '',
        disease: '',
        temp: [],
        id: ''
      },
      seeListDialogEnabled: false,
      activeName: 'previsit',
      toolBarData_Pre: {
        theme: '',
        danger: '',
        problem: '',
        disease: '',
        parm: '',
        facility: '',
        conclusion: '',
        state: '',
        temp: ''
      },
      listData: [],
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
          label: '等待咨询'
        },
        {
          value: 3,
          label: '咨询中'
        },
        {
          value: 4,
          label: '已结案'
        },
        {
          value: 5,
          label: '脱落'
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
      readOnly: false,
      index: '',
      end: false,
      innerVisible: false,
      conclusionMode: false,
      modConclusionMode: false,
      conclusion: '',
      tableData_Pre: [],
      durationPreCheck: '',
      selectedId: '',
      innerData: {
        result: '',
        comment: '',
        time: ''
      },
      addBonusVisible: false,
      bonusData: {
        count: '',
        reason: ''
      },
      reportEnabled: false,
      currCID: '',
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
    getConsultDuration().then(res => {
      this.durationPreCheck = res.data
    })
    this.myID = _getLocalStorage('id')
    getConsultDuration().then(res => {
      this.durationPreCheck = res.data
      getAllMyConsultList(this.myID).then(res => {
        this.tableData_Pre = res.data
        this.parseData(this.tableData_Pre)
      })
    })

    getQuestionPool().then(res => {
      this.questionPool = res.data
    })
  },
  methods: {
    endReport () {
      endReport(this.currCID, this.reportDialogData.comment).then(res => {
        if (res.status === true) {
          this.$message.success('已提交')
        } else {
          this.$message.error(res.message)
        }
        this.reportEnabled = false
      })
    },
    submitBonusDialog () {
      if (this.bonusData.count === null || this.bonusData.count === '' || this.bonusData.reason === undefined || this.bonusData.reason === null || this.bonusData.reason === '' || this.bonusData.reason === undefined) {
        this.$message.error('请完整填写表单')
      } else {
        applyforAddition(this.currCID, this.bonusData.count, this.bonusData.reason).then(res => {
          if (res.data === true) {
            this.$message.success(res.message)
          } else {
            this.$message.error(res.message)
          }
          this.addBonusVisible = false
        })
      }
    },
    handleCloseInner () {
      this.innerVisible = false
    },
    submitInnerDialog () {
      if (this.innerData.comment === null || this.innerData.time === null || this.innerData.result === null || this.innerData.comment === '' || this.innerData.time === '' || this.innerData.result === '' || this.innerData.comment === undefined || this.innerData.time === undefined || this.innerData.result === undefined) {
        this.$message.error('请完整填写表单')
      } else {
        console.log(this.innerData)
        let date = this.innerData.time.split(' ')[0]
        console.log(date)
        let time = this.innerData.time.split(' ')[1]
        let s2 = time
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
        let submitTime2 = hour + ':' + mnt + s2.substring(5, 8)
        console.log(submitTime2)
        console.log(submitTime1)
        updatePiece(this.selectedId, parseInt(this.innerData.result), this.innerData.comment, date, submitTime1, submitTime2).then(res => {
          if (res.data === true) {
            this.$message.success(res.message)
            this.innerVisible = false
            this.handleSeeList(0, this.index)
          } else {
            this.$message.error(res.message)
          }
        })
        this.innerData = {
          result: '',
          comment: '',
          time: ''
        }
      }
    },
    handleMod (row, index) {
      this.selectedId = this.listData[index].id
      this.innerVisible = true
    },
    handleAddAdditional () {
      this.addBonusVisible = true
      this.bonusData = {
        count: '',
        reason: ''
      }
    },
    saveConclusion () {
      if (this.preVisitConclusionData.temp === null || this.preVisitConclusionData.temp === '' || this.preVisitConclusionData.temp === '' || this.preVisitConclusionData.conclusion === null || this.preVisitConclusionData.conclusion === '' || this.preVisitConclusionData.conclusion === '' || this.preVisitConclusionData.danger === null || this.preVisitConclusionData.danger === '' || this.preVisitConclusionData.danger === '' || this.preVisitConclusionData.consultationExpectation === null || this.preVisitConclusionData.consultationExpectation === '' || this.preVisitConclusionData.consultationExpectation === '') {
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
        saveConsultConclusion(json).then(res => {
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
      this.$confirm('确认开始咨询?点击确定默认将占用未来8周的同一时间', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.selectedId = this.tableData_Pre[index].cid
        startConsult(this.selectedId).then(res => {
          console.log(this.selectedId)
          if (res.data === true) {
            this.$message.success(res.message)
          } else {
            this.$message.error(res.message)
          }
          this.handleFind()
        })
      })
    },
    handleReport (row, index) {
      this.selectedId = this.tableData_Pre[index].cid
      this.currCID = this.selectedId
      getConsultConclusion(this.selectedId).then(res => {
        this.reportDialogData = {
          totalCount: '',
          name: '',
          stuId: '',
          questionName: '',
          comment: '',
          fromto: '',
          telephone: '',
          facility: '',
          sex: ''
        }
        console.log(res.data)
        this.reportDialogData.sex = res.data.firstVisit.student.sex
        this.reportDialogData.name = res.data.firstVisit.student.name
        this.reportDialogData.stuId = res.data.firstVisit.student.id
        this.reportDialogData.facility = res.data.firstVisit.student.studentInfo.facility
        this.reportDialogData.telephone = res.data.firstVisit.student.studentInfo.telephone
        this.reportDialogData.totalCount = res.data.consultTimes
        let problemText = ''
        switch (res.data.firstVisit.problem) {
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
            switch (res.data.firstVisit.disease) {
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
            switch (res.data.firstVisit.disease) {
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
        this.reportDialogData.questionName = problemText
        this.reportDialogData.fromto = res.data.startDate + '~' + res.data.endDate
        this.reportDialogData.comment = res.data.detail
        if (res.data.state === 4 || res.data.state === 5) {
          this.readOnly = true
        } else {
          this.readOnly = false
        }
      })

      this.reportEnabled = true
    },
    handleSeeListEnd (row, index) {
      this.end = true
      this.index = index
      this.selectedId = this.tableData_Pre[index].cid
      this.currCID = this.selectedId
      getConsultRecordList(this.selectedId).then(res => {
        getApplyResp(this.currCID).then(res => {
          this.response = res.data.isSolved
          this.okay = res.state
        })
        let aaa = []
        let index = 1
        res.data.map(item => {
          console.log(item)
          if (item.isDone === true) {
            let status = ''
            switch (item.result) {
              case 1:
                status = '完成咨询'
                break
              case 2:
                status = '旷约'
                break
              case 3:
                status = '请假'
                break
            }
            let weekdays = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日']
            let time = item.consultDate + ' (' + weekdays[item.weekDay - 1] + ') ' + item.startTime + '~' + item.endTime
            aaa.push({index: index, time: time, status: status, record: item.record, have: true, id: item.id})
          } else {
            aaa.push({index: index, have: false, id: item.id})
          }
          index++
        })
        this.listData = aaa
        this.seeListDialogEnabled = true
      })
    },
    handleSeeList (row, index) {
      this.end = false
      this.index = index
      this.selectedId = this.tableData_Pre[index].cid
      this.currCID = this.selectedId
      getConsultRecordList(this.selectedId).then(res => {
        getApplyResp(this.currCID).then(res => {
          this.response = res.data.isSolved
          this.okay = res.state
        })
        let aaa = []
        let index = 1
        res.data.map(item => {
          console.log(item)
          if (item.isDone === true) {
            let status = ''
            switch (item.result) {
              case 1:
                status = '完成咨询'
                break
              case 2:
                status = '旷约'
                break
              case 3:
                status = '请假'
                break
            }
            let weekdays = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日']
            let time = item.consultDate + ' (' + weekdays[item.weekDay - 1] + ') ' + item.startTime + '~' + item.endTime
            aaa.push({index: index, time: time, status: status, record: item.record, have: true, id: item.id})
          } else {
            aaa.push({index: index, have: false, id: item.id})
          }
          index++
        })
        this.listData = aaa
        this.seeListDialogEnabled = true
      })
    },
    handleCheck (row, index) {
      this.conclusionMode = true
      this.modConclusionMode = false
      this.questionInfo = []
      this.selectedId = this.tableData_Pre[index].cid
      return getConsultConclusion(this.selectedId).then(res => {
        console.log(this.selectedId)
        console.log(res)
        this.preVisitConclusionData.conclusion = res.data.firstVisit.conclusion
        this.preVisitConclusionData.danger = res.data.firstVisit.danger
        this.preVisitConclusionData.temp = []
        this.preVisitConclusionData.temp.push(res.data.firstVisit.problem)
        if (res.data.disease === null) {
        } else {
          this.preVisitConclusionData.temp.push(res.data.firstVisit.disease)
        }
        this.preVisitConclusionData.consultationExpectation = res.data.firstVisit.consultationExpectation
        console.log(this.selectedId)

        this.dialogData_Pre = res.data
        console.log(this.dialogData_Pre)
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
      this.toolBarData_Pre.problem = this.toolBarData_Pre.temp[0]
      this.toolBarData_Pre.disease = this.toolBarData_Pre.temp[1]
      return getMyConsultList(this.myID, this.toolBarData_Pre.theme, this.toolBarData_Pre.danger, this.toolBarData_Pre.problem, this.toolBarData_Pre.disease, this.toolBarData_Pre.parm, this.toolBarData_Pre.facility, this.toolBarData_Pre.conclusion, this.toolBarData_Pre.state).then(res => {
        console.log(this.toolBarData_Pre)
        this.tableData_Pre = res.data
        this.parseData(this.tableData_Pre)
      })
    },
    parseData (data) {
      console.log(data)
      console.log('asf')
      let parsedData = []
      data.map(item => {
        // 处理显示日期
        if (item.date === null) {
          let textDanger = ''
          switch (item.danger) {
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
            problem: problemText,
            score: item.score,
            theme: item.theme,
            sex: item.sex,
            fid: item.fid,
            id: item.id,
            cid: item.cid,
            name: item.name,
            facility: item.facility,
            state: item.state,
            conclusion: item.conclusion,
            date: '',
            telephone: item.telephone,
            teacher: item.teacher,
            danger: textDanger,
            consulttimes: item.consulttimes
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
          switch (item.danger) {
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
            problem: problemText,
            score: item.score,
            themeText: themeText,
            theme: item.theme,
            cid: item.cid,
            sex: item.sex,
            fid: item.fid,
            id: item.id,
            name: item.name,
            facility: item.facility,
            state: item.state,
            conclusion: item.conclusion,
            date: output,
            consulttimes: item.consulttimes,
            telephone: item.telephone,
            danger: textDanger
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
