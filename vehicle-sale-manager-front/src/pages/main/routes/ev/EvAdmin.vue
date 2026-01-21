<template>
  <div class="ev-admin">
    <el-tabs v-model="activeTab">
      <el-tab-pane label="车型管理" name="vehicle">
        <div class="mb12">
          <el-button type="primary" size="small" @click="openVehicleDialog()">新增车型</el-button>
          <el-button size="small" @click="loadVehicles">刷新</el-button>
          <el-button size="small" @click="loadLowStock">低库存</el-button>
        </div>
        <el-table :data="vehicleList" size="small" border>
          <el-table-column prop="id" label="ID" width="70" />
          <el-table-column prop="brand" label="品牌" width="100" />
          <el-table-column prop="name" label="名称" />
          <el-table-column prop="rangeKm" label="续航" width="90" />
          <el-table-column prop="batteryType" label="电池" width="110" />
          <el-table-column label="指导价">
            <template slot-scope="scope">{{ fmtPrice(scope.row.guidePrice) }}</template>
          </el-table-column>
          <el-table-column prop="stock" label="库存" width="80" />
          <el-table-column label="操作" width="200">
            <template slot-scope="scope">
              <el-button type="text" size="mini" @click="openVehicleDialog(scope.row)">编辑</el-button>
              <el-button type="text" size="mini" @click="restock(scope.row)">补货</el-button>
              <el-popconfirm title="确认删除？" @confirm="removeVehicle(scope.row)">
                <el-button slot="reference" type="text" size="mini">删除</el-button>
              </el-popconfirm>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="促销与金融" name="promotion">
        <div class="mb12">
          <el-form :model="promotionForm" inline size="small" label-width="80px">
            <el-form-item label="车型ID">
              <el-input-number v-model="promotionForm.vehicleId" :min="1" />
            </el-form-item>
            <el-form-item label="标题">
              <el-input v-model="promotionForm.title" placeholder="活动名称" />
            </el-form-item>
            <el-form-item label="类型">
              <el-input v-model="promotionForm.type" placeholder="折扣/赠品" />
            </el-form-item>
            <el-form-item label="折扣(0.9)">
              <el-input-number v-model="promotionForm.discountRate" :min="0" :max="1" :step="0.01" />
            </el-form-item>
            <el-form-item label="赠品">
              <el-input v-model="promotionForm.gift" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="savePromotionForm">保存活动</el-button>
            </el-form-item>
          </el-form>
        </div>

        <div class="mb12">
          <el-form :inline="true" size="small">
            <el-form-item label="活动ID">
              <el-input v-model="promotionStatus.id" style="width: 120px" />
            </el-form-item>
            <el-form-item label="状态">
              <el-select v-model="promotionStatus.status" style="width: 140px">
                <el-option label="上线" value="ONLINE" />
                <el-option label="下架" value="OFFLINE" />
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button @click="changePromotionStatus">更新状态</el-button>
            </el-form-item>
          </el-form>
        </div>

        <el-divider>金融方案</el-divider>
        <el-form :model="planForm" inline size="small" label-width="90px">
          <el-form-item label="车型ID">
            <el-input-number v-model="planForm.vehicleId" :min="1" />
          </el-form-item>
          <el-form-item label="方案名">
            <el-input v-model="planForm.name" />
          </el-form-item>
          <el-form-item label="首付比例">
            <el-input-number v-model="planForm.downPaymentRate" :min="0" :max="1" :step="0.01" />
          </el-form-item>
          <el-form-item label="期数(月)">
            <el-input-number v-model="planForm.months" :min="6" />
          </el-form-item>
          <el-form-item label="年化利率">
            <el-input-number v-model="planForm.annualRate" :min="0" :step="0.001" />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="savePlan">保存方案</el-button>
            <el-button @click="loadPlans">刷新列表</el-button>
          </el-form-item>
        </el-form>
        <el-table :data="plans" size="small" border class="mt8">
          <el-table-column prop="id" label="ID" width="80" />
          <el-table-column prop="vehicleId" label="车型ID" width="90" />
          <el-table-column prop="name" label="方案" />
          <el-table-column prop="downPaymentRate" label="首付比例" width="110" />
          <el-table-column prop="months" label="期数" width="80" />
          <el-table-column prop="annualRate" label="年化利率" width="100" />
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="订单管理" name="order">
        <el-table :data="orderList" size="small" border>
          <el-table-column prop="orderNo" label="订单号" width="140" />
          <el-table-column prop="userId" label="用户" width="80" />
          <el-table-column prop="vehicleId" label="车型ID" width="90" />
          <el-table-column prop="quantity" label="数量" width="70" />
          <el-table-column prop="status" label="状态" width="110" />
          <el-table-column label="金额">
            <template slot-scope="scope">{{ fmtPrice(scope.row.totalAmount) }}</template>
          </el-table-column>
          <el-table-column label="操作" width="180">
            <template slot-scope="scope">
              <el-button v-if="scope.row.status === 'WAIT_PAY'" type="text" size="mini" @click="markPaid(scope.row)">确认支付</el-button>
              <el-button v-if="scope.row.status === 'WAIT_PICKUP' || scope.row.status === 'PAID'" type="text" size="mini" @click="markPickup(scope.row)">标记提车</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="试驾审核" name="testdrive">
        <el-button size="small" class="mb8" @click="loadTestDrives">刷新</el-button>
        <el-table :data="testDriveList" size="small" border>
          <el-table-column prop="id" label="ID" width="70" />
          <el-table-column prop="userId" label="用户" width="80" />
          <el-table-column prop="vehicleId" label="车型ID" width="90" />
          <el-table-column prop="store" label="门店" />
          <el-table-column prop="scheduleTime" label="预约时间" width="160" />
          <el-table-column prop="status" label="状态" width="110" />
          <el-table-column label="操作" width="180">
            <template slot-scope="scope">
              <el-button size="mini" type="text" @click="audit(scope.row, 'APPROVED')">通过</el-button>
              <el-button size="mini" type="text" @click="audit(scope.row, 'REJECTED')">拒绝</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="数据统计" name="stats">
        <el-form :inline="true" size="small" class="mb12">
          <el-form-item label="开始日期">
            <el-date-picker v-model="statRange.start" type="date" placeholder="开始" value-format="yyyy-MM-dd" />
          </el-form-item>
          <el-form-item label="结束日期">
            <el-date-picker v-model="statRange.end" type="date" placeholder="结束" value-format="yyyy-MM-dd" />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="loadStats">统计</el-button>
          </el-form-item>
        </el-form>
        <el-descriptions :column="3" border size="small">
          <el-descriptions-item label="总订单">{{ statsData.totalOrders }}</el-descriptions-item>
          <el-descriptions-item label="销售额">{{ fmtPrice(statsData.totalAmount) }}</el-descriptions-item>
          <el-descriptions-item label="新增用户">{{ statsData.newUsers }}</el-descriptions-item>
        </el-descriptions>
        <el-divider>TOP5 车型</el-divider>
        <el-table v-if="statsData.top5Vehicles" :data="statsData.top5Vehicles" size="small" border>
          <el-table-column label="车型" width="200">
            <template slot-scope="scope">{{ scope.row.vehicle ? scope.row.vehicle.brand + ' ' + scope.row.vehicle.name : '' }}</template>
          </el-table-column>
          <el-table-column prop="qty" label="销量" width="80" />
          <el-table-column prop="amount" label="销售额">
            <template slot-scope="scope">{{ fmtPrice(scope.row.amount) }}</template>
          </el-table-column>
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="用户" name="user">
        <el-button size="small" class="mb8" @click="loadUsers">刷新</el-button>
        <el-table :data="userList" size="small" border>
          <el-table-column prop="id" label="ID" width="80" />
          <el-table-column prop="name" label="姓名" />
          <el-table-column prop="phone" label="手机号" />
          <el-table-column prop="address" label="地址" />
          <el-table-column prop="registerTime" label="注册时间" width="170" />
        </el-table>
      </el-tab-pane>
    </el-tabs>

    <el-dialog :visible.sync="vehicleDialog.visible" :title="vehicleDialog.form.id ? '编辑车型' : '新增车型'" width="640px">
      <el-form :model="vehicleDialog.form" label-width="100px" size="small">
        <el-form-item label="品牌">
          <el-input v-model="vehicleDialog.form.brand" />
        </el-form-item>
        <el-form-item label="名称">
          <el-input v-model="vehicleDialog.form.name" />
        </el-form-item>
        <el-form-item label="指导价(元)">
          <el-input-number v-model="vehicleDialog.form.guidePrice" :min="0" :step="1000" style="width: 200px" />
        </el-form-item>
        <el-form-item label="续航(km)">
          <el-input-number v-model="vehicleDialog.form.rangeKm" :min="0" :step="10" />
        </el-form-item>
        <el-form-item label="电池类型">
          <el-input v-model="vehicleDialog.form.batteryType" />
        </el-form-item>
        <el-form-item label="库存">
          <el-input-number v-model="vehicleDialog.form.stock" :min="0" />
        </el-form-item>
        <el-form-item label="智驾等级">
          <el-input v-model="vehicleDialog.form.smartDriveLevel" />
        </el-form-item>
        <el-form-item label="快充(分钟)">
          <el-input-number v-model="vehicleDialog.form.fastChargeMinutes" :min="0" />
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="vehicleDialog.visible = false">取消</el-button>
        <el-button type="primary" @click="saveVehicle">保存</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import {
  searchVehicles,
  createVehicle,
  updateVehicle,
  deleteVehicle,
  restockVehicle,
  lowStockVehicles,
  savePromotion,
  changePromotionStatus,
  adminOrders,
  markOrderPaid,
  markOrderPickup,
  auditTestDrive,
  stats,
  listUsers,
  saveFinancialPlan,
  listFinancialPlans,
  listTestDrives
} from '@/api/ev'

