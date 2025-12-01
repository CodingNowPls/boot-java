<template>
  <div class="app-container">
    <el-form v-show="showSearch" ref="queryForm" :inline="true" :model="queryParams" size="small">
      <el-form-item label="租户名称" prop="tenantName">
        <el-input
          v-model="queryParams.tenantName"
          clearable
          placeholder="请输入租户名称"
          style="width: 240px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="租户编码" prop="tenantCode">
        <el-input
          v-model="queryParams.tenantCode"
          clearable
          placeholder="请输入租户编码"
          style="width: 240px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select
          v-model="queryParams.status"
          clearable
          placeholder="租户状态"
          style="width: 240px"
        >
          <el-option
            v-for="dict in dict.type.sys_normal_disable"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button icon="el-icon-search" size="mini" type="primary" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          v-hasPermi="['system:tenant:add']"
          icon="el-icon-plus"
          plain
          size="mini"
          type="primary"
          @click="handleAdd"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          v-hasPermi="['system:tenant:edit']"
          :disabled="single"
          icon="el-icon-edit"
          plain
          size="mini"
          type="success"
          @click="handleUpdate"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          v-hasPermi="['system:tenant:remove']"
          :disabled="multiple"
          icon="el-icon-delete"
          plain
          size="mini"
          type="danger"
          @click="handleDelete"
        >删除
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="tenantList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="租户名称" prop="tenantName" :show-overflow-tooltip="true" />
      <el-table-column label="租户编码" prop="tenantCode" :show-overflow-tooltip="true" width="150" />
      <el-table-column label="联系人" prop="contactName" width="120" />
      <el-table-column label="联系电话" prop="contactPhone" width="140" />
      <el-table-column label="状态" prop="status" width="100" align="center">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="创建时间" prop="createTime" width="180" align="center">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            v-hasPermi="['system:tenant:edit']"
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
          >修改</el-button>
          <el-button
            v-hasPermi="['system:tenant:remove']"
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :limit.sync="queryParams.pageSize"
      :page.sync="queryParams.pageNum"
      :total="total"
      @pagination="getList"
    />

    <!-- 添加或修改租户对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="租户名称" prop="tenantName">
          <el-input v-model="form.tenantName" placeholder="请输入租户名称" />
        </el-form-item>
        <el-form-item label="租户编码" prop="tenantCode">
          <el-input v-model="form.tenantCode" placeholder="请输入租户编码" :disabled="isEdit" />
        </el-form-item>
        <el-form-item label="联系人" prop="contactName">
          <el-input v-model="form.contactName" placeholder="请输入联系人" />
        </el-form-item>
        <el-form-item label="联系电话" prop="contactPhone">
          <el-input v-model="form.contactPhone" placeholder="请输入联系电话" />
        </el-form-item>
        <el-form-item label="联系邮箱" prop="contactEmail">
          <el-input v-model="form.contactEmail" placeholder="请输入联系邮箱" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in dict.type.sys_normal_disable"
              :key="dict.value"
              :label="dict.value"
            >{{ dict.label }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入备注" />
        </el-form-item>
        <el-form-item label="租户菜单">
          <el-select
            v-model="form.packIds"
            multiple
            clearable
            filterable
            placeholder="请选择租户菜单"
            style="width: 100%;"
            :loading="menuPackLoading"
          >
            <el-option
              v-for="pack in menuPackOptions"
              :key="pack.packId"
              :label="pack.packName"
              :value="pack.packId"
            >
              <div class="pack-option">
                <span class="pack-name">{{ pack.packName }}</span>
                <span class="pack-code" v-if="pack.packCode">({{ pack.packCode }})</span>
              </div>
              <div class="pack-option-desc" v-if="pack.menuNameList && pack.menuNameList.length">
                {{ pack.menuNameList.slice(0,3).join('、') }}
                <span v-if="pack.menuNameList.length > 3">等{{ pack.menuNameList.length }}个菜单</span>
              </div>
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

  </div>
</template>

<script>
import { listTenant, getTenant, addTenant, updateTenant, delTenant } from '@/api/system/tenant'
import { listMenuPackSimple } from '@/api/system/menuPack'

export default {
  name: 'Tenant',
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      tenantList: [],
      title: '',
      open: false,
      isEdit: false,
      ids: [],
      single: true,
      multiple: true,
      platformTenantId: '0',
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        tenantName: undefined,
        tenantCode: undefined,
        status: undefined
      },
      form: {},
      menuPackOptions: [],
      menuPackLoading: false,
      rules: {
        tenantName: [
          { required: true, message: '租户名称不能为空', trigger: 'blur' }
        ],
        tenantCode: [
          { required: true, message: '租户编码不能为空', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listTenant(this.queryParams).then(res => {
        this.tenantList = res.rows
        this.total = res.total
        this.loading = false
      })
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm('queryForm')
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.tenantId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    reset() {
      this.form = {
        tenantName: undefined,
        tenantCode: undefined,
        contactName: undefined,
        contactPhone: undefined,
        contactEmail: undefined,
        status: '0',
        remark: undefined,
        packIds: []
      }
      this.resetForm('form')
    },
    cancel() {
      this.open = false
      this.reset()
    },
    async handleAdd() {
      this.reset()
      this.isEdit = false
      await this.loadMenuPackOptions()
      this.open = true
      this.title = '新增租户'
    },
    async handleUpdate(row) {
      const tenantId = row.tenantId || this.ids[0]
      if (!tenantId) {
        return
      }
      this.reset()
      await this.loadMenuPackOptions()
      getTenant(tenantId).then(res => {
        const data = res.data || {}
        this.form = {
          ...data,
          packIds: data.packIds || []
        }
        this.isEdit = true
        this.open = true
        this.title = '修改租户'
      })
    },
    submitForm() {
      this.$refs['form'].validate(valid => {
        if (!valid) return
        if (this.isEdit) {
          updateTenant(this.form).then(() => {
            this.$modal.msgSuccess('修改成功')
            this.open = false
            this.getList()
          })
        } else {
          addTenant(this.form).then(() => {
            this.$modal.msgSuccess('新增成功')
            this.open = false
            this.getList()
          })
        }
      })
    },
    handleDelete(row) {
      const tenantIds = row.tenantId || this.ids
      this.$modal.confirm('是否确认删除租户"' + tenantIds + '"？').then(() => {
        return delTenant(tenantIds)
      }).then(() => {
        this.$modal.msgSuccess('删除成功')
        this.getList()
      }).catch(() => {})
    },
    async loadMenuPackOptions() {
      this.menuPackLoading = true
      try {
        const res = await listMenuPackSimple({ status: '0' })
        this.menuPackOptions = res.data || []
      } finally {
        this.menuPackLoading = false
      }
    }
  }
}
</script>

<style scoped>
.pack-code {
  color: #909399;
  margin-left: 4px;
}
.pack-option {
  display: flex;
  align-items: center;
}
.pack-option-desc {
  font-size: 12px;
  color: #909399;
}
</style>
