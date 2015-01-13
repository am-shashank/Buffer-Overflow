all: attack

attack: badbuf badbuf_dummy
        gcc -fno-stack-protector -z execstack badbuf.c -o badbuf;
        gcc -ggdb badbuf_dummy.c -o badbuf_dummy;
        ./badbuf_dummy | python generate_input.py > input;
        (cat input; cat) | ./badbuf

clean:
        rm -rf *o badbuf badbuf_dummy
