let authHeader = '';

function showSection(id) {
    document.querySelectorAll('section').forEach(s => s.classList.remove('active'));
    document.getElementById(id).classList.add('active');
}

function login(e) {
    e.preventDefault();
    const u = document.getElementById('login-email').value;
    const p = document.getElementById('login-pass').value;
    authHeader = 'Basic ' + btoa(u + ':' + p);
    alert('Login OK');
    showSection('section-list');
    loadOrders();
}

async function loadOrders() {
    const res = await fetch('/api/pedidos', { headers: { 'Authorization': authHeader } });
    if (res.status !== 200) return alert('Error ' + res.status);
    const lista = await res.json();
    const body = document.getElementById('orders-body');
    body.innerHTML = '';
    lista.forEach(p => {
        const tr = document.createElement('tr');
        const days = (new Date(p.fechaEntregaComprometida) - new Date()) / 86400000;
        if (p.estadoFinal === false && days <= 2) tr.classList.add('alert');
        tr.innerHTML = `
      <td>${p.id}</td>
      <td>${p.descripcion}</td>
      <td>${p.estadoDescripcion}</td>
      <td>${p.fechaSolicitud}</td>
      <td>${p.fechaEntregaComprometida}</td>
    `;
        body.appendChild(tr);
    });
}

async function registerOrder(e) {
    e.preventDefault();
    const dto = {
        descripcionProducto: document.getElementById('reg-desc').value,
        clienteId: +document.getElementById('reg-cliente').value,
        fechaSolicitud: document.getElementById('reg-fecha-s').value,
        fechaEntregaComprometida: document.getElementById('reg-fecha-e').value
    };
    const res = await fetch('/api/pedidos', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Authorization': authHeader },
        body: JSON.stringify(dto)
    });
    alert(res.ok ? 'Pedido registrado' : 'Error ' + res.status);
    loadOrders();
}

async function assignOrder(e) {
    e.preventDefault();
    const dto = {
        pedidoId: +document.getElementById('asg-pedido').value,
        operarioAsignadoId: +document.getElementById('asg-operario').value
    };
    const res = await fetch('/api/pedidos/asignar', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json', 'Authorization': authHeader },
        body: JSON.stringify(dto)
    });
    alert(res.ok ? 'Asignado' : 'Error ' + res.status);
    loadOrders();
}

async function changeState(e) {
    e.preventDefault();
    const dto = {
        pedidoId: +document.getElementById('st-pedido').value,
        nuevoEstadoId: +document.getElementById('st-estado').value
    };
    const res = await fetch('/api/pedidos/cambiar-estado', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json', 'Authorization': authHeader },
        body: JSON.stringify(dto)
    });
    alert(res.ok ? 'Estado actualizado' : 'Error ' + res.status);
    loadOrders();
}

async function confirmDelivery(e) {
    e.preventDefault();
    const dto = { pedidoId: +document.getElementById('del-pedido').value };
    const res = await fetch('/api/pedidos/confirmar-entrega', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json', 'Authorization': authHeader },
        body: JSON.stringify(dto)
    });
    alert(res.ok ? 'Entrega confirmada' : 'Error ' + res.status);
    loadOrders();
}
