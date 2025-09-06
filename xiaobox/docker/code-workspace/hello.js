// Hello World in JavaScript
console.log("Hello, XIAOBOX!");

// Variables and operations
const a = 5;
const b = 10;
console.log(`${a} + ${b} = ${a + b}`);

// Array methods
const numbers = [1, 2, 3, 4, 5];
const squares = numbers.map(x => x ** 2);
console.log(`Squares: ${squares}`);

// Function
function greet(name) {
    return `Hello, ${name}!`;
}

console.log(greet("Student"));

// Async example
async function fetchData() {
    try {
        const response = await fetch('https://api.github.com/users/octocat');
        const data = await response.json();
        console.log(data.login);
    } catch (error) {
        console.log('Error:', error);
    }
}

// Uncomment to test:
// fetchData();