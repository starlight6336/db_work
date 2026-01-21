<template>
  <div>
    <div class="tool-bar">
      <el-select v-model="toolBarData_Pre.danger" placeholder="请选择危机等级" size="small" clearable
                 style="margin-right: 10px">
        <el-option
            v-for="item in dangerTemplate"
            :key="item.value"
            :label="item.label"
            :value="item.value">
        </el-option>
      </el-select>
      <el-cascader
          v-model="toolBarData_Pre.temp"
          :options="options"
          clearable
          @change="handleChange"
          placeholder="请选择问题类型"
          size="small"
          style="margin-right: 10px">
      </el-cascader>
      <el-input class="toolbar-input" size="small" placeholder="请输入姓名或学号" v-model="toolBarData_Pre.parm"
                clearable></el-input>
      <el-input class="toolbar-input" size="small" placeholder="请输入咨询师姓名"
                v-model="toolBarData_Pre.teachername" clearable></el-input>
      <el-input class="toolbar-input" size="small" placeholder="请输入学院" v-model="toolBarData_Pre.facility"
                clearable></el-input>
      <el-select v-model="toolBarData_Pre.state" placeholder="咨询状态" size="small" clearable>
        <el-option
            v-for="item in stateTemplate"
            :key="item.value"
            :label="item.label"
            :value="item.value">
        </el-option>
      </el-select>
      <el-button type="primary" size="small" @click="handleFind" class="btn" style="margin-top: 0.5%;margin-bottom: 0.5%">查询</el-button>
      <el-button type="primary" size="small" @click="handleCheckTime" class="btn" style="margin-top: 0.5%;margin-bottom: 0.5%">查看咨询预约时间表</el-button>
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
            prop="id"
            label="学号"
            width="120">
        </el-table-column>
        <el-table-column
            prop="name"
            label="姓名"
            width="80">
        </el-table-column>
        <el-table-column
            prop="sex"
            label="性别"
            width="80">
        </el-table-column>
        <el-table-column
            prop="danger"
            label="危机等级"
            width="100">
          <template slot-scope="scope">
            <span v-if="scope.row.danger === 1">低</span>
            <span v-if="scope.row.danger === 2">中</span>
            <span v-if="scope.row.danger === 3">高</span></template>
        </el-table-column>
        <el-table-column
            prop="problem"
            label="问题类型"
            width="120">
          <template slot-scope="scope">
            <span v-if="scope.row.problem === 1">自我问题</span>
            <span v-if="scope.row.problem === 2">恋爱与性心理</span>
            <span v-if="scope.row.problem === 3">性别认同与同性恋</span>
            <span v-if="scope.row.problem === 4">人际关系问题</span>
            <span v-if="scope.row.problem === 5">学习问题</span>
            <span v-if="scope.row.problem === 6">家庭矛盾问题</span>
            <span v-if="scope.row.problem === 7">新生适应问题</span>
            <span v-if="scope.row.problem === 8">应激反应</span>
            <span v-if="(scope.row.problem === 9) && (scope.row.disease === 1)">疑似-抑郁症</span>
            <span v-if="(scope.row.problem === 9) && (scope.row.disease === 2)">疑似-焦虑症</span>
            <span v-if="(scope.row.problem === 9) && (scope.row.disease === 3)">疑似-双向情感障碍</span>
            <span v-if="(scope.row.problem === 9) && (scope.row.disease === 4)">疑似-精神分裂症</span>
            <span v-if="(scope.row.problem === 9) && (scope.row.disease === 5)">疑似-人格障碍</span>
            <span v-if="(scope.row.problem === 9) && (scope.row.disease === 6)">疑似-强迫症</span>
            <span v-if="(scope.row.problem === 9) && (scope.row.disease === 7)">疑似-恶劣环境</span>
            <span v-if="(scope.row.problem === 9) && (scope.row.disease === 8)">疑似-适应障碍</span>
            <span v-if="(scope.row.problem === 9) && (scope.row.disease === 9)">疑似-进食障碍</span>
            <span v-if="(scope.row.problem === 9) && (scope.row.disease === 10)">疑似-社交恐惧症</span>
            <span v-if="(scope.row.problem === 10) && (scope.row.disease === 1)">确诊-抑郁症</span>
            <span v-if="(scope.row.problem === 10) && (scope.row.disease === 2)">确诊-焦虑症</span>
            <span v-if="(scope.row.problem === 10) && (scope.row.disease === 3)">确诊-双向情感障碍</span>
            <span v-if="(scope.row.problem === 10) && (scope.row.disease === 4)">确诊-精神分裂症</span>
            <span v-if="(scope.row.problem === 10) && (scope.row.disease === 5)">确诊-人格障碍</span>
            <span v-if="(scope.row.problem === 10) && (scope.row.disease === 6)">确诊-强迫症</span>
            <span v-if="(scope.row.problem === 10) && (scope.row.disease === 7)">确诊-恶劣环境</span>
            <span v-if="(scope.row.problem === 10) && (scope.row.disease === 8)">确诊-适应障碍</span>
            <span v-if="(scope.row.problem === 10) && (scope.row.disease === 9)">确诊-进食障碍</span>
            <span v-if="(scope.row.problem === 10) && (scope.row.disease === 10)">确诊-社交恐惧症</span>
            <span v-if="scope.row.problem === 11">其它</span>
          </template>
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
            prop="teacher"
            label="咨询老师"
            width="150">
        </el-table-column>
        <el-table-column
            prop="room"
            label="咨询教室"
            width="100">
        </el-table-column>
        <el-table-column
            prop="state"
            label="咨询状态"
            width="180">
          <template slot-scope="scope">
            <span v-if="scope.row.state === 1">等待安排</span>
            <span v-if="scope.row.state === 2">等待咨询</span>
            <span v-if="scope.row.state === 3">咨询中</span>
            <span v-if="scope.row.state === 4">已结案</span>
            <span v-if="scope.row.state === 5">脱落</span>
          </template>
        </el-table-column>
        <el-table-column
            prop="consulttimes"
            label="当前咨询次数"
            width="120">
        </el-table-column>
        <el-table-column
            width="300"
            label="操作"
        >
          <template slot-scope="scope">
            <el-button type="text" @click="handleCheck(scope.row,scope.$index)" size="mini">查看详情</el-button>
            <el-button type="text" size="mini" @click="getrecordlist(scope.row, scope.$index)"
                       v-if="(scope.row.state === 5 || scope.row.state === 3 || scope.row.state === 4)">查看咨询结果
            </el-button>
            <el-button type="text" size="mini" @click="reportCheck(scope.row, scope.$index)"
                       v-if="(scope.row.state === 5 || scope.row.state === 4)">查看咨询结案报告
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <el-dialog title="查看咨询结果" :visible.sync="consultVisible" width="75%">
      <el-table :data="consultData">
        <el-table-column property="consultTimes" label="咨询次数" width="150">
          <template slot-scope="scope">
            第{{ (scope.$index + 1) }}次
          </template>
        </el-table-column>
        <el-table-column property="time" label="咨询时间" width="300">
          <template slot-scope="scope">
            {{ scope.row.consultDate }} {{ scope.row.startTime }}~{{ scope.row.endTime }}
          </template>
        </el-table-column>
        <el-table-column property="result" label="咨询结果" width="150"></el-table-column>
        <el-table-column property="record" label="咨询记录"></el-table-column>
      </el-table>
    </el-dialog>
    <el-dialog title="查看咨询结案报告" :visible.sync="reportVisible" width="500px">
      <el-form>
        <el-form-item label="来访者学号:">{{ reportData.firstVisit.student.id }}</el-form-item>
        <el-form-item label="来访者姓名:">{{ reportData.firstVisit.student.name }}</el-form-item>
        <el-form-item label="来访者性别:">{{ reportData.firstVisit.student.sex }}</el-form-item>
        <el-form-item label="来访者院系:">{{ reportData.firstVisit.student.studentInfo.facility }}</el-form-item>
        <el-form-item label="来访者电话:">{{ reportData.firstVisit.student.studentInfo.telephone }}</el-form-item>
        <el-form-item label="问题类型:">
          <template>
            <span v-if="reportData.firstVisit.problem === 1">自我问题</span>
            <span v-if="reportData.firstVisit.problem === 2">恋爱与性心理</span>
            <span v-if="reportData.firstVisit.problem === 3">性别认同与同性恋</span>
            <span v-if="reportData.firstVisit.problem === 4">人际关系问题</span>
            <span v-if="reportData.firstVisit.problem === 5">学习问题</span>
            <span v-if="reportData.firstVisit.problem === 6">家庭矛盾问题</span>
            <span v-if="reportData.firstVisit.problem === 7">新生适应问题</span>
            <span v-if="reportData.firstVisit.problem === 8">应激反应</span>
            <span
                v-if="(reportData.firstVisit.problem === 9) && (reportData.firstVisit.disease ===1)">疑似-抑郁症</span>
            <span
                v-if="(reportData.firstVisit.problem === 9) && (reportData.firstVisit.disease ===2)">疑似-焦虑症</span>
            <span
                v-if="(reportData.firstVisit.problem === 9) && (reportData.firstVisit.disease ===3)">疑似-双向情感障碍</span>
            <span
                v-if="(reportData.firstVisit.problem === 9) && (reportData.firstVisit.disease ===4)">疑似-精神分裂</span>
            <span
                v-if="(reportData.firstVisit.problem === 9) && (reportData.firstVisit.disease ===5)">疑似-人格障碍</span>
            <span
                v-if="(reportData.firstVisit.problem === 9) && (reportData.firstVisit.disease ===6)">疑似-强迫症</span>
            <span
                v-if="(reportData.firstVisit.problem === 9) && (reportData.firstVisit.disease ===7)">疑似-恶劣环境</span>
            <span
                v-if="(reportData.firstVisit.problem === 9) && (reportData.firstVisit.disease ===8)">疑似-适应障碍</span>
            <span
                v-if="(reportData.firstVisit.problem === 9) && (reportData.firstVisit.disease ===9)">疑似-进食障碍</span>
            <span
                v-if="(reportData.firstVisit.problem === 9) && (reportData.firstVisit.disease ===10)">疑似-社交恐惧症</span>
            <span
                v-if="(reportData.firstVisit.problem === 10) && (reportData.firstVisit.disease ===1)">确诊-抑郁症</span>
            <span
                v-if="(reportData.firstVisit.problem === 10) && (reportData.firstVisit.disease ===2)">确诊-焦虑症</span>
            <span
                v-if="(reportData.firstVisit.problem === 10) && (reportData.firstVisit.disease ===3)">确诊-双向情感障碍</span>
            <span
                v-if="(reportData.firstVisit.problem === 10) && (reportData.firstVisit.disease ===4)">确诊-精神分裂</span>
            <span
                v-if="(reportData.firstVisit.problem === 10) && (reportData.firstVisit.disease ===5)">确诊-人格障碍</span>
            <span
                v-if="(reportData.firstVisit.problem === 10) && (reportData.firstVisit.disease ===6)">确诊-强迫症</span>
            <span
                v-if="(reportData.firstVisit.problem === 10) && (reportData.firstVisit.disease ===7)">确诊-恶劣环境</span>
            <span
                v-if="(reportData.firstVisit.problem === 10) && (reportData.firstVisit.disease ===8)">确诊-适应障碍</span>
            <span
                v-if="(reportData.firstVisit.problem === 10) && (reportData.firstVisit.disease ===9)">确诊-进食障碍</span>
            <span
                v-if="(reportData.firstVisit.problem === 10) && (reportData.firstVisit.disease ===10)">确诊-社交恐惧症</span>
            <span v-if="reportData.firstVisit.problem === 11">自我问题</span>
          </template>
        </el-form-item>
        <el-form-item label="咨询总次数:">{{ reportData.consultTimes }}</el-form-item>
        <el-form-item label="咨询起止时间:">{{ reportData.startDate }}至{{ reportData.endDate }}</el-form-item>
        <el-form-item label="咨询效果自评:"><br>{{ reportData.detail }}</el-form-item>
      </el-form>
    </el-dialog>
    <el-dialog
        :title="'查看初访详情: '"
        :visible.sync="preCheckDialogEnabled"
        width="80%"
    >
      <el-form label-width="200" label-position="top">
        <el-form-item label="初访预约时间段">
          {{ dialogData_Pre.firstVisit.expectTime1 }}<br>
          {{ dialogData_Pre.firstVisit.expectTime2 }}<br>
          {{ dialogData_Pre.firstVisit.expectTime3 }}
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
    <el-dialog title="预约时间表" :visible.sync="timeVisible"
               width="90%">
      <el-table :data="timeData"
                :span-method="spanMtd"
                border>
        <el-table-column
            label="日期"
            prop="weekday">
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
            prop="name">
          <template slot-scope="scope">{{ scope.row.teacherName }}</template>
        </el-table-column>
        <el-table-column
            label="时段"
            prop="time">
          <template slot-scope="scope">{{ scope.row.startTime + '~' + scope.row.endTime }}</template>
        </el-table-column>
        <el-table-column
            label="占用教室"
            prop="classroom">
          <template slot-scope="scope">{{ scope.row.roomName }}</template>
        </el-table-column>
        <el-table-column
            label="等待释放周数"
            prop="restTimes">
        </el-table-column>
        <el-table-column
            label="状态"
            prop="status">
          <template slot-scope="scope">
            <div :style="{color: scope.row.roomName === null ? 'green' : 'red'}">
              <span v-if="scope.row.roomName === null">{{ '可用' }}</span>
              <span v-else>{{ '占用' }}</span>
            </div>
          </template>
        </el-table-column>
      </el-table>

    </el-dialog>
  </div>
