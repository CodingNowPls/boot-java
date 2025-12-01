<template>
  <div class="app-container">
    <el-form v-show="showSearch" ref="queryForm" :inline="true" :model="queryParams" size="small">
      <el-form-item label="租户菜单名称" prop="packName">
        <el-input
          v-model="queryParams.packName"
          clearable
          placeholder="请输入租户菜单名称"
          style="width: 240px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" clearable placeholder="状态" style="width: 240px">
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
          v-hasPermi="['system:menuPack:add']"
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
          v-hasPermi="['system:menuPack:edit']"
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
          v-hasPermi="['system:menuPack:remove']"
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

    <el-table v-loading="loading" :data="packList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="租户菜单名称" prop="packName" :show-overflow-tooltip="true" />
      <el-table-column label="租户菜单编码" prop="packCode" :show-overflow-tooltip="true" width="160" />
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
            v-hasPermi="['system:menuPack:edit']"
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
          >修改</el-button>
          <el-button
            v-hasPermi="['system:menuPack:edit']"
            size="mini"
            type="text"
            icon="el-icon-setting"
            @click="handleAssignMenus(scope.row)"
          >分配菜单</el-button>
          <el-button
            v-hasPermi="['system:menuPack:remove']"
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

    <!-- 添加或修改租户菜单对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="110px">
        <el-form-item label="租户菜单名称" prop="packName">
          <el-input v-model="form.packName" placeholder="请输入租户菜单名称" />
        </el-form-item>
        <el-form-item label="租户菜单编码" prop="packCode">
          <el-input v-model="form.packCode" placeholder="请输入租户菜单编码" />
        </el-form-item>
        <el-form-item label="菜单权限">
          <div class="menu-toolbar">
            <el-checkbox v-model="menuExpand" @change="handleCheckedTreeExpand($event)">
              展开/折叠
            </el-checkbox>
            <el-checkbox v-model="menuNodeAll" @change="handleCheckedTreeNodeAll($event)">
              全选/全不选
            </el-checkbox>
            <el-checkbox v-model="menuCheckStrictly" @change="handleCheckedTreeConnect($event)">
              父子联动
            </el-checkbox>
          </div>
          <el-tree
            ref="menuTree"
            :check-strictly="!menuCheckStrictly"
            :data="menuTree"
            :props="defaultProps"
            class="tree-border"
            empty-text="加载中，请稍候"
            node-key="menuId"
            show-checkbox
          />
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

    <!-- 分配菜单对话框 -->
    <el-dialog :title="'分配菜单 - ' + (form.packName || '')" :visible.sync="openAssign" width="600px" append-to-body>
      <div class="menu-toolbar">
        <el-checkbox v-model="assignExpand" @change="handleAssignTreeExpand">
          展开/折叠
        </el-checkbox>
        <el-checkbox v-model="assignNodeAll" @change="handleAssignTreeNodeAll">
          全选/全不选
        </el-checkbox>
        <el-checkbox v-model="assignCheckStrictly" @change="handleAssignTreeConnect">
          父子联动
        </el-checkbox>
      </div>
      <el-tree
        ref="menuTreeAssign"
        :check-strictly="!assignCheckStrictly"
        :data="menuTree"
        :props="defaultProps"
        class="tree-border"
        node-key="menuId"
        show-checkbox
      />
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitAssignMenus">确 定</el-button>
        <el-button @click="openAssign = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMenuPack, getMenuPack, addMenuPack, updateMenuPack, delMenuPack, assignMenusToPack } from '@/api/system/menuPack'
import { listMenu } from '@/api/system/menu'

