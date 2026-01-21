<template>
  <div class="background-div">
    <el-container class="main-div" v-if="tutorialReady">
      <div class="head">
        西安交通大学心理咨询初访预约须知
      </div>
      <br>
      <div class="body" style="float: left">
        亲爱的同学，欢迎进入西安交通大学心理咨询初始访谈预约平台。或许你有着难以化解的困扰，或许你有着难以承受的压力，但是我们欣喜地看到，你已经迈出了积极的一步。求助，永远是身陷困境的人最智慧的决定。
        感谢你的信任，在这里，专业的心理咨询师们将会陪伴你、聆听你、引导你，和你一起踏上一段自我探索的崭新旅程
        为了向你提供更有针对性的帮助，在正式开始心理咨询之前，我们会先为你安排一次面对面初始访谈，以收集个性化问题，了解你的咨询诉求，为你匹配合适的心理服务资源。以下是心理咨询流程图。
      </div>
      <br>
      <img src="../../../../assets/images/decoration.png" style="width: 400px;height: 400px;margin: auto">
      <el-footer class="btn-container">
        <el-button class="start-btn" type="warning" @click="handleStartProcess">继续预约</el-button>
      </el-footer>

    </el-container>
    <el-container class="main-div" v-else>
      <el-header>
        <el-steps :active="progress" :finish-status="progressBarStatus" align-center>
          <el-step title="填写基本个人信息"></el-step>
          <el-step title="完成自我评估量表"></el-step>
          <el-step title="选择我的初访时间"></el-step>
        </el-steps>
      </el-header>
      <el-main v-if="progress===0">
        <el-form :model="basicInfo" :rules="rule1" ref="basicInfo" class="form1" title="基本信息" label-width="150px"
                 :inline="true" label-position="left">
          <el-form-item label="姓名" class="item1" prop="name">
            <el-input v-model="basicInfo.name" autocomplete="off" :disabled="true"></el-input>
          </el-form-item>
          <el-form-item label="学号" class="item1" prop="id">
            <el-input v-model="basicInfo.id" autocomplete="off" :disabled="true"></el-input>
          </el-form-item>
          <el-form-item label="性别" class="item1" prop="sex">
            <el-input v-model="basicInfo.sex" autocomplete="off" :disabled="true"></el-input>
          </el-form-item>
          <el-form-item label="出生年月" class="item1" prop="birth">
            <el-input v-model="basicInfo.birth" autocomplete="off" :disabled="true"></el-input>
          </el-form-item>
          <el-form-item label="入学日期" class="item1" prop="entrance">
            <el-input v-model="basicInfo.entrance" autocomplete="off" :disabled="true"></el-input>
          </el-form-item>
          <el-form-item label="院系" class="item1" prop="facility">
            <el-input v-model="basicInfo.facility" autocomplete="off" :disabled="true"></el-input>
          </el-form-item>
          <el-form-item label="联系电话" class="item1" prop="telephone">
            <el-input v-model="basicInfo.telephone" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="来源" class="item1">
            <el-select class="select" v-model="basicInfo.residence" autocomplete="off">
              <el-option value="1" label="城市" key="1"></el-option>
              <el-option value="2" label="乡镇" key="2"></el-option>
              <el-option value="3" label="农村" key="3"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="学历" class="item1">
            <el-input v-model="basicInfo.degree" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="紧急联系人" class="item1">
            <el-input v-model="basicInfo.emergentContactor" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="紧急联系电话" class="item1" prop="emergentTelephone">
            <el-input v-model="basicInfo.emergentTelephone" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="与本人关系" class="item1">
            <el-input v-model="basicInfo.relationship" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>

      </el-main>
      <el-main v-else-if="progress===1">
        <el-form :inline="true">
          <el-form-item class="questions2" label="您认为您进行心理咨询的紧急程度为:">
            <el-select v-model="questionInfo.selfemergency">
              <el-option value=1 label="一般"></el-option>
              <el-option value=2 label="紧急"></el-option>
              <el-option value=3 label="非常紧急"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item class="questions2" label="您进行心理咨询的主题为:">
            <el-select v-model="questionInfo.theme">
              <el-option v-for="item in stateTemplate"
                         :value="item.value"
                         :label="item.label"
                         :key="item.value"></el-option>
            </el-select>
            <br>
          </el-form-item>
          <el-divider style="font-size: 20px">自我评估量表</el-divider>
          <el-form-item
              class="questions"
              v-for="item in questionPool"
              :key="item.id"
          >
            <a class="front">
              {{ item.id }}、
            </a>
            <a class="mid">
              {{ item.name }}。
            </a>
            <br>
            <div class="radio-box-container">
              <el-radio-group v-model="questionPool[item.id-1].selected">
                <el-radio :label="true">是</el-radio>
                <el-radio :label="false">否</el-radio>
              </el-radio-group>
            </div>

          </el-form-item>
        </el-form>
      </el-main>
      <el-container v-else-if="progress===2">
        <div class="table-1-container">
          选择初访日期
          <el-table :data="availableTimeData" class="select-table" :show-header="false">
            <el-table-column label="日期" prop="dayOfWeek" width="150">
              <template slot-scope="scope">
                <date-container>
                  {{ availableTimeData[scope.$index].date }}
                </date-container>
                <br>
                <day-container>
                  {{ availableTimeData[scope.$index].wkd }}
                </day-container>
              </template>
            </el-table-column>
            <el-table-column label="可用性" prop="status">
              <template slot-scope="scope">
                <el-button class="date-btn" v-if="scope.row.status===3" type="primary"
                           @click="applySelDate(scope.$index)">可预约
                </el-button>
                <el-button class="date-btn" v-else-if="scope.row.status===2" type="warning" :disabled="true">约满
                </el-button>
                <el-button class="date-btn" v-else-if="scope.row.status===1" type="info" plain :disabled="true">
                  不可预约
                </el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>

        <el-divider direction="vertical" style="width: 100%"></el-divider>
        <div class="table-2-container">
          选择初访时间
          <el-table :data="selectedDayTimePeriods" class="select-table" :show-header="false">
            <el-table-column label="日期" prop="dayOfWeek" width="150">
              <template slot-scope="scope">
                <date-container>
                  {{ selectedDayTimePeriods[scope.$index].startTime }}~{{
                    selectedDayTimePeriods[scope.$index].endTime
                  }}
                </date-container>
                <br>
              </template>
            </el-table-column>
            <el-table-column>
              <template slot-scope="scope">
                匹配人数:{{ selectedDayTimePeriods[scope.$index].matched }}<br>
                排队人数:{{ selectedDayTimePeriods[scope.$index].waiting }}
              </template>

            </el-table-column>
            <el-table-column label="可用性" prop="status">
              <template slot-scope="scope">
                <el-button class="date-btn" v-if="scope.row.state" type="primary" @click="addTag(scope.row)">预约
                </el-button>
                <el-button class="date-btn" v-else type="info">已被预约</el-button>
              </template>
            </el-table-column>
          </el-table>
        </div>
        <el-divider direction="vertical" style="width: 100%"></el-divider>
        <div class="table-2-container">
          已选初访时间<br>
          <br>
          <div class="tag-container" type="primary">
            <br>
            <div v-for="tag in tagPool"
                 :key="tag"
            >
              <el-tag
                  class="tag"
                  :key="tag.tagName"
                  type="success"
              >{{ tag.tagName }}
              </el-tag>
              <br>
            </div>

          </div>
          <el-button class="del-btn" type="danger" icon="el-icon-minus" @click="closeTagByName" :plain="false"
                     size="mini"></el-button>
        </div>
      </el-container>
      <el-footer class="btn-container">
        <el-button class="btn" @click="saveDraft">覆盖草稿</el-button>
        <el-button class="btn" type="info" @click="prevStep(-1)">上一步</el-button>
        <el-button v-if="progress!==2" class="btn" type="primary" @click="nextStep(1)">下一步</el-button>
        <el-button v-else-if="progress===2" class="btn" type="success"
                   @click="____ARE___YoU__SURE__TO___SUBMIT___THiS_FORM__">提交
        </el-button>
      </el-footer>
    </el-container>

  </div>
