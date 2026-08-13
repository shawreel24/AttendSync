// signup.js – AttendSync Student & Teacher Signup  (multi-subject version)
document.addEventListener('DOMContentLoaded', () => {

    // ── DOM refs ──────────────────────────────────────────────────────────
    const roleBtns       = document.querySelectorAll('.role-btn');
    const emailLabel     = document.getElementById('emailLabel');
    const emailInput     = document.getElementById('email');
    const fullNameInput  = document.getElementById('fullName');
    const submitBtn      = document.getElementById('submitBtn');
    const togglePwd      = document.getElementById('togglePassword');
    const pwdInput       = document.getElementById('password');
    const toggleConfirmPwd = document.getElementById('toggleConfirmPassword');
    const confirmPwdInput  = document.getElementById('confirmPassword');
    const signupForm     = document.getElementById('signupForm');

    const departmentSelect = document.getElementById('department');
    const semesterGroup    = document.getElementById('semesterGroup');
    const semesterSelect   = document.getElementById('semester');

    // Student-only fields
    const rollNoGroup    = document.getElementById('rollNoGroup');
    const rollNoInput    = document.getElementById('rollNo');
    const studentIdGroup = document.getElementById('studentIdGroup');
    const studentIdInput = document.getElementById('studentId');

    // Multi-subject picker elements
    const subjectTrigger  = document.getElementById('subjectTrigger');
    const subjectDropdown = document.getElementById('subjectDropdown');
    const subjectChevron  = document.getElementById('subjectChevron');
    const subjectSearch   = document.getElementById('subjectSearch');
    const subjectList     = document.getElementById('subjectList');
    const subjectPlaceholder = document.getElementById('subjectPlaceholder');
    const subjectCountBadge  = document.getElementById('subjectCountBadge');
    const selectAllBtn    = document.getElementById('selectAllBtn');

    // ── Subject data (matches actual DB attendsync.sql) ───────────────────
    // dept_id → { semNo: [ { name, id } ] }
    // IDs match the subjects table in the SQL dump
    const subjectsByDeptSem = {
        '7': { // BCA – department_id = 7
            '1': [
                { name: 'Maths',       id: 25 },
                { name: 'Comp Arch',   id: 26 },
                { name: 'C Prog.',     id: 27 },
                { name: 'MDE (OA)',    id: 28 },
                { name: 'AEC (CS)',    id: 29 },
                { name: 'VAC (UHV)',   id: 30 },
            ],
            '2': [
                { name: 'Data Structures', id: 3  },
                { name: 'Digital Logic',   id: 4  },
            ],
            '3': [
                { name: 'OS',          id: 31 },
                { name: 'DS using C',  id: 32 },
                { name: 'DBMS',        id: 33 },
                { name: 'COA',         id: 34 },
                { name: 'Oracle Lab',  id: 35 },
                { name: 'DS Pract.',   id: 36 },
            ],
            '4': [
                { name: 'Software Engineering', id: 7 },
                { name: 'Computer Networks',    id: 8 },
            ],
            '5': [
                { name: 'S.E-I',           id: 37 },
                { name: 'Comp. Graphics',  id: 38 },
                { name: 'GUI',             id: 39 },
                { name: 'E-Com & E-Gov',   id: 40 },
                { name: 'Mini Project',    id: 41 },
                { name: 'VB.NET',          id: 42 },
            ],
            '6': [
                { name: 'Cloud Computing',       id: 11 },
                { name: 'Mobile App Development',id: 12 },
            ],
        }
        // Add other departments here as needed
    };

    // ── Config per role ───────────────────────────────────────────────────
    const config = {
        Teacher: {
            label:       'Teacher Username',
            placeholder: 'e.g. teacher@hatim.local',
            btn:         'Sign Up as Teacher',
            subjectHint: 'Select all subjects you teach'
        },
        Student: {
            label:       'Student Username',
            placeholder: 'e.g. student@hatim.local',
            btn:         'Sign Up as Student',
            subjectHint: 'Select all subjects you are enrolled in'
        }
    };

    // ── Selected subjects state ───────────────────────────────────────────
    let selectedSubjects = []; // array of { name, id, sem }

    // ══════════════════════════════════════════════════════════════════════
    //  Multi-Subject Picker Logic
    // ══════════════════════════════════════════════════════════════════════

    /** Build the dropdown items list */
    function buildSubjectList(filterText = '') {
        const dept = departmentSelect.value;
        const sem  = semesterSelect.value;
        const role = currentRole();
        const deptData = subjectsByDeptSem[dept];

        subjectList.innerHTML = '';

        if (!dept) {
            subjectList.innerHTML = '<div class="subject-empty">Please select a department first.</div>';
            return;
        }
        if (!deptData) {
            // Non-BCA dept – generic single entry
            const genericItems = [{ name: 'General Subject', id: 0 }];
            renderItems(genericItems, null, filterText);
            return;
        }

        // Which semesters to show?
        let semGroups;
        if (role === 'Teacher') {
            semGroups = Object.entries(deptData); // all semesters
        } else {
            // Student: only their selected semester
            semGroups = sem ? [[sem, deptData[sem] || []]] : [];
            if (!sem) {
                subjectList.innerHTML = '<div class="subject-empty">Please select a semester first.</div>';
                return;
            }
        }

        let anyVisible = false;
        semGroups.forEach(([semNo, subs]) => {
            const filtered = subs.filter(s => s.name.toLowerCase().includes(filterText.toLowerCase()));
            if (filtered.length === 0) return;
            anyVisible = true;

            // Group header (only for teachers who see multiple semesters)
            if (role === 'Teacher') {
                const hdr = document.createElement('div');
                hdr.className = 'subject-group-header';
                hdr.textContent = `Semester ${semNo}`;
                subjectList.appendChild(hdr);
            }

            filtered.forEach(sub => {
                const isChecked = selectedSubjects.some(s => s.id === sub.id && s.name === sub.name);
                const item = document.createElement('div');
                item.className = `subject-item${isChecked ? ' checked' : ''}`;
                item.dataset.id   = sub.id;
                item.dataset.name = sub.name;
                item.dataset.sem  = semNo;
                item.setAttribute('role', 'option');
                item.setAttribute('aria-selected', isChecked);
                item.innerHTML = `
                    <div class="subject-checkbox"><i class='bx bx-check'></i></div>
                    <span class="subject-item-label">${sub.name}</span>
                    ${role === 'Teacher' ? `<span class="subject-item-sem">Sem ${semNo}</span>` : ''}
                `;
                item.addEventListener('click', () => toggleSubject(sub, parseInt(semNo), item));
                subjectList.appendChild(item);
            });
        });

        if (!anyVisible) {
            subjectList.innerHTML = '<div class="subject-empty">No subjects match your search.</div>';
        }
    }

    /** Toggle a subject on/off */
    function toggleSubject(sub, semNo, itemEl) {
        const idx = selectedSubjects.findIndex(s => s.id === sub.id && s.name === sub.name);
        if (idx > -1) {
            selectedSubjects.splice(idx, 1);
            itemEl.classList.remove('checked');
            itemEl.setAttribute('aria-selected', 'false');
        } else {
            selectedSubjects.push({ ...sub, sem: semNo });
            itemEl.classList.add('checked');
            itemEl.setAttribute('aria-selected', 'true');
        }
        renderTags();
    }

    /** Render selected tags inside the trigger button */
    function renderTags() {
        // Remove existing tags (keep icon and placeholder)
        subjectTrigger.querySelectorAll('.subject-tag').forEach(t => t.remove());

        if (selectedSubjects.length === 0) {
            subjectPlaceholder.style.display = '';
            subjectCountBadge.style.display  = 'none';
        } else {
            subjectPlaceholder.style.display = 'none';
            subjectCountBadge.style.display  = '';
            subjectCountBadge.textContent    = selectedSubjects.length;

            // Insert tags before the chevron
            selectedSubjects.forEach(sub => {
                const tag = document.createElement('span');
                tag.className = 'subject-tag';
                tag.innerHTML = `${sub.name}<span class="subject-tag-remove" data-id="${sub.id}" data-name="${sub.name}" title="Remove"><i class='bx bx-x'></i></span>`;
                subjectTrigger.insertBefore(tag, subjectChevron);
            });

            // Remove-tag click handlers
            subjectTrigger.querySelectorAll('.subject-tag-remove').forEach(btn => {
                btn.addEventListener('click', e => {
                    e.stopPropagation();
                    const id   = parseInt(btn.dataset.id);
                    const name = btn.dataset.name;
                    selectedSubjects = selectedSubjects.filter(s => !(s.id === id && s.name === name));
                    renderTags();
                    buildSubjectList(subjectSearch.value);
                });
            });
        }
    }

    /** Select / deselect all visible items */
    function handleSelectAll() {
        const allItems = [...subjectList.querySelectorAll('.subject-item')];
        const allChecked = allItems.every(i => i.classList.contains('checked'));

        if (allChecked) {
            // Deselect all visible
            allItems.forEach(item => {
                const id   = parseInt(item.dataset.id);
                const name = item.dataset.name;
                selectedSubjects = selectedSubjects.filter(s => !(s.id === id && s.name === name));
                item.classList.remove('checked');
            });
        } else {
            // Select all visible that aren't already selected
            allItems.forEach(item => {
                const id   = parseInt(item.dataset.id);
                const name = item.dataset.name;
                const sem  = parseInt(item.dataset.sem);
                if (!selectedSubjects.find(s => s.id === id && s.name === name)) {
                    selectedSubjects.push({ id, name, sem });
                }
                item.classList.add('checked');
            });
        }
        renderTags();
    }

    /** Open / close dropdown */
    function openDropdown() {
        subjectDropdown.classList.add('open');
        subjectTrigger.classList.add('open');
        subjectChevron.classList.add('rotated');
        subjectTrigger.setAttribute('aria-expanded', 'true');
        subjectSearch.focus();
        buildSubjectList();
    }
    function closeDropdown() {
        subjectDropdown.classList.remove('open');
        subjectTrigger.classList.remove('open');
        subjectChevron.classList.remove('rotated');
        subjectTrigger.setAttribute('aria-expanded', 'false');
    }

    // Trigger toggle
    subjectTrigger.addEventListener('click', e => {
        if (e.target.closest('.subject-tag-remove')) return; // handled above
        subjectDropdown.classList.contains('open') ? closeDropdown() : openDropdown();
    });
    subjectTrigger.addEventListener('keydown', e => {
        if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); openDropdown(); }
    });

    // Close on outside click
    document.addEventListener('click', e => {
        if (!subjectTrigger.contains(e.target) && !subjectDropdown.contains(e.target)) {
            closeDropdown();
        }
    });

    // Live search filter
    subjectSearch.addEventListener('input', () => buildSubjectList(subjectSearch.value));

    // Select all
    selectAllBtn.addEventListener('click', handleSelectAll);

    // Rebuild on dept / sem change
    departmentSelect.addEventListener('change', () => {
        selectedSubjects = [];
        renderTags();
        buildSubjectList();
    });
    semesterSelect.addEventListener('change', () => {
        selectedSubjects = [];
        renderTags();
        buildSubjectList();
    });

    // ══════════════════════════════════════════════════════════════════════
    //  Role switching
    // ══════════════════════════════════════════════════════════════════════

    function currentRole() {
        return document.querySelector('.role-btn.active')?.dataset.role || 'Teacher';
    }

    function setRole(role) {
        roleBtns.forEach(btn => btn.classList.toggle('active', btn.dataset.role === role));

        const conf = config[role] || config.Teacher;
        emailLabel.textContent = conf.label;
        emailInput.placeholder = conf.placeholder;
        submitBtn.innerHTML    = `<i class='bx bx-user-plus'></i> ${conf.btn}`;
        document.getElementById('subjectHint').innerHTML =
            `<i class='bx bx-info-circle'></i> ${conf.subjectHint}`;

        const isStudent = role === 'Student';

        semesterGroup.style.display  = isStudent ? 'block' : 'none';
        semesterSelect.required      = isStudent;
        if (!isStudent) semesterSelect.value = '';

        rollNoGroup.style.display    = isStudent ? 'block' : 'none';
        studentIdGroup.style.display = isStudent ? 'block' : 'none';
        rollNoInput.required         = isStudent;
        studentIdInput.required      = isStudent;
        if (!isStudent) { rollNoInput.value = ''; studentIdInput.value = ''; }

        // Reset subjects
        selectedSubjects = [];
        renderTags();
        closeDropdown();
        buildSubjectList();
    }

    roleBtns.forEach(btn => btn.addEventListener('click', e => {
        e.preventDefault();
        setRole(btn.dataset.role);
    }));

    // ══════════════════════════════════════════════════════════════════════
    //  Password toggle
    // ══════════════════════════════════════════════════════════════════════
    togglePwd.addEventListener('click', function () {
        const type = pwdInput.getAttribute('type') === 'password' ? 'text' : 'password';
        pwdInput.setAttribute('type', type);
        this.classList.toggle('bx-show');
        this.classList.toggle('bx-hide');
    });

    if (toggleConfirmPwd) {
        toggleConfirmPwd.addEventListener('click', function () {
            const type = confirmPwdInput.getAttribute('type') === 'password' ? 'text' : 'password';
            confirmPwdInput.setAttribute('type', type);
            this.classList.toggle('bx-show');
            this.classList.toggle('bx-hide');
        });
    }

    // ══════════════════════════════════════════════════════════════════════
    //  Form submit
    // ══════════════════════════════════════════════════════════════════════
    signupForm.addEventListener('submit', async e => {
        e.preventDefault();
        const role      = currentRole();
        const isStudent = role === 'Student';

        if (pwdInput.value !== confirmPwdInput.value) {
            alert('Passwords do not match. Please try again.');
            confirmPwdInput.focus();
            return;
        }

        // ── Validate ──
        if (isStudent) {
            if (!semesterSelect.value) {
                alert('Please select your Semester.'); semesterSelect.focus(); return;
            }
            if (!rollNoInput.value.trim()) {
                alert('Please enter your Roll No (Class Roll No).'); rollNoInput.focus(); return;
            }
            if (!studentIdInput.value.trim()) {
                alert('Please enter your Student ID (Admission No.).'); studentIdInput.focus(); return;
            }
        }
        if (selectedSubjects.length === 0) {
            alert('Please select at least one subject.');
            openDropdown();
            return;
        }

        submitBtn.innerHTML = `<i class='bx bx-loader-alt bx-spin'></i> Creating account…`;
        submitBtn.style.opacity = '0.8';
        submitBtn.disabled = true;

        const payload = {
            fullName:      fullNameInput.value.trim(),
            email:         emailInput.value.trim(),
            password:      pwdInput.value,
            role,
            institutionId: 1,                                       // HATIM
            departmentId:  parseInt(departmentSelect.value) || 0,
            semester:      isStudent ? semesterSelect.value : null,
            subjects:      selectedSubjects,                        // array of { name, id, sem }
            // Student-specific
            rollNo:        isStudent ? rollNoInput.value.trim()    : null,
            studentId:     isStudent ? studentIdInput.value.trim() : null,
        };

        try {
            const res  = await fetch('signup.php', {
                method:  'POST',
                headers: { 'Content-Type': 'application/json' },
                body:    JSON.stringify(payload)
            });
            const data = await res.json();

            if (data.success) {
                alert('Account created successfully! You can now login.');
                window.location.href = 'index.html';
            } else {
                alert('Signup failed: ' + data.message);
            }
        } catch (err) {
            console.error(err);
            alert('An error occurred. Make sure XAMPP / Apache is running.');
        } finally {
            const conf = config[role] || { btn: `Sign Up as ${role}` };
            submitBtn.innerHTML = `<i class='bx bx-user-plus'></i> ${conf.btn}`;
            submitBtn.style.opacity = '1';
            submitBtn.disabled = false;
        }
    });

    // ── Init ──
    setRole('Teacher');
});
