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
            v-hasPermi="['system:tenant:edit']"
            size="mini"
            type="text"
            icon="el-icon-setting"
            @click="handleAssignMenu(scope.row)"
          >菜单</el-button>
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
          <el-input v-model="form.tenantCode" placeholder="请输入租户编码" />
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
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 租户菜单分配对话框 -->
    <el-dialog :title="'租户菜单设置 - ' + (currentTenant.tenantName || '')" :visible.sync="openAssign" width="600px" append-to-body>
      <div v-loading="menuLoading">
        <div class="mb10">
          <el-checkbox v-model="menuExpand" @change="handleMenuTreeExpand">展开/折叠</el-checkbox>
          <el-checkbox v-model="menuNodeAll" @change="handleMenuTreeNodeAll">全选/全不选</el-checkbox>
          <el-checkbox v-model="menuCheckStrictly" @change="handleMenuTreeConnect">父子联动</el-checkbox>
        </div>
        <el-tree
          ref="menuTree"
          :check-strictly="!menuCheckStrictly"
          :data="menuOptions"
          :props="menuTreeProps"
          class="tree-border"
          node-key="id"
          show-checkbox
          empty-text="加载中，请稍候"
        />
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitAssignMenu" :loading="assignLoading">确 定</el-button>
        <el-button @click="openAssign = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listTenant, getTenant, addTenant, updateTenant, delTenant, assignTenantMenus, tenantMenuTreeselect } from '@/api/system/tenant'

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
      openAssign: false,
      ids: [],
      single: true,
      multiple: true,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        tenantName: undefined,
        tenantCode: undefined,
        status: undefined
      },
      form: {},
      currentTenant: {},
      assignForm: {
        tenantId: undefined,
        menuIds: []
      },
      assignLoading: false,
      menuOptions: [],
      menuTreeProps: {
        children: 'children',
        label: 'label'
      },
      menuLoading: false,
      menuExpand: false,
      menuNodeAll: false,
      menuCheckStrictly: true,
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
        remark: undefined
      }
      this.resetForm('form')
    },
    cancel() {
      this.open = false
      this.reset()
    },
    handleAdd() {
      this.reset()
      this.isEdit = false
      this.open = true
      this.title = '新增租户'
    },
    handleUpdate(row) {
      const tenantId = row.tenantId || this.ids[0]
      if (!tenantId) {
        return
      }
      this.reset()
      getTenant(tenantId).then(res => {
        this.form = res.data
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
    async handleAssignMenu(row) {
      const tenantId = row.tenantId
      if (!tenantId) return
      this.currentTenant = row
      this.assignForm = {
        tenantId,
        menuIds: []
      }
      this.menuLoading = true
      try {
        const res = await tenantMenuTreeselect(tenantId)
        this.menuOptions = res.menus || []
        this.assignForm.menuIds = res.checkedKeys || []
        this.openAssign = true
        this.$nextTick(() => {
          if (this.$refs.menuTree) {
            this.$refs.menuTree.setCheckedKeys(this.assignForm.menuIds)
          }
        })
      } finally {
        this.menuLoading = false
      }
    },
    submitAssignMenu() {
      if (!this.assignForm.tenantId) return
      const checkedKeys = this.$refs.menuTree ? this.$refs.menuTree.getCheckedKeys() : []
      const halfCheckedKeys = this.$refs.menuTree ? this.$refs.menuTree.getHalfCheckedKeys() : []
      const menuIds = Array.from(new Set([...(checkedKeys || []), ...(halfCheckedKeys || [])]))
      this.assignLoading = true
      assignTenantMenus({
        tenantId: this.assignForm.tenantId,
        menuIds: menuIds
      }).then(() => {
        this.$modal.msgSuccess('租户菜单设置成功')
        this.openAssign = false
      }).finally(() => {
        this.assignLoading = false
      })
    },
    handleMenuTreeExpand(value) {
      this.menuExpand = value
      if (!this.$refs.menuTree) return
      const treeList = this.menuOptions
      for (let i = 0; i < treeList.length; i++) {
        const node = this.$refs.menuTree.store.nodesMap[treeList[i].id]
        if (node) {
          node.expanded = value
        }
      }
    },
    handleMenuTreeNodeAll(value) {
      this.menuNodeAll = value
      if (!this.$refs.menuTree) return
      this.$refs.menuTree.setCheckedNodes(value ? this.menuOptions : [])
    },
    handleMenuTreeConnect(value) {
      this.menuCheckStrictly = value ? true : false
    }
  }
}
</script>


