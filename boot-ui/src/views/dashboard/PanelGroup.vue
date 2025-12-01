<template>
  <el-row :gutter="40" class="panel-group">

  </el-row>
</template>

<script>
import CountTo from 'vue-count-to'

export default {
  components: {
    CountTo
  },
  props: {
    show: {
      type: Boolean,
      default: false
    }
  },
  methods: {

    goView(type) {
      this.$emit('goView', type)
    }
  }
}
</script>

<style lang="scss" scoped>
.panel-group {
  margin-top: 10px;

  .card-panel-col {
    margin-bottom: 32px;
  }

  .card-panel {
    height: 100px; /* 调整卡片高度 */
    cursor: pointer;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    color: #666;
    background: #fff;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, .05);
    border-color: rgba(0, 0, 0, .05);
    display: flex;
    align-items: center;
    padding: 10px;

    &:hover {
      .card-panel-icon-wrapper {
        color: #fff;
      }

      .icon-people {
        background: #40c9c6;
      }

      .icon-message {
        background: #36a3f7;
      }

      .icon-money {
        background: #f4516c;
      }

      .icon-shopping {
        background: #34bfa3
      }
    }

    .icon-people {
      color: #40c9c6;
    }

    .icon-message {
      color: #36a3f7;
    }

    .icon-money {
      color: #f4516c;
    }

    .icon-shopping {
      color: #34bfa3
    }

    .card-panel-icon-wrapper {
      margin-right: 16px;
      transition: all 0.38s ease-out;
      border-radius: 6px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .card-panel-icon {
      font-size: 22px;
    }

    .card-panel-description {
      display: flex;
      flex-direction: column;
      justify-content: center;

      .card-panel-text {
        line-height: 18px;
        color: rgba(0, 0, 0, 0.45);
        font-size: 14px; /* 调整字体大小 */
        margin-bottom: 4px;
      }

      .card-panel-num {
        font-size: 18px; /* 调整字体大小 */
      }
    }
  }
}

@media (max-width: 550px) {
  .card-panel-description {
    display: none;
  }

  .card-panel-icon-wrapper {
    width: 100%;
    height: 100%;
    margin: 0 !important;

    .svg-icon {
      display: block;
      margin: 14px auto !important;
    }
  }
}


</style>
