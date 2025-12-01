<template>
  <div :style="'height:' + height" v-loading="loading" element-loading-text="正在加载页面，请稍候！">
    <iframe
      :id="iframeId"
      style="width: 100%; height: 100%"
      :src="processedSrc"
      frameborder="no"
    ></iframe>
  </div>
</template>

<script>
import { getToken } from '@/utils/auth'

export default {
  props: {
    src: {
      type: String,
      default: "/"
    },
    iframeId: {
      type: String
    }
  },
  data() {
    return {
      loading: false,
      height: document.documentElement.clientHeight - 94.5 + "px;"
    };
  },
  computed: {
    processedSrc() {
      // 获取当前token
      const token = getToken()
      
      if (!token || !this.src) {
        return this.src
      }
      
      // 如果是外部链接，添加token参数
      if (this.isExternal(this.src)) {
        try {
          const urlObj = new URL(this.src)
          urlObj.searchParams.set('token', token)
          return urlObj.toString()
        } catch (e) {
          // 如果URL解析失败，尝试简单拼接
          const separator = this.src.includes('?') ? '&' : '?'
          return `${this.src}${separator}token=${token}`
        }
      }
      
      return this.src
    }
  },
  methods: {
    isExternal(path) {
      return /^(https?:|mailto:|tel:)/.test(path)
    }
  },
  mounted() {
    var _this = this;
    const iframeId = ("#" + this.iframeId).replace(/\//g, "\\/");
    const iframe = document.querySelector(iframeId);
    // iframe页面loading控制
    if (iframe.attachEvent) {
      this.loading = true;
      iframe.attachEvent("onload", function () {
        _this.loading = false;
      });
    } else {
      this.loading = true;
      iframe.onload = function () {
        _this.loading = false;
      };
    }
  }
};
</script>
