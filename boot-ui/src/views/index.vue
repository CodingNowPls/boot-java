<template>
  <div class="app-container home">
    <div v-if="homePageUrl" class="iframe-container">
      <inner-link :src="homePageUrl" iframe-id="homepage-iframe"></inner-link>
    </div>
    <div v-else class="no-homepage">

    </div>
  </div>
</template>

<script>
import InnerLink from '@/layout/components/InnerLink'
import { getIndexInfo } from '@/api/system/menu'
import { mapGetters } from 'vuex'

export default {
  name: 'Index',
  components: {
    InnerLink
  },
  data() {
    return {
      // 版本号
      version: '1.0.0',
      lineChartData: null,
      show: false,
      todaySalesList: [],
      todaySalesText: '',
      yesterdaySalesList: [],
      yesterdaySalesText: '',
      homePageUrl: ''
    }
  },
  computed: {
    ...mapGetters([
      'sidebarRouters',
      'defaultRoutes',
      'permission_routes'
    ])
  },
  created() {
    this.findHomePageUrl()
  },
  methods: {
    async findHomePageUrl() {
      // 调用后端指定首页接口
      try {
        const resp = await getIndexInfo()
        const item = resp && resp.data ? resp.data : null
        if (!item) {
          this.homePageUrl = ''
          return
        }

        const url = (item.path || '').replace(/`/g, '').trim()
        const isHttp = (u) => /^https?:\/\//i.test(u)
        const isExternal = item.isFrame === '0' || item.isFrame === 0
        const isEmbed = String(item.frameEmbedFlag) === '1' || item.frameEmbedFlag === 1

        // 条件：外链且内嵌页面且为有效 http 地址，才渲染
        this.homePageUrl = (isExternal && isEmbed && isHttp(url)) ? url : ''
      } catch (e) {
        // 请求异常时显示空白
        this.homePageUrl = ''
      }
    },

  }
}
</script>

<style scoped lang="scss">
.home {
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }

  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }

  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 5px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }

  .iframe-container {
    height: calc(100vh - 200px);
    width: 100%;
  }

  .no-homepage {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 300px;
    font-size: 18px;
    color: #909399;
  }
}
</style>

