package utils;

import haxe.ds.GenericStack;

class Queue<T> {
    private var leftStack: GenericStack<T>;
    private var rightStack: GenericStack<T>;

    public function new() {
        leftStack = new GenericStack<T>();
        rightStack = new GenericStack<T>();
    }

    public function push(v: T) {
        leftStack.add(v);
    }

    function transferValues() {
        while (!leftStack.isEmpty()) {
            rightStack.add(leftStack.pop());
        }
    }

    public function pop(): Null<T> {
        if (!rightStack.isEmpty())
            return rightStack.pop();
        
        transferValues();

        return rightStack.pop();
    }

    public function first(): Null<T> {
        if (!rightStack.isEmpty())
            return rightStack.first();

        transferValues();

        return rightStack.first();
    }

    public function isEmpty(): Bool {
        return leftStack.isEmpty() && rightStack.isEmpty();
    }
}