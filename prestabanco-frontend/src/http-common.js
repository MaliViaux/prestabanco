import axios from "axios";

const PrestaBancoServer = import.meta.env.VITE_PRESTABANCO_SERVER;

console.log(PrestaBancoServer)
console.log(PrestaBancoPort)

export default axios.create({
    baseURL: `http://${PrestaBancoServer}`,
    headers: {
        'Content-Type': 'application/json'
    }
});