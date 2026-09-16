// Captures the web build at phone size. Usage: node shoot.js <outDir> [step ...]
// Steps: wait:ms · tap:x,y · type:text · swipe:x,fromY,toY · shot:name (coordinates in CSS px on a 390x844 phone).
const pw = require('/home/lionel/Documents/Junkyard/gobeer/node_modules/playwright');
const [,, outDir, ...steps] = process.argv;
(async () => {
  const b = await pw.chromium.launch({ executablePath: '/usr/bin/google-chrome',
    args: ['--no-sandbox', '--use-angle=swiftshader', '--enable-unsafe-swiftshader'] });
  const ctx = await b.newContext({ viewport: { width: 390, height: 844 }, deviceScaleFactor: 2, isMobile: true, hasTouch: true });
  const p = await ctx.newPage();
  p.on('pageerror', e => console.log('PAGEERROR', e.message.slice(0, 160)));
  await p.goto('http://127.0.0.1:8765/', { waitUntil: 'load', timeout: 90000 });
  for (const s of steps) {
    const [k, v] = s.split(/:(.*)/s);
    if (k === 'wait') await p.waitForTimeout(+v);
    else if (k === 'tap') { const [x, y] = v.split(',').map(Number); await p.touchscreen.tap(x, y); }
    else if (k === 'type') { await p.keyboard.type(v, { delay: 30 }); }
    else if (k === 'swipe') { const [x, y1, y2] = v.split(',').map(Number); await p.mouse.move(x, y1); await p.mouse.down(); await p.mouse.move(x, y2, { steps: 12 }); await p.mouse.up(); }
    else if (k === 'shot') { await p.screenshot({ path: `${outDir}/${v}.png` }); console.log('shot', v); }
  }
  await b.close();
})();
