const axios = require('axios');
const dotenv = require('dotenv');

dotenv.config();

const brasilianSupplier =  process.env.BRASILIAN_SUPPLIER_API_URL;
const europeanSupplier = process.env.EUROPEAN_SUPPLIER_API_URL;

async function fetchProductsFromBrasilianSupplier(){
    const response = await axios.get(brasilianSupplier);
    return response.data.map(product =>({
        id: product.id,
        name: product.nome,
        description: product.descricao,
        price: product.preco,
        material: product.material,
        department: product.departamento,
        gallery: [product.imagem],
    }));
}

async function fetchProductsFromEuropeanSupplier(){
    const response = await axios.get(europeanSupplier);
    return response.data.map(product =>({
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        hasDiscount: product.hasDiscount,
        discountValue:product.discountValue,
        gallery: product.gallery,
        material: product.details.material,
        details: product.details,
    }));
}

async function getAllProducts(){
    const [brasilianProducts, europeanProducts] = await Promise.all([
        fetchProductsFromBrasilianSupplier(),
        fetchProductsFromEuropeanSupplier(),
    ]);

    return [...brasilianProducts, ...europeanProducts];
}

module.exports = {
    getAllProducts,
};
