<template>
  <v-container class="px-12">
    <v-row>
      <v-col>
        <v-expansion-panels>
          <UploadCert />
          <UploadList />
        </v-expansion-panels>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import UploadCert from "@/components/UploadCert.vue";
import UploadList from "@/components/UploadList.vue";
export default {
  components: {
    UploadCert,
    UploadList,
  },
};
</script>

<style lang="scss" scoped></style>