export default {
  name: 'EvAdmin',
  data () {
    return {
      activeTab: 'vehicle',
      vehicleList: [],
      vehicleDialog: {
        visible: false,
        form: {}
      },
      promotionForm: {
        vehicleId: null,
        title: '',
        type: '',
        discountRate: null,
        gift: ''
      },
      promotionStatus: {
        id: '',
        status: 'ONLINE'
      },
      orderList: [],
      statsData: {},
      statRange: { start: '', end: '' },
      testDriveList: [],
      userList: [],
      planForm: {
        vehicleId: null,
        name: '',
        downPaymentRate: null,
        months: null,
        annualRate: null
      },
      plans: []
    }
  },
  created () {
    this.loadVehicles()
    this.loadOrders()
    this.loadStats()
    this.loadUsers()
    this.loadPlans()
    this.loadTestDrives()
  },
  methods: {
    fmtPrice (val) {
      if (val === null || val === undefined) return '--'
      const num = Number(val) / 10000
      return num.toFixed(2) + ' 万'
    },
    async loadVehicles () {
      const res = await searchVehicles({})
      if (res.status) this.vehicleList = res.data || []
    },
    async loadLowStock () {
      const res = await lowStockVehicles()
      if (res.status) this.vehicleList = res.data || []
    },
    openVehicleDialog (row) {
      this.vehicleDialog.form = row ? { ...row } : { brand: '', name: '', guidePrice: 0, rangeKm: 0, batteryType: '', stock: 0 }
      this.vehicleDialog.visible = true
    },
    async saveVehicle () {
      const data = { ...this.vehicleDialog.form }
      const res = data.id ? await updateVehicle(data.id, data) : await createVehicle(data)
      if (res.status) {
        this.$message.success('保存成功')
        this.vehicleDialog.visible = false
        this.loadVehicles()
      }
    },
    async restock (row) {
      this.$prompt('请输入补货数量', '补货', {
        confirmButtonText: '确定',
        cancelButtonText: '取消'
      }).then(async ({ value }) => {
        const delta = Number(value)
        if (!delta) return
        const res = await restockVehicle(row.id, delta)
        if (res.status) {
          this.$message.success('补货完成')
          this.loadVehicles()
        }
      }).catch(() => {})
    },
    async removeVehicle (row) {
      const res = await deleteVehicle(row.id)
      if (res.status) {
        this.$message.success('删除成功')
        this.loadVehicles()
      }
    },
    async savePromotionForm () {
      const res = await savePromotion(this.promotionForm)
      if (res.status) this.$message.success('已保存活动')
    },
    async changePromotionStatus () {
      if (!this.promotionStatus.id) return
      const res = await changePromotionStatus(this.promotionStatus.id, this.promotionStatus.status)
      if (res.status) this.$message.success('已更新')
    },
    async loadOrders () {
      const res = await adminOrders()
      if (res.status) this.orderList = res.data || []
    },
    async markPaid (row) {
      const res = await markOrderPaid(row.id)
      if (res.status) {
        this.$message.success('已确认支付')
        this.loadOrders()
      }
    },
    async markPickup (row) {
      const res = await markOrderPickup(row.id)
      if (res.status) {
        this.$message.success('已标记提车')
        this.loadOrders()
      }
    },
    async loadStats () {
      const res = await stats(this.statRange.start, this.statRange.end)
      if (res.status) this.statsData = res.data || {}
    },
    async loadTestDrives () {
      const res = await listTestDrives()
      if (res.status) this.testDriveList = res.data || []
    },
    async audit (row, status) {
      const res = await auditTestDrive(row.id, status, '')
      if (res.status) {
        this.$message.success('操作成功')
        this.loadTestDrives()
      }
    },
    async loadUsers () {
      const res = await listUsers()
      if (res.status) this.userList = res.data || []
    },
    async savePlan () {
      const res = await saveFinancialPlan(this.planForm)
      if (res.status) {
        this.$message.success('已保存方案')
        this.loadPlans()
      }
    },
    async loadPlans () {
      const res = await listFinancialPlans()
      if (res.status) this.plans = res.data || []
    }
  }
}
</script>

<style lang="less" scoped>
.ev-admin {
  .mb8 { margin-bottom: 8px; }
  .mb12 { margin-bottom: 12px; }
  .mt8 { margin-top: 8px; }
}
</style>
