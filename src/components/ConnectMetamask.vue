<template>
  <v-btn
    variant="outlined"
    color="secondary"
    @click="connect"
    v-if="!isConnected"
  >
    Connect Metamask
  </v-btn>
  <div v-if="isConnected">
    <v-chip color="secondary" class="mr-3 text-caption">
      <strong>{{ shortenedAddress }}</strong>
    </v-chip>
    <v-avatar size="32" color="dark">
      <v-img :src="avatarUrl" />
    </v-avatar>
  </div>
</template>

<script>
//import Web3 from "web3";
import blockies from "ethereum-blockies";

export default {
  data() {
    return {
      isConnected: false,
      currentAccount: null,
    };
  },
  computed: {
    shortenedAddress() {
      if (!this.currentAccount) return "";
      return (
        this.currentAccount.slice(0, 6) + "..." + this.currentAccount.slice(-4)
      );
    },
    avatarUrl() {
      if (!this.currentAccount) return "";
      console.log(
        blockies
          .create({
            seed: this.currentAccount,
            size: 4,
            scale: 8,
          })
          .toDataURL()
      );
      return blockies
        .create({ seed: this.currentAccount, size: 8, scale: 16 })
        .toDataURL();
    },
  },
  methods: {
    async connect() {
      if (typeof window.ethereum !== "undefined") {
        try {
          await window.ethereum.enable();
          await this.updateAccount();
        } catch (error) {
          console.error("Failed to connect:", error);
        }
      } else {
        console.error("Metamask not found.");
      }
    },
    async disconnect() {
      this.isConnected = false;
      this.currentAccount = null;
    },
    async updateAccount() {
      const accounts = await window.ethereum.request({
        method: "eth_accounts",
      });
      if (accounts.length > 0) {
        this.isConnected = true;
        this.currentAccount = accounts[0];
      } else {
        this.isConnected = false;
        this.currentAccount = null;
      }
    },
  },
  mounted() {
    if (typeof window.ethereum !== "undefined") {
      window.ethereum.on("accountsChanged", this.updateAccount);
    }
  },
  beforeUnmount() {
    if (typeof window.ethereum !== "undefined") {
      window.ethereum.removeListener("accountsChanged", this.updateAccount);
    }
  },
};
</script>

<style scoped></style>
