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

## 📁 Project Structure

```bash
.
├── src/              # App source code
├── public/           # Static public assets
├── dist/             # Built production files (created after build)
├── Dockerfile        # Multi-stage Dockerfile with Nginx
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