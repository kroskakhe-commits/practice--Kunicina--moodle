import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
  vus: 10,           // 10 виртуальных пользователей (одновременных)
  duration: '30s'    // тест длится 30 секунд
};

export default function () {
  http.get('http://localhost:8080/');   // обращаемся к главной странице Moodle
  sleep(1);                              // ждём 1 секунду между запросами
}