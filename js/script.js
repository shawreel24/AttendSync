document.addEventListener('DOMContentLoaded', () => {
    const roleBtns = document.querySelectorAll('.role-btn');
    const emailLabel = document.getElementById('emailLabel');
    const emailInput = document.getElementById('email');
    const submitBtn = document.getElementById('submitBtn');
    const togglePwd = document.getElementById('togglePassword');
    const pwdInput = document.getElementById('password');
    const loginForm = document.getElementById('loginForm');

    const config = {
        Teacher: { label: 'Teacher Username', placeholder: 'e.g. teacher@hatim.local', btn: 'Login as Teacher' },
        Student: { label: 'Student Username', placeholder: 'e.g. student@hatim.local', btn: 'Login as Student' },
        Admin: { label: 'Admin Username', placeholder: 'e.g. admin@hatim.local', btn: 'Login as Admin' }
    };

    function setRole(role) {
        roleBtns.forEach(btn => btn.classList.toggle('active', btn.dataset.role === role));

        const conf = config[role];
        if (conf) {
            emailLabel.textContent = conf.label;
            emailInput.placeholder = conf.placeholder;
            submitBtn.innerHTML = `<i class='bx bx-log-in-circle'></i> ${conf.btn}`;
            
            emailInput.value = '';
            pwdInput.value = '';
        }
    }

    roleBtns.forEach(btn => btn.addEventListener('click', (e) => {
        e.preventDefault();
        setRole(btn.dataset.role);
    }));

    togglePwd.addEventListener('click', function () {
        const type = pwdInput.getAttribute('type') === 'password' ? 'text' : 'password';
        pwdInput.setAttribute('type', type);
        this.classList.toggle('bx-show');
        this.classList.toggle('bx-hide');
    });

    loginForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        const activeBtn = document.querySelector('.role-btn.active');
        const role = activeBtn ? activeBtn.dataset.role : 'Teacher';
        
        submitBtn.innerHTML = `<i class='bx bx-loader-alt bx-spin'></i> Logging in...`;
        submitBtn.style.opacity = '0.8';
        submitBtn.disabled = true;
        
        try {
            const response = await fetch('login.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    email: emailInput.value,
                    password: pwdInput.value,
                    role: role
                })
            });

            const data = await response.json();

            if (data.success) {
                submitBtn.innerHTML = `<i class='bx bx-check-circle'></i> Welcome, ${data.user.full_name}!`;

                // Persist user info so dashboard pages can use it
                try {
                    sessionStorage.setItem('user', JSON.stringify(data.user));
                    // Store teacher info separately for easy dashboard access
                    if (data.user.teacher_id) {
                        sessionStorage.setItem('teacher', JSON.stringify({
                            id:   data.user.teacher_id,
                            name: data.user.full_name,
                            dept: data.user.department_id
                        }));
                    }
                    if (data.user.student_id) {
                        sessionStorage.setItem('student', JSON.stringify({
                            id:     data.user.student_id,
                            name:   data.user.full_name,
                            rollNo: data.user.roll_no,
                            dept:   data.user.department_id,
                            semId:  data.user.semester_id
                        }));
                    }
                } catch(_) {}

                // Redirect based on role
                setTimeout(() => {
                    if (data.user.role === 'Teacher') {
                        window.location.href = 'teacher_dashboard.html';
                    } else if (data.user.role === 'Student') {
                        window.location.href = 'student_dashboard.html';
                    } else if (data.user.role === 'Admin') {
                        window.location.href = 'admin_dashboard.html';
                    } else {
                        window.location.href = 'teacher_dashboard.html'; // fallback
                    }
                }, 800);
            } else {
                alert(`Login failed: ${data.message}`);
            }
        } catch (error) {
            console.error('Error during login:', error);
            alert('An error occurred during login. Please ensure the server and database are running.');
        } finally {
            const conf = config[role] || { btn: `Login as ${role}` };
            submitBtn.innerHTML = `<i class='bx bx-log-in-circle'></i> ${conf.btn}`;
            submitBtn.style.opacity = '1';
            submitBtn.disabled = false;
        }
    });

    setRole('Teacher');
});
