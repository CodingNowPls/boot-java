<template>
  <div class="login">
    <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
      <h3 class="title">后台管理系统</h3>
      <el-form-item prop="userName">
        <el-input
          v-model="loginForm.userName"
          type="text"
          auto-complete="off"
          placeholder="账号"
        >
          <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="loginForm.password"
          type="password"
          auto-complete="off"
          placeholder="密码"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item prop="code" v-if="captchaEnabled">
        <el-input
          v-model="loginForm.code"
          auto-complete="off"
          placeholder="验证码"
          style="width: 63%"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
        </el-input>
        <div class="login-code">
          <img :src="codeUrl" @click="getCode" class="login-code-img"/>
        </div>
      </el-form-item>
      <el-checkbox v-model="loginForm.rememberMe" style="margin:0px 0px 25px 0px;">记住密码</el-checkbox>
      <el-form-item style="width:100%;">
        <el-button
          :loading="loading"
          size="medium"
          type="primary"
          style="width:100%;"
          @click.native.prevent="handleLogin"
        >
          <span v-if="!loading">登 录</span>
          <span v-else>登 录 中...</span>
        </el-button>
        <div style="float: right;" v-if="register">
          <router-link class="link-type" :to="'/register'">立即注册</router-link>
        </div>
      </el-form-item>
    </el-form>
    <!--  底部  -->
    <div class="el-login-footer">
      <span>Copyright © 2018-2023 boot ui Technology Co., Ltd. </span>
    </div>
  </div>
</template>

<script>
import { getCodeImg, getLoginConfig, getTenantList } from "@/api/login";
import Cookies from "js-cookie";
import { encrypt, decrypt } from '@/utils/jsencrypt'
import { getConfig } from '@/api/system/config'

export default {
  name: "Login",
  data() {
    return {
      codeUrl: "",
      registerConfigId: 5,
      loginForm: {
        userName: "",
        password: "",
        rememberMe: false,
        code: "",
        uuid: "",
        // 多租户相关
        tenantId: "",
        isAdminLogin: false
      },
      loginRules: {
        userName: [
          { required: true, trigger: "blur", message: "请输入您的账号" }
        ],
        password: [
          { required: true, trigger: "blur", message: "请输入您的密码" }
        ],
        code: [{ required: true, trigger: "change", message: "请输入验证码" }]
      },
      loading: false,
      // 验证码开关
      captchaEnabled: true,
      // 注册开关
      register: false,
      redirect: undefined,
      // 登录配置（租户模式）
      loginConfig: {
        showTenantSelect: false,
        tenantMode: 'auto',     // auto/single/multi
        defaultTenantId: '0',   // 默认/平台租户ID（字符串）
        platformTenantId: '0',
        tenantCount: 0,
        tenantList: []
      },
      tenantList: [],
      showTenantSelect: false
    };
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect;
      },
      immediate: true
    }
  },
  created() {
    this.getConfig();
    this.getCode();
    this.getCookie();
    this.loadLoginConfig();
  },
  methods: {
    getConfig() {
      getConfig(this.registerConfigId).then(res => {
        this.register = res.data.configValue == 'true' ? true : false;
      })
    },
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
        if (this.captchaEnabled) {
          //this.codeUrl = "data:image/gif;base64," + res.img;
          this.codeUrl = res.img;
          this.loginForm.uuid = res.uuid;
        }
      });
    },
    getCookie() {
      const userName = Cookies.get("userName");
      const password = Cookies.get("password");
      const rememberMe = Cookies.get('rememberMe')
      this.loginForm = Object.assign({}, this.loginForm, {
        userName: userName === undefined ? this.loginForm.userName : userName,
        password: password === undefined ? this.loginForm.password : decrypt(password),
        rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
      });
    },
    async loadLoginConfig() {
      try {
        const res = await getLoginConfig();
        this.loginConfig = res.data || this.loginConfig;
        // 自动判断租户模式
        if (this.loginConfig.tenantMode === 'auto') {
          this.loginConfig.tenantMode = this.loginConfig.tenantCount > 1 ? 'multi' : 'single';
        }
        // 管理后台登录不展示租户下拉
        if (this.loginForm.isAdminLogin) {
          this.showTenantSelect = false;
          return;
        }
        if (this.loginConfig.tenantMode === 'multi') {
          // 多租户模式：必须显示租户选择
          this.showTenantSelect = true;
          if (this.loginForm.userName) {
            await this.loadTenantList();
          }
        } else {
          // 单租户模式：根据配置决定是否显示下拉
          this.showTenantSelect = !!this.loginConfig.showTenantSelect;
          this.loginForm.tenantId = this.loginConfig.defaultTenantId || '0';
          this.tenantList = this.showTenantSelect
            ? (this.loginConfig.tenantList && this.loginConfig.tenantList.length
              ? this.loginConfig.tenantList
              : [{
                  tenantId: this.loginForm.tenantId,
                  tenantName: '默认租户'
                }])
            : [];
        }
      } catch (e) {
        // 配置异常时，保持默认单租户配置
        this.loginForm.tenantId = this.loginConfig.defaultTenantId || '0';
        this.showTenantSelect = false;
      }
    },
    async loadTenantList() {
      if (!this.loginForm.userName) {
        return;
      }
      const res = await getTenantList(this.loginForm.userName, this.loginForm.isAdminLogin);
      this.tenantList = res.data || [];
      // 如果当前未选择租户且有列表，则默认选第一个
      if (!this.loginForm.tenantId && this.tenantList.length > 0) {
        this.loginForm.tenantId = this.tenantList[0].tenantId;
      }
    },
    handleLogin() {
      this.$refs.loginForm.validate(async valid => {
        if (valid) {
          // 管理后台登录不需要租户；业务后台多租户模式下必须选择租户
          if (!this.loginForm.isAdminLogin && this.showTenantSelect && !this.loginForm.tenantId) {
            this.$message.error('请选择租户');
            return;
          }
          this.loading = true;
          if (this.loginForm.rememberMe) {
            Cookies.set("userName", this.loginForm.userName, { expires: 1440 });
            Cookies.set("password", encrypt(this.loginForm.password), { expires: 1440 });
            Cookies.set('rememberMe', this.loginForm.rememberMe, { expires: 1440 });
          } else {
            Cookies.remove("userName");
            Cookies.remove("password");
            Cookies.remove('rememberMe');
          }
          this.$store.dispatch("Login", this.loginForm).then(() => {
            this.$router.push({ path: this.redirect || "/" }).catch(()=>{});
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          });
        }
      });
    }
  }
};
</script>

<style rel="stylesheet/scss" lang="scss">
.login {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  background-image: url("../assets/images/login-background.jpg");
  background-size: cover;
}
.title {
  margin: 0px auto 30px auto;
  text-align: center;
  color: #707070;
}

.login-form {
  border-radius: 6px;
  background: #ffffff;
  width: 400px;
  padding: 25px 25px 5px 25px;
  .el-input {
    height: 38px;
    input {
      height: 38px;
    }
  }
  .input-icon {
    height: 39px;
    width: 14px;
    margin-left: 2px;
  }
}
.login-tip {
  font-size: 13px;
  text-align: center;
  color: #bfbfbf;
}
.login-code {
  width: 33%;
  height: 38px;
  float: right;
  img {
    cursor: pointer;
    vertical-align: middle;
  }
}
.el-login-footer {
  height: 40px;
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #fff;
  font-family: Arial;
  font-size: 12px;
  letter-spacing: 1px;
}
.login-code-img {
  height: 38px;
}
</style>
