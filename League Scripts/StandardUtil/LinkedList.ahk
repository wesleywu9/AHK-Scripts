class LinkedList {
    class Node { 
        __New(data:="") {
            this.data := data
            this.next := ""
        }
    }
    
    __New(arr:="") {
        this.root := ""
        this.size := 0
        loop % arr.Length() {
            this.add(arr[arr.Length()-A_Index+1])
        }
    }

    Length() {
        return this.size
    }

    get(index:=1) {
        curr := this.root
        i := 1
        while i<index {
            curr := curr.next
            i += 1
        }
        return curr.data
    }

    add(data) {
        if this.root == ""
            this.root := new this.Node(data)
        else {
            addMe := new this.Node(data)
            addMe.next := this.root
            this.root := addMe
        }
        this.size += 1
    }

    pop() {
        if this.size == 0
            return ""
        popMe := this.root.data
        this.root := this.root.next
        this.size -= 1
        return popMe
    }

    clear() {
        this.root := ""
        this.size := 0
    }

    print(){
        str := ""
        curr := this.root
        while curr != "" {
            str .= curr.data . ", "
            curr := curr.next
        }
        str .= "`r`nsize = " . this.size
        msgbox % str
    }
}