</template>

<script>
import {_getLocalStorage} from '../../../../tools/utils'
import {
  getAvailableTimePeriods,
  getReservationInfoByFID,
  saveDraft,
  submit
} from '../../../../api/student'
import {getQuestionPool} from '../../../../api/api'

export default {
  data () {
    return {
      tutorialReady: true,
      progress: 0,
      availableTimeData: [],
      progressBarStatus: 'success',
      id: this.getId(),
      fid2: '',
      stuID: '',
      questionPool: [],
      basicInfo: {
        name: '',
        sex: '',
        birth: '',
        id: '',
        loginName: '',
        residence: '',
        residenceNum: '',
        facility: '',
        telephone: '',
        degree: '',
        fid: '',
        entrance: '',
        emergentContactor: '',
        emergentTelephone: '',
        relationship: '',
        email: '',
        questions: [],
        theme: '',
        expectTime1: '',
        expectTime2: '',
        expectTime3: ''
      },
      tagPool: [],
      selectedDate: '',
      questionInfo: {
        selfemergency: '',
        theme: '',
        selectedQuestions: []
      },
      availableTimePeriods: [],
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
      rule1: {
        name: [
          {required: true, message: '带*号的内容不得为空', trigger: 'blur'}
        ],
        sex: [
          {required: true, message: '带*号的内容不得为空', trigger: 'blur'}
        ],
        id: [
          {required: true, message: '带*号的内容不得为空', trigger: 'blur'}
        ],
        birth: [
          {required: true, message: '带*号的内容不得为空', trigger: 'blur'}
        ],
        entrance: [
          {required: true, message: '带*号的内容不得为空', trigger: 'blur'}
        ],
        facility: [
          {required: true, message: '带*号的内容不得为空', trigger: 'blur'}
        ],
        telephone: [
          {
            required: true,
            message: '带*号的内容不得为空',
            trigger: 'blur'
          },
          {
            min: 11,
            max: 11,
            message: '电话号码格式不正确',
            trigger: 'blur'
          }
        ],
        emergentTelephone: [
          {
            required: true,
            message: '带*号的内容不得为空',
            trigger: 'blur'
          },
          {
            min: 11,
            max: 11,
            message: '电话号码格式不正确',
            trigger: 'blur'
          }
        ]
      },
      selectedDayTimePeriods: []
    }
  },
  props: {
    fid_parent: {
      type: Object
    },
    editDraftMode: {
      type: Object
    }
  },
  methods: {
    init () {
      this.getId()
      this.fid2 = this.fid_parent
      console.log(this.fid2)
      this.tagPool = []
      getQuestionPool().then(res => {
        let questions = []
        res.data.map(item => {
          questions.push({id: item.id, name: item.name, selected: null})
        })
        this.questionPool = questions
        console.log(this.questionPool)
      })
      getReservationInfoByFID(this.id, this.fid2).then(res => {
        console.log(res)
        if (res.status === true) {
          this.basicInfo.id = res.data.id
          this.basicInfo.fid = res.data.fid
          this.basicInfo.name = res.data.name
          this.basicInfo.sex = res.data.sex
          this.basicInfo.birth = res.data.birth
          this.basicInfo.questions = res.data.questions
          this.basicInfo.loginName = res.data.loginName
          this.basicInfo.name = res.data.name
          if (res.data.studentInfo != null) {
            this.basicInfo.entrance = res.data.studentInfo.entrance
            this.basicInfo.facility = res.data.studentInfo.facility
            this.basicInfo.telephone = res.data.studentInfo.telephone
            this.basicInfo.residenceNum = res.data.studentInfo.residence
            let text = ''
            switch (res.data.studentInfo.residence) {
              default:
                text = ''
                break
              case 1:
                text = '城市'
                break
              case 2:
                text = '乡镇'
                break
              case 3:
                text = '农村'
                break
            }
            this.basicInfo.residence = text
            this.basicInfo.emergentTelephone = res.data.studentInfo.emergentTelephone
            this.basicInfo.emergentContactor = res.data.studentInfo.emergentContactor
            this.basicInfo.relationship = res.data.studentInfo.relationship
            this.basicInfo.degree = res.data.studentInfo.degree
            this.stuID = res.data.studentInfo.id
          }
        }
        if (res.data.selfemergency <= 3 && res.data.selfemergency >= 1) {
          this.questionInfo.selfemergency = res.data.selfemergency
        } else {
          this.questionInfo.selfemergency = ''
        }
        console.log(res.data.theme)
        if (res.data.theme <= 11 && res.data.theme >= 1) {
          this.questionInfo.theme = res.data.theme
        } else {
          this.questionInfo.theme = ''
        }
        res.data.questions.map(item => {
          this.questionPool[item.id - 1].selected = true
        })
      })
      this.loadAvailableTime()
    },

    addTag (row) {
      if (this.tagPool.length >= 3) {
        this.$message.info('预约时间不超过3个')
      } else {
        if (this.tagPool.indexOf(this.selectedDate + ' ' + row.startTime + '~' + row.endTime) > -1) {
          this.$message.info('该时间已经在列表内')
        } else {
          this.tagPool.push({tagName: this.selectedDate + ' ' + row.startTime + '~' + row.endTime})
        }
      }
    },

    closeTagByName () {
      this.tagPool.splice(this.tagPool.length - 1, 1)
    },

    applySelDate (index) {
      this.selectedDayTimePeriods = []
      this.selectedDayTimePeriods = this.availableTimeData[index].periods
      this.selectedDate = this.availableTimeData[index].date
    },

    saveDraft () {
      let selectedQuestions = []
      for (let i in this.questionPool) {
        if (this.questionPool[i].selected === true) {
          selectedQuestions.push({id: this.questionPool[i].id + 1})
        }
      }
      let expectTime1 = null
      let expectTime2 = null
      let expectTime3 = null
      if (this.tagPool.length === 1) {
        expectTime1 = this.tagPool[0].tagName
      } else if (this.tagPool.length === 2) {
        expectTime1 = this.tagPool[0].tagName
        expectTime2 = this.tagPool[1].tagName
      } else if (this.tagPool.length === 3) {
        expectTime1 = this.tagPool[0].tagName
        expectTime2 = this.tagPool[1].tagName
        expectTime3 = this.tagPool[2].tagName
      }
      let json = {
        theme: this.questionInfo.theme,
        fid: this.fid2,
        id: this.basicInfo.id,
        loginName: this.basicInfo.loginName,
        name: this.basicInfo.name,
        sex: this.basicInfo.sex,
        birth: this.basicInfo.birth,
        selfEmergency: parseInt(this.questionInfo.selfemergency),
        expectTime1: expectTime1,
        expectTime2: expectTime2,
        expectTime3: expectTime3,
        studentInfo: {
          id: this.stuID,
          telephone: this.basicInfo.telephone,
          residence: this.basicInfo.residenceNum,
          degree: this.basicInfo.degree,
          emergentContactor: this.basicInfo.emergentContactor,
          relationship: this.basicInfo.relationship,
          emergentTelephone: this.basicInfo.emergentTelephone
        },
        questions: selectedQuestions
      }
      saveDraft(json).then(res => {
        if (res.status === true) {
          this.$message.success(res.message)
          this.$router.replace('appointment')
          this.editDraftMode = false
        } else {
          this.$message.error(res.message)
        }
      })
    },

    loadAvailableTime () {
      getAvailableTimePeriods().then(res => {
        this.availableTimeData = []
        let weekdays = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日']
        res.data.map(item => {
          let wkd = weekdays[item.dayOfWeek - 1]
          let date = item.reserveDate
          this.availableTimeData.push({date: date, wkd: wkd, status: item.state, periods: item.periods})
        })
      })
    },

    ____ARE___YoU__SURE__TO___SUBMIT___THiS_FORM__ () {
      let text = ''
      let expectTime1 = null
      let expectTime2 = null
      let expectTime3 = null
      if (this.tagPool.length === 1) {
        expectTime1 = this.tagPool[0].tagName
        text = expectTime1
      } else if (this.tagPool.length === 2) {
        expectTime1 = this.tagPool[0].tagName
        expectTime2 = this.tagPool[1].tagName
        text = expectTime1 + '、' + expectTime2
      } else if (this.tagPool.length === 3) {
        expectTime1 = this.tagPool[0].tagName
        expectTime2 = this.tagPool[1].tagName
        expectTime3 = this.tagPool[2].tagName
        text = expectTime1 + '、' + expectTime2 + '、' + expectTime3
      }
      this.$confirm('你选择的初访日期是' + text + '，是否确认提交?', '预约提交确认', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.submit()
      })
    },

    submit () {
      let selectedQuestions = []
      for (let i in this.questionPool) {
        if (this.questionPool[i].selected === true) {
          selectedQuestions.push({id: this.questionPool[i].id + 1})
        }
      }
      let expectTime1 = null
      let expectTime2 = null
      let expectTime3 = null
      if (this.tagPool.length === 1) {
        expectTime1 = this.tagPool[0].tagName
      } else if (this.tagPool.length === 2) {
        expectTime1 = this.tagPool[0].tagName
        expectTime2 = this.tagPool[1].tagName
      } else if (this.tagPool.length === 3) {
        expectTime1 = this.tagPool[0].tagName
        expectTime2 = this.tagPool[1].tagName
        expectTime3 = this.tagPool[2].tagName
      }
      let json = {
        id: this.basicInfo.id,
        loginName: this.basicInfo.loginName,
        name: this.basicInfo.name,
        sex: this.basicInfo.sex,
        birth: this.basicInfo.birth,
        selfEmergency: parseInt(this.questionInfo.selfemergency),
        expectTime1: expectTime1,
        expectTime2: expectTime2,
        expectTime3: expectTime3,
        theme: this.basicInfo.theme,
        studentInfo: {
          telephone: this.basicInfo.telephone,
          residence: this.basicInfo.residenceNum,
          degree: this.basicInfo.degree,
          emergentContactor: this.basicInfo.emergentContactor,
          relationship: this.basicInfo.relationship,
          emergentTelephone: this.basicInfo.emergentTelephone
        },
        questions: selectedQuestions
      }
      submit(json).then(res => {
        console.log(json)
        if (res.status === true) {
          this.$message.success('预约已提交')
          this.$router.replace('list')
        }
      })
    },

    nextStep (step) {
      if (this.progress === 0) {
        this.$refs['basicInfo'].validate((valid) => {
          if (valid) {
            this.progress += step
          } else {
            this.$message.error('表单填写有误')
          }
        })
      } else if (this.progress === 1) {
        if (this.questionInfo.selfemergency === null || this.questionInfo.selfemergency === '' || this.questionInfo.selfemergency === undefined) {
          this.$message.error('请选择紧急程度')
          return
        }
        if (this.questionInfo.theme === null || this.questionInfo.theme === '' || this.questionInfo.theme === undefined) {
          this.$message.error('请选择咨询主题')
          return
        }
        this.questionInfo.selectedQuestions = []
        for (let i in this.questionPool) {
          if (this.questionPool[i].selected === null) {
            this.$message.error('请完整填写自我评估量表')
            return
          }
          if (this.questionPool[i].selected === true) {
            this.questionInfo.selectedQuestions.push({id: this.questionPool[i].id + 1})
          }
        }
        this.loadAvailableTime()
        this.progress += step
      }
    },

    prevStep (step) {
      this.progress += step
      if (this.progress < 0) this.progress -= step
    },

    getId () {
      this.id = _getLocalStorage('id')
      return _getLocalStorage('id')
    },

    handleStartProcess () {
      this.init()
      this.tutorialReady = false
    }
  }
}
</script>

