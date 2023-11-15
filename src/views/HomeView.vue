<template>
  <v-container grid-list-xs>
    <v-row>
      <v-col>
        <v-carousel rounded="xl" cycle show-arrows="hover" hide-delimiters>
          <v-parallax v-for="(cover, id) in covers" :key="id">
            <v-carousel-item cover draggable :src="cover"> </v-carousel-item>
          </v-parallax>
        </v-carousel>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="8">
        <v-card variant="outlined">
          <v-card-title>Giới thiệu về dự án SerMan</v-card-title>
          <v-card-text class="text-justify">
            <p>
              Chào mừng đến với dự án của <strong>SerMan</strong>! Chúng tôi tự
              hào giới thiệu hệ thống cấp phát chứng chỉ dưới dạng NFT
              (Non-Fungible Tokens) - một giải pháp tiên tiến trong việc lưu trữ
              và quản lý chứng chỉ.
            </p>
            <p>
              Dự án của chúng tôi nhằm tối ưu hóa quy trình cấp phát chứng chỉ
              và mang lại nhiều lợi ích cho người dùng. Với công nghệ blockchain
              và chuỗi khối, chúng tôi tạo ra các chứng chỉ dưới dạng NFT, đảm
              bảo tính xác thực, không thể sửa đổi và dễ dàng xác minh.
            </p>
            <p>
              Lưu trữ chứng chỉ dưới dạng NFT mang lại nhiều ưu điểm. Thứ nhất,
              tính xác thực cao giúp ngăn chặn việc làm giả chứng chỉ. Mỗi NFT
              được mã hóa và gắn kết với thông tin cụ thể của người sở hữu, tạo
              ra một dấu ấn duy nhất không thể sao chép.
            </p>
            <p>
              Thứ hai, việc lưu trữ chứng chỉ dưới dạng NFT giúp dễ dàng xác
              minh và quản lý. Mỗi NFT có thể được theo dõi trên chuỗi khối, cho
              phép kiểm tra lịch sử sở hữu và xác thực nhanh chóng.
            </p>
            <p>
              Thứ ba, tính khả diễn giải của NFT cho phép chúng ta kết hợp với
              các tính năng sáng tạo khác. Chúng tôi có thể tạo ra các chứng chỉ
              tương tác, cho phép người sở hữu tùy chỉnh và chia sẻ thông tin về
              chứng chỉ của mình một cách linh hoạt.
            </p>
            <p>
              Cuối cùng, việc sử dụng NFT giúp tăng tính minh bạch và an toàn
              cho hệ thống cấp phát chứng chỉ. Mỗi giao dịch và sở hữu đều được
              ghi lại trên blockchain, đảm bảo tính toàn vẹn dữ liệu và tránh
              được các sai sót.
            </p>
            <p>
              Với dự án này, chúng tôi hy vọng mang lại sự tiện lợi, tin cậy và
              hiệu quả cho quá trình cấp phát chứng chỉ. Chúng tôi rất phấn khởi
              và sẵn lòng chào đón sự hỗ trợ và hợp tác của bạn để xây dựng một
              hệ thống tuyệt vời, đáng tin cậy và phù hợp với nhu cầu ngày càng
              cao của thế giới số hóa.
            </p>
          </v-card-text>
        </v-card>
      </v-col>
      <v-col cols="4">
        <v-img
          height="100%"
          cover
          class="rounded"
          src="https://m.media-amazon.com/images/I/61t0nMnd2iL._AC_UF1000,1000_QL80_.jpg"
        ></v-img>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="4">
        <v-img
          height="400px"
          cover
          class="rounded"
          src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZmEDH14K82c5xCcuT0H0AXXfHaClCJeZ-ug&usqp=CAU"
        ></v-img>
      </v-col>
      <v-col cols="8">
        <v-img
          height="400px"
          cover
          class="rounded"
          src="https://itguru.vn/blog/wp-content/uploads/2021/11/nft_la_gi.jpg"
        ></v-img>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      covers: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbgIfuugsDmRG7UhWTQy3497qdpZS-PChEvA&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnowvuAJKEDQrhB9ajUJt7JXRqO4KT8Sg06Q&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0zVhvNHkNzEPKWuQ7TBw369R_F23Ev0gD1g&usqp=CAU",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfA3XqKfnUPNAtdcAEFGPocZlCJoerk-BsUw&usqp=CAU",
      ],
    };
  },
};
</script>

<style></style>
