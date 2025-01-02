import * as readline from "readline";
import * as vm from "vm";

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

const context = vm.createContext({
    console,
    process,
});

let debouncedHandler = debounce(handleInput, 100);
let debouncedContent = "";

rl.on("line", input => {
    // TODO: We need to send some command first as we might want to have different kinds
    // of operations coming in here. e.g. Clear repl and run
    if (debouncedContent.length > 0) {
        debouncedContent += "\n";
    }
    debouncedContent += input;
    debouncedHandler(debouncedContent);

    if (input.toLowerCase() === "__node_repl_exit") {
        console.log("Exiting");
        rl.close();
    }
});

function handleInput(input) {
    try {
        const result = vm.runInContext(input, context);
        if (result !== undefined) {
            result.split("\n").forEach(line => console.log(line));
        }
    } catch (ex) {
        console.log("ERROR!");
        console.log("");
        ex?.message?.split("\n").forEach(line => console.log(line));
    }
    debouncedContent = "";
}

/**
 * @param {Function} callback
 * @param {number} wait
 */
export function debounce(callback, wait) {
    let timeoutId = null;
    return (...args) => {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(() => {
            callback.apply(null, args);
        }, wait);
    };
}
