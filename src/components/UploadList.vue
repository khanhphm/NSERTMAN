<template>
  <v-expansion-panel disabled title="Upload from list">
    <v-expansion-panel-text>
      <v-container>
        <v-row>
          <v-col>
            <v-file-input
              v-model="fileList"
              label="XLSX File"
              accept=".xlsx"
            ></v-file-input>
            <v-btn @click="handleList()" variant="outlined" block>Upload</v-btn>
          </v-col>
        </v-row>
      </v-container>
    </v-expansion-panel-text>
  </v-expansion-panel>
</template>

<script>
//import contract from "@/contracts/Web3";
import { mapState } from "vuex";
import * as XLSX from "xlsx";
export default {
  data() {
    return {
      fileList: [],
      certList: [],
      recipients: [],
      uris: [],
    };
  },
  computed: {
    ...mapState(["currentAccount"]),
  },
  methods: {
    async handleList() {
      const file = this.fileList[0];

      const reader = new FileReader();

      reader.onload = (e) => {
        const data = new Uint8Array(e.target.result);
        this.fileHandle(data);
        // Hoặc lưu objects vào state của component hoặc truyền vào một phương thức khác
      };
      reader.readAsArrayBuffer(file);
    },
    async fileHandle(data) {
      const workbook = XLSX.read(data, { type: "array" });

      const sheetName = workbook.SheetNames[0];
      const worksheet = workbook.Sheets[sheetName];
      const jsonData = XLSX.utils.sheet_to_json(worksheet, { header: 1 });

      const rows = jsonData.slice(1);

      const filteredRows = rows.filter((row) => {
        return row.some((value) => value !== "");
      });
      this.recipients = filteredRows.map((item) => item[0]);

      filteredRows.map((row) => {
        const data = {
          name: row[1],
          description: row[2],
          image: row[3],
        };

        const options = {
          method: "POST",
          headers: {
            accept: "application/json",
            "content-type": "application/json",
            authorization: `Bearer ${process.env.VUE_APP_JWT}`,
          },
          body: JSON.stringify({
            pinataContent: data,
            pinataOptions: { cidVersion: 1, title: "cert" },
          }),
        };

        fetch("https://api.pinata.cloud/pinning/pinJSONToIPFS", options).then(
          (data) => {
            data.json().then((data) => {
              console.log(this);
              this.uris.push(data.IpfsHash);
            });
          }
        );
      });
    },
  },
};
</script>

<style lang="scss" scoped></style>
