document.addEventListener('DOMContentLoaded', function() {

    // 1. Image Gallery Thumbnail Clicking
    const thumbnails = document.querySelectorAll('.thumbnail');
    const mainImage = document.querySelector('.main-image');
    
    if (thumbnails.length > 0 && mainImage) {
        thumbnails.forEach(thumb => {
            thumb.addEventListener('click', function() {
                // Update main image source
                mainImage.src = this.src;
                // Update active state
                thumbnails.forEach(t => t.classList.remove('active'));
                this.classList.add('active');
            });
        });
        
        // Simple zoom effect on main image
        const imgWrap = document.querySelector('.main-image-wrap');
        imgWrap.addEventListener('mousemove', function(e) {
            const { left, top, width, height } = this.getBoundingClientRect();
            const x = (e.clientX - left) / width * 100;
            const y = (e.clientY - top) / height * 100;
            mainImage.style.transformOrigin = `${x}% ${y}%`;
            mainImage.style.transform = 'scale(2)';
        });
        
        imgWrap.addEventListener('mouseleave', function() {
            mainImage.style.transformOrigin = 'center center';
            mainImage.style.transform = 'scale(1)';
        });
    }

    // 2. Quantity Stepper
    const qtyWraps = document.querySelectorAll('.quantity-selector');
    qtyWraps.forEach(wrap => {
        const input = wrap.querySelector('.qty-input');
        const minus = wrap.querySelector('.qty-minus');
        const plus = wrap.querySelector('.qty-plus');
        
        if(minus && plus && input) {
            minus.addEventListener('click', (e) => {
                e.preventDefault();
                let val = parseInt(input.value);
                if (val > 1) {
                    input.value = val - 1;
                }
            });
            
            plus.addEventListener('click', (e) => {
                e.preventDefault();
                let val = parseInt(input.value);
                if (val < 10) { // Max 10 limit
                    input.value = val + 1;
                }
            });
        }
    });

    // 3. Size and Color Selection
    const sizeBtns = document.querySelectorAll('.size-btn');
    const sizeInput = document.getElementById('selectedSize');
    
    sizeBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            sizeBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            if(sizeInput) sizeInput.value = this.dataset.size;
        });
    });

    const colorBtns = document.querySelectorAll('.color-btn');
    const colorInput = document.getElementById('selectedColor');
    
    colorBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            colorBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            if(colorInput) colorInput.value = this.dataset.color;
        });
    });

    // 4. AJAX Wishlist Toggle
    const wishlistBtns = document.querySelectorAll('.wishlist-toggle');
    wishlistBtns.forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            const productId = this.dataset.id;
            const action = this.classList.contains('active') ? 'remove' : 'add';
            
            fetch(`wishlist?action=${action}&productId=${productId}`, {
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    this.classList.toggle('active');
                    showToast(action === 'add' ? 'Added to wishlist' : 'Removed from wishlist', 'success');
                } else {
                    window.location.href = 'login.jsp';
                }
            })
            .catch(() => {
                window.location.href = 'login.jsp'; // Fallback redirect if not logged in
            });
        });
    });

    // 5. Autocomplete Search
    const searchInput = document.getElementById('searchInput');
    const searchSuggest = document.getElementById('searchSuggestions');
    
    if (searchInput && searchSuggest) {
        let timeout = null;
        
        searchInput.addEventListener('input', function() {
            clearTimeout(timeout);
            const query = this.value.trim();
            
            if (query.length < 2) {
                searchSuggest.classList.remove('active');
                return;
            }
            
            timeout = setTimeout(() => {
                fetch(`searchSuggest?keyword=${encodeURIComponent(query)}`)
                .then(response => response.json())
                .then(data => {
                    if (data.length > 0) {
                        searchSuggest.innerHTML = '';
                        data.forEach(item => {
                            const div = document.createElement('div');
                            div.className = 'suggestion-item';
                            div.textContent = item;
                            div.addEventListener('click', function() {
                                searchInput.value = this.textContent;
                                searchSuggest.classList.remove('active');
                                document.getElementById('searchForm').submit();
                            });
                            searchSuggest.appendChild(div);
                        });
                        searchSuggest.classList.add('active');
                    } else {
                        searchSuggest.classList.remove('active');
                    }
                });
            }, 300); // 300ms debounce
        });
        
        // Hide suggestions when clicking outside
        document.addEventListener('click', function(e) {
            if (!searchInput.contains(e.target) && !searchSuggest.contains(e.target)) {
                searchSuggest.classList.remove('active');
            }
        });
    }

    // 6. Apply Coupon AJAX
    const applyCouponBtn = document.getElementById('applyCouponBtn');
    if (applyCouponBtn) {
        applyCouponBtn.addEventListener('click', function() {
            const code = document.getElementById('couponCode').value.trim();
            const orderTotal = document.getElementById('cartSubtotal').dataset.value;
            
            if (!code) return;
            
            const formData = new URLSearchParams();
            formData.append('code', code);
            formData.append('orderTotal', orderTotal);
            
            fetch('applyCoupon', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: formData.toString()
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    showToast(`Coupon applied! You saved Rs. ${data.discount}`, 'success');
                    // Reload page to reflect new totals (or update DOM dynamically)
                    setTimeout(() => window.location.reload(), 1500);
                } else {
                    showToast(data.message, 'error');
                }
            });
        });
    }

    // Toast Notification System
    function showToast(message, type = 'success') {
        let container = document.querySelector('.toast-container');
        if (!container) {
            container = document.createElement('div');
            container.className = 'toast-container';
            document.body.appendChild(container);
        }
        
        const toast = document.createElement('div');
        toast.className = `toast ${type}`;
        
        const icon = type === 'success' ? '✓' : '⚠';
        toast.innerHTML = `<span>${icon}</span> <span>${message}</span>`;
        
        container.appendChild(toast);
        
        // Trigger reflow
        toast.offsetHeight;
        toast.classList.add('show');
        
        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    }
});