</template>

<script>
import {
  getAllConsultList,
  getConsultList,
  getQuestionPool,
  getConsultDetailByID,
  getConsultRecordList
} from '../../../../api/api'
import {getPreCheckDuration} from '../../../../api/schedule'
import {getTime} from '../../../../api/scheduleManagement'

export default {
  data () {
    return {
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
        }
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
        teacher: '',
        room: '',
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
    getPreCheckDuration().then(res => {
      this.durationPreCheck = res.data
    })
    getAllConsultList().then(res => {
      console.log(res)
      this.tableData_Pre = res.data
      this.parseData(this.tableData_Pre)
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
    handleCheck (row, index) {
      this.questionInfo = []
      this.selectedId = this.tableData_Pre[index].cid
      return getConsultDetailByID(this.selectedId).then(res => {
        this.dialogData_Pre = res.data
        console.log(res)
        console.log(this.dialogData_Pre.firstVisit)
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
      return getConsultList(this.toolBarData_Pre).then(res => {
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
            id: item.id,
            name: item.name,
            facility: item.facility,
            danger: _danger,
            date: '',
            telephone: item.telephone,
            teachername: item.teachername,
            consulttimes: item.consulttimes
          })
        } else {
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
            id: item.id,
            name: item.name,
            facility: item.facility,
            danger: _danger,
            date: output,
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
