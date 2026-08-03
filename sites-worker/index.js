const MIME_TYPES = {
  ".css": "text/css; charset=utf-8",
  ".gif": "image/gif",
  ".html": "text/html; charset=utf-8",
  ".ico": "image/x-icon",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".js": "text/javascript; charset=utf-8",
  ".json": "application/json; charset=utf-8",
  ".md": "text/markdown; charset=utf-8",
  ".png": "image/png",
  ".svg": "image/svg+xml",
  ".txt": "text/plain; charset=utf-8",
  ".webp": "image/webp",
  ".xml": "application/xml; charset=utf-8",
};

function contentType(pathname) {
  const dotIndex = pathname.lastIndexOf(".");
  if (dotIndex === -1) {
    return "application/octet-stream";
  }

  const extension = pathname.slice(dotIndex).toLowerCase();
  return MIME_TYPES[extension] || "application/octet-stream";
}

function assetRequest(request, pathname) {
  const url = new URL(request.url);
  url.pathname = pathname;
  return new Request(url, request);
}

async function fetchAsset(env, request, pathname) {
  const response = await env.ASSETS.fetch(assetRequest(request, pathname));
  if (response.status === 404) {
    return response;
  }

  const headers = new Headers(response.headers);
  headers.set("content-type", contentType(pathname));
  return new Response(response.body, {
    status: response.status,
    statusText: response.statusText,
    headers,
  });
}

function candidatePaths(pathname) {
  const cleanPath = pathname || "/";
  const paths = [];

  if (cleanPath.endsWith("/")) {
    paths.push(`${cleanPath}index.html`);
  } else {
    paths.push(cleanPath);
    if (!cleanPath.includes(".")) {
      paths.push(`${cleanPath}.html`);
      paths.push(`${cleanPath}/index.html`);
    }
  }

  return paths;
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const pathname = decodeURIComponent(url.pathname);

    for (const candidate of candidatePaths(pathname)) {
      const response = await fetchAsset(env, request, candidate);
      if (response.status !== 404) {
        return response;
      }
    }

    return new Response("Not found", {
      status: 404,
      headers: {
        "content-type": "text/plain; charset=utf-8",
      },
    });
  },
};