<style scoped>
.background-div {
  background-color: ghostwhite;
  height: 95%;
  width: 100%;
}

.main-div {
  margin: 1% 1% 0px;
  padding: 0.5%;
  box-shadow: 0px 0px 2px 2px rgba(0, 0, 0, 0.1);
  background-color: white;
  height: 100%;
}

.head {
  text-align: center;
  font-size: 20px;
  font-weight: bolder;
  margin: auto;
  margin-top: 2%
}

.select {
  width: 94%;
}

.body {
  width: 80%;
  text-align: center;
  margin: auto;
  margin-top: 0%;
}

.start-btn {
  width: 30%;
  margin-right: 35%;
}

.btn-container {
  width: 100%;
  margin: auto;
  float: bottom;
  text-align: end;
}

.progress-bar-container {
  margin: auto;
  width: 25%;
}

.img-container {
  margin: auto;
}

.item1 {
  width: 45%;
}

.form1 {
  margin-left: 15%;
  margin-top: 2%;
}

.questions {
  margin-left: 10%;
  width: 75%;
}

.questions2 {
  margin-left: 10%;
}

.front {
}

.mid {
}

.radio-box-container {
  margin-left: 15%;
}

.select-table {
  width: 100%;
}

date-container {
  font-weight: bolder;
}

.date-btn {
  width: 100%;
  height: 100%;
}

.table-1-container {
  width: 25%;
  margin-left: 2%;
}

.table-2-container {
  margin-bottom: auto;
  height: 100%;
  width: 30%;
}

.tag {
  margin-top: 2px;
  margin-left: 20px;
  margin-right: 20px;
}

.tag-container {
  width: 60%;
  height: 28%;
  cursor: auto;
  border: none;
  background-color: #e6fde6;
}

.del-btn {
  margin-left: 25%;
  margin-top: 5%
}
</style>