export default {
  name: 'MenuPack',
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      packList: [],
      title: '',
      open: false,
      openAssign: false,
      ids: [],
      single: true,
      multiple: true,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        packName: undefined,
        status: undefined
      },
      form: {},
      rules: {
        packName: [{ required: true, message: '租户菜单名称不能为空', trigger: 'blur' }]
      },
      menuTree: [],
      menuExpand: false,
      menuNodeAll: false,
      menuCheckStrictly: true,
      assignExpand: false,
      assignNodeAll: false,
      assignCheckStrictly: true,
      defaultProps: {
        children: 'children',
        label: 'menuName'
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listMenuPack(this.queryParams).then(res => {
        this.packList = res.rows
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
      this.ids = selection.map(item => item.packId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    reset() {
      this.form = {
        packId: undefined,
        packName: undefined,
        packCode: undefined,
        status: '0',
        remark: undefined
      }
      this.menuTree = []
      this.menuExpand = false
      this.menuNodeAll = false
      this.menuCheckStrictly = true
      this.resetForm('form')
    },
    cancel() {
      this.open = false
      this.reset()
    },
    handleAdd() {
      this.reset()
      // 预先加载菜单树（只加载业务菜单）
      listMenu({ status: '0', isSys: '0' }).then(res => {
        this.menuTree = this.handleTree(res.data, 'menuId')
      })
      this.open = true
      this.title = '新增租户菜单'
    },
    handleUpdate(row) {
      const packId = row.packId || this.ids[0]
      if (!packId) return
      this.reset()
      // 加载菜单树 + 已勾选菜单
      Promise.all([
        listMenu({ status: '0', isSys: '0' }),
        getMenuPack(packId)
      ]).then(([resMenu, resPack]) => {
        this.menuTree = this.handleTree(resMenu.data, 'menuId')
        this.form = resPack.data
        const checked = resPack.menuIds || []
        this.open = true
        this.title = '修改租户菜单'
        this.$nextTick(() => {
          if (this.$refs.menuTree) {
            this.$refs.menuTree.setCheckedKeys(checked)
          }
        })
      })
    },
    submitForm() {
      this.$refs['form'].validate(valid => {
        if (!valid) return
        const checkedKeys = this.getTreeAllCheckedKeys('menuTree')
        const payload = {
          ...this.form
        }
        const action = this.form.packId ? updateMenuPack : addMenuPack
        action(payload).then(() => {
          const msg = this.form.packId ? '修改成功' : '新增成功'
          // 保存基础信息成功后，保存菜单明细（覆盖式）
          const doAssign = (packId) => {
            return assignMenusToPack({ packId, menuIds: checkedKeys })
          }
          let packId = this.form.packId
          if (packId) {
            doAssign(packId).then(() => {
              this.$modal.msgSuccess(msg)
              this.open = false
              this.getList()
            })
          } else {
            // 新增时需要从返回中获取 packId
            // 后端 save(pack) 返回受影响行数；这里简单做一次刷新列表后取最后一条的 packId
            this.getList()
            setTimeout(() => {
              const last = this.packList && this.packList.length ? this.packList[0] : null
              if (last && last.packId) {
                doAssign(last.packId).then(() => {
                  this.$modal.msgSuccess(msg)
                  this.open = false
                  this.getList()
                })
              } else {
                this.$modal.msgSuccess(msg + '（菜单分配请在“分配菜单”中补充）')
                this.open = false
              }
            }, 500)
          }
        })
      })
    },
    handleCheckedTreeExpand(value) {
      const tree = this.$refs.menuTree
      if (!tree || !tree.store) return
      const nodesMap = tree.store.nodesMap || {}
      Object.keys(nodesMap).forEach(key => {
        nodesMap[key].expanded = value
      })
    },
    handleCheckedTreeNodeAll(value) {
      const tree = this.$refs.menuTree
      if (!tree) return
      tree.setCheckedNodes(value ? this.menuTree : [])
    },
    handleCheckedTreeConnect(value) {
      this.menuCheckStrictly = value ? true : false
    },
    handleAssignTreeExpand(value) {
      const tree = this.$refs.menuTreeAssign
      if (!tree || !tree.store) return
      const nodesMap = tree.store.nodesMap || {}
      Object.keys(nodesMap).forEach(key => {
        nodesMap[key].expanded = value
      })
    },
    handleAssignTreeNodeAll(value) {
      const tree = this.$refs.menuTreeAssign
      if (!tree) return
      tree.setCheckedNodes(value ? this.menuTree : [])
    },
    handleAssignTreeConnect(value) {
      this.assignCheckStrictly = value ? true : false
    },
    handleDelete(row) {
      const packIds = row.packId || this.ids
      this.$modal.confirm('是否确认删除租户菜单"' + packIds + '"？').then(() => {
        return delMenuPack(packIds)
      }).then(() => {
        this.$modal.msgSuccess('删除成功')
        this.getList()
      }).catch(() => {})
    },
    async handleAssignMenus(row) {
      const packId = row.packId
      if (!packId) return
      this.form = row
      this.assignExpand = false
      this.assignNodeAll = false
      this.assignCheckStrictly = true
      // 加载菜单树
      const resMenu = await listMenu({ status: '0', isSys: '0' })
      this.menuTree = this.handleTree(resMenu.data, 'menuId')
      // 加载已勾选菜单
      const resPack = await getMenuPack(packId)
      const checked = resPack.menuIds || []
      this.$nextTick(() => {
        if (this.$refs.menuTreeAssign) {
          this.$refs.menuTreeAssign.setCheckedKeys(checked)
        }
      })
      this.openAssign = true
    },
    submitAssignMenus() {
      if (!this.form.packId) return
      const checkedKeys = this.getTreeAllCheckedKeys('menuTreeAssign')
      assignMenusToPack({ packId: this.form.packId, menuIds: checkedKeys }).then(() => {
        this.$modal.msgSuccess('分配成功')
        this.openAssign = false
      })
    },
    getTreeAllCheckedKeys(refName) {
      const treeRef = this.$refs[refName]
      if (!treeRef) return []
      const checkedKeys = treeRef.getCheckedKeys ? treeRef.getCheckedKeys() : []
      const halfCheckedKeys = treeRef.getHalfCheckedKeys ? treeRef.getHalfCheckedKeys() : []
      return Array.from(new Set([...(checkedKeys || []), ...(halfCheckedKeys || [])]))
    }
  }
}
</script>

<style scoped>
.menu-toolbar {
  margin-bottom: 10px;
  display: flex;
  gap: 20px;
}
.mr5 {
  margin-right: 5px;
}
.mb5 {
  margin-bottom: 5px;
}
</style>
