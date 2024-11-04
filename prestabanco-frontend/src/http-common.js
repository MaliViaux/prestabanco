import axios from "axios";

console.log(PrestaBancoServer)

export default axios.create({
    baseURL: `http://52.184.141.114`,
    headers: {
        'Content-Type': 'application/json'
    }
});