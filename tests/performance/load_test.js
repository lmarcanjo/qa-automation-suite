import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
    scenarios: {
        read_load: { // Testando o gargalo do GET sem paginação
            executor: 'ramping-vus',
            startVUs: 0,
            stages: [
                { duration: '10s', target: 20 },
                { duration: '20s', target: 20 },
                { duration: '10s', target: 0 },
            ],
            exec: 'testGet',
        },
        write_stress: { // Injetando lixo (400/500) para testar estabilidade do banco
            executor: 'constant-vus',
            vus: 5,
            duration: '40s',
            exec: 'testPost',
        }
    },
    thresholds: {
        'http_req_duration{scenario:read_load}': ['p(95)<3000'],
        'http_req_failed{scenario:write_stress}': ['rate<0.1'],
    },
};

const URL = 'https://restful-booker.herokuapp.com/booking';

export function testGet() {
    const res = http.get(URL, { headers: { 'Accept': 'application/json' } });
    check(res, { 'GET returns 200': (r) => r.status === 200 });
    sleep(1);
}

export function testPost() {
    const payload = JSON.stringify({
        firstname: "Asta", lastname: "Load", totalprice: 100, depositpaid: true,
        bookingdates: { checkin: "2024-01-01", checkout: "2024-01-05" }
    });
    const res = http.post(URL, payload, { headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' } });
    check(res, { 'POST returns 200': (r) => r.status === 200 });
    sleep(1);
}