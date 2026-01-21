<template>
    <div class="background-div">
        <el-main class="main-div">
            <div class="table-div">
                <el-table
                        :data="tableData"
                        style="width: 98%;height: 100%"
                border>
                    <el-table-column label="咨询师照片" width="150">
                        <template slot-scope="scope">
                            <div class="block" :key="fit">
                                <el-image
                                        style="width: 100px; height: 100px"
                                        :src="scope.row.avatar"
                                        :fit="fill"></el-image>
                            </div>
                            <!--<img :src="scope.row.avatar" alt="">-->
                        </template>
                    </el-table-column>
                    <el-table-column label="姓名" prop="name" width="100"></el-table-column>
                    <el-table-column label="性别" prop="sex" width="100"></el-table-column>
                    <el-table-column label="个人简介" prop="teacherInfo.detail"></el-table-column>
                </el-table>
            </div>
        </el-main>
    </div>
</template>

<script>

import {getTeacher} from '../../../../api/student'

export default {
  data () {
    return {
      url: 'https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg',
      image: '',
      tableData: []
    }
  },
  mounted () {
    // this.getImage()
  },
  created () {
    getTeacher().then(res => {
      console.log(res)
      this.tableData = res.data
      this.tableData.forEach(x => x.avatar = x.teacherInfo.avatar)
      console.log(this.tableData)
      // this.tableData.map(item => {
      //   item.avatar = item.teacherInfo.avatar.substring(1)
      //   temp.push({avatar: item.teacherInfo.avatar.substring(1)})
      // })
      // this.aaaa = temp
      // console.log(this.tableData)
    })
  },

  methods: {
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
