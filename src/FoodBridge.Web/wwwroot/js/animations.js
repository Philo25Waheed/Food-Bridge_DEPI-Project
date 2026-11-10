let scrollRevealObserver = null;
let scrollMutationObserver = null;

function observeScrollElement(el) {
    if (!el || el.classList.contains('revealed')) return;

    if (!('IntersectionObserver' in window)) {
        el.classList.add('revealed');
        return;
    }

    el.classList.add('scroll-hidden');

    const rect = el.getBoundingClientRect();
    if (rect.top < window.innerHeight && rect.bottom > 0) {
        el.classList.add('revealed');
        return;
    }

    if (scrollRevealObserver) {
        scrollRevealObserver.observe(el);
    }
}

function initScrollReveal() {
    if (!('IntersectionObserver' in window)) {
        document.querySelectorAll('.scroll-reveal, .scroll-reveal-left, .scroll-reveal-right, .scroll-reveal-scale').forEach(el => {
            el.classList.add('revealed');
        });
        return;
    }

    if (!scrollRevealObserver) {
        scrollRevealObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('revealed');
                    observer.unobserve(entry.target);
                }
            });
        }, {
            threshold: 0.15,
            rootMargin: '0px 0px -40px 0px'
        });
    }

    const revealElements = document.querySelectorAll(
        '.scroll-reveal:not(.revealed), .scroll-reveal-left:not(.revealed), .scroll-reveal-right:not(.revealed), .scroll-reveal-scale:not(.revealed)'
    );

    revealElements.forEach(el => observeScrollElement(el));

    if (!scrollMutationObserver && 'MutationObserver' in window) {
        scrollMutationObserver = new MutationObserver((mutations) => {
            mutations.forEach(mutation => {
                mutation.addedNodes.forEach(node => {
                    if (node.nodeType === Node.ELEMENT_NODE) {
                        if (node.matches && node.matches('.scroll-reveal, .scroll-reveal-left, .scroll-reveal-right, .scroll-reveal-scale')) {
                            observeScrollElement(node);
                        }
                        if (node.querySelectorAll) {
                            node.querySelectorAll('.scroll-reveal:not(.revealed), .scroll-reveal-left:not(.revealed), .scroll-reveal-right:not(.revealed), .scroll-reveal-scale:not(.revealed)').forEach(child => {
                                observeScrollElement(child);
                            });
                        }
                    }
                });
            });
        });

        scrollMutationObserver.observe(document.body, {
            childList: true,
            subtree: true
        });
    }
}

function init3DTilt() {
    document.querySelectorAll('.card-tilt-hover, .glass-stat-card').forEach(card => {
        if (card.dataset.tiltInitialized) return;
        card.dataset.tiltInitialized = 'true';

        card.addEventListener('mousemove', e => {
            const rect = card.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            const centerX = rect.width / 2;
            const centerY = rect.height / 2;
            const rotateX = ((y - centerY) / centerY) * -6;
            const rotateY = ((x - centerX) / centerX) * 6;
            card.style.transform = `perspective(1000px) rotateX(${rotateX.toFixed(2)}deg) rotateY(${rotateY.toFixed(2)}deg) translateY(-8px) scale3d(1.02, 1.02, 1.02)`;
        });

        card.addEventListener('mouseleave', () => {
            card.style.transform = '';
        });
    });
}


function animateCounter(elementId, targetValue, duration = 1400) {
    const el = document.getElementById(elementId);
    if (!el) return;

    const end = parseInt(targetValue, 10);
    if (isNaN(end)) {
        el.textContent = targetValue;
        return;
    }

    let start = 0;
    const startTime = performance.now();

    function updateCounter(currentTime) {
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);
        const easeOut = 1 - Math.pow(2, -10 * progress);
        const current = Math.floor(start + (end - start) * easeOut);

        el.textContent = `${current}+`;

        if (progress < 1) {
            requestAnimationFrame(updateCounter);
        } else {
            el.textContent = `${end}+`;
        }
    }

    requestAnimationFrame(updateCounter);
}

