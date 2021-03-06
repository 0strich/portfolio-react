# Build React App
FROM node:14.15.0 as builder
RUN mkdir -p /project/portfolio-react
WORKDIR /project/portfolio-react
ENV PATH /project/portfolio-react/node_modules/.bin:$PATH
COPY package.json /project/portfolio-react/package.json
RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent
COPY . /project/portfolio-react
RUN npm run build

# Production Environment
FROM nginx:1.19.3-alpine
ENV PUBLIC_URL wisrich.contact
COPY --from=builder /project/portfolio-react/build /usr/share/nginx/html
EXPOSE 80
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
