import * as readline from "readline";
import * as vm from "vm";

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

let context = createContext();

function createContext(existing) {
    return vm.createContext({
        console,
        process,
        ...existing,
    });
}

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

function handleInput(input, reRunCount = 0) {
    try {
        const result = vm.runInContext(input, context);
        if (result !== undefined) {
            result.split("\n").forEach(line => console.log(line));
        }
    } catch (ex) {
        const declarationErrorMatch = /Identifier '(.*)' has already been declared/.exec(ex?.message);
        if (declarationErrorMatch && reRunCount < 5) {
            const variable = declarationErrorMatch[1];

            delete context[variable];
            context = createContext(context);

            handleInput(input, reRunCount + 1);
            return;
        }
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
