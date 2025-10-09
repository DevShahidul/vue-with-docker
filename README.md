# Learning Resources App

This project is a Vue 3 application built with [Vite](https://vitejs.dev/). It uses [pnpm](https://pnpm.io/) for package management and is containerized using Docker with a multi-stage build, serving the production build using Nginx.

---

## 🚀 Recommended IDE Setup

- [Visual Studio Code](https://code.visualstudio.com/)
- [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (disable Vetur)

---

## ⚙️ Project Setup (Local Development)

Install dependencies:

```bash
pnpm install
```

Start local development server with hot reload:

```bash
pnpm dev
```

Build the production version:

```bash
pnpm build
```

Preview the production build locally:

```bash
pnpm preview
```

## 🐳 Running with Docker
This project supports a full Docker-based workflow, with multi-stage builds and Nginx serving the static production files.

### 1. 🛠 Build the Docker image

```bash
docker build -t learning-resources-app .
```

### 2. 🚀 Run the container

```bash
docker run -d -p 80:80 --name learning-resources-container learning-resources-app
```

Your app will now be accessible at:

```bash
http://localhost
```

If you want to access it from another device on the same network, use your host machine’s local IP instead of localhost.

----

### 💡 Development Mode Setup
If you want to run the app in development mode and automatically sync code changes live, create a new file named Dockerfile.dev using the content below. Then, follow the provided commands to build your dev image and run the container.

##### Create your Dockerfile.dev
```bash
FROM node:24-alpine
RUN npm install --global corepack@latest \
    && corepack enable pnpm \
    && corepack prepare pnpm@latest-10

RUN addgroup app && adduser -S -G app app
USER app

# Make project directory
WORKDIR /usr/local/app

# Copy project packages/dependencies
COPY package*.json ./

# Install dependencies
RUN pnpm install

# Copy source code in app directory
COPY . .

EXPOSE 5173
CMD ["pnpm", "dev"]
```

##### Build image for your Dockerfile.dev and Run Development Container
```bash
docker build -f Dockerfile.dev -t myapp-dev .
```
Use the following command to start the dev container with live code updates:
```bash
docker run -d -p 5173:5173 --name lrc -v $(pwd):/usr/local/app -v /usr/local/app/node_modules myapp-dev 
```

##### 🔍 Explanation the command:
- 🧱 docker run -d → Runs the container in the background (detached mode).
- 🌐 -p 5173:5173 → Maps port 5173 inside the container to port 5173 on your local machine (e.g., for Vite dev server).
- 🏷️ --name lrc → Assigns the container a custom name (lrc) for easy reference.
- 💻 -v $(pwd):/usr/local/app → Mounts your local project folder to the container so any file changes update instantly (live reload).
- 📦 -v /usr/local/app/node_modules → Keeps container’s own node_modules intact, avoiding host–container dependency issues.
- 🚀 myapp-dev → The image to run, built from your Dockerfile.dev for development mode.

## 📁 Project Structure

```bash
.
├── src/              # App source code
├── public/           # Static public assets
├── dist/             # Built production files (created after build)
├── Dockerfile        # Multi-stage Dockerfile with Nginx
├── Dockerfile.dev    # Dockerfile for dev mode
├── nginx.conf        # (Optional) Nginx config for SPA routing
├── index.html        
├── package.json
├── vite.config.js
└── README.md
```

### 🌐 Accessing App from Other Devices

Find your local IP (e.g., 192.168.1.42)
Visit: http://192.168.1.42 from any device on the same Wi-Fi/network

### 🔐 Security Notes

- ✅ Safe for static frontend apps (no backend exposure)
- 🔁 If using Vue Router (history mode), add a custom nginx.conf with:
```bash
location / {
  try_files $uri $uri/ /index.html;
}
```
- ✅ Use HTTPS and secure headers for real production environments
- 🚫 Avoid exposing .env files or source maps (*.map) in your production build

## 🧠 Deployment Tips

- For public hosting, consider platforms like:
    - Vercel
    - Netlify
    - Render
    - DigitalOcean App Platform
- For custom domains, use HTTPS with Let's Encrypt
- Combine with a backend via a reverse proxy (Nginx, Traefik, etc.)


Feel free to reach out or open an issue if you'd like to contribute or ask questions.