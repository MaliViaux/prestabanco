import axios from "axios";

export default axios.create({
    baseURL: `http://52.184.141.114`,
    headers: {
        'Content-Type': 'application/json'
    }
});