# Sử dụng hình ảnh NGINX từ Docker Hub
FROM nginx:alpine

# XÓA default config gốc
RUN rm /etc/nginx/conf.d/default.conf

# Copy config của bạn
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Expose cổng 80
EXPOSE 80