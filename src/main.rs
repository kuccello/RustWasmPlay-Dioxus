// main.rs

use dioxus::prelude::*;

fn main() {
    dioxus::web::launch(app);
}

fn app(cx: Scope) -> Element {
    cx.render(rsx!{
        div {
            class: "text-xl font-bold text-blue-500",
            "hello, wasm! It works!"
        }
        div {
            class: "text-xl font-bold text-green-500",
            "Another?"
        }
    })
}
