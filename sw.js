const C='datacenter-v2';
self.addEventListener('install',()=>self.skipWaiting());
self.addEventListener('activate',e=>e.waitUntil(clients.claim()));
self.addEventListener('fetch',e=>{const r=e.request,u=new URL(r.url);
 if(r.method!=='GET'||!/^https?:$/.test(u.protocol)||/firestore|identitytoolkit|securetoken|googleapis\.com$/.test(u.hostname)&&!/fonts/.test(u.hostname)||u.pathname.startsWith('/__/'))return;
 e.respondWith(caches.open(C).then(async c=>{try{const n=await fetch(r);if(n.ok||n.type==='opaque')c.put(r,n.clone());return n}catch(x){const m=await c.match(r);if(m)return m;throw x}}))});
