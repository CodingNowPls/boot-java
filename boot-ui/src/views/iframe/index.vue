<template>
  <inner-link :src="iframeSrc" :iframe-id="iframeId" />
</template>

<script>
import InnerLink from '@/layout/components/InnerLink'

export default {
  name: 'IframeView',
  components: { InnerLink },
  data() {
    return {
      iframeId: 'iframe-' + Date.now()
    }
  },
  computed: {
    iframeSrc() {
      // 从路由参数中获取URL
      const encodedUrl = this.$route.params.url
      console.log('Iframe component - Route params:', this.$route.params)
      console.log('Iframe component - Encoded URL:', encodedUrl)
      console.log('Iframe component - Full route:', this.$route)
      
      if (encodedUrl) {
        try {
          const decodedUrl = decodeURIComponent(encodedUrl)
          console.log('Iframe component - Decoded URL:', decodedUrl)
          return decodedUrl
        } catch (e) {
          console.error('Failed to decode URL:', encodedUrl)
          return encodedUrl
        }
      }
      
      // 从路由meta中获取link
      if (this.$route.meta && this.$route.meta.link) {
        console.log('Iframe component - Using meta link:', this.$route.meta.link)
        return this.$route.meta.link
      }
      
      console.log('Iframe component - No URL found, using default')
      return '/'
    }
  }
}
</script>