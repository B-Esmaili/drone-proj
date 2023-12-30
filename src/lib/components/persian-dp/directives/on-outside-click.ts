
function isChildOf(el : HTMLElement , child : HTMLElement | null){
    if (!el || !child){
        return false;
    }
    
    let parent : HTMLElement | null = child;
    
    while (parent !== el){
        if (parent === null || parent === document.body){
            return false;
        }
        parent = parent.parentElement;
    }

    return true;
}


export function clickOutside(
    element : HTMLElement , {
        callback, ignoreList
    } :{callback : ()=>void , ignoreList : (HTMLElement | null)[]}
    ) {
    function onClick(event: MouseEvent | null) {
        if (event?.target && !isChildOf(element, event.target as HTMLElement)
        && (!ignoreList || (ignoreList && !ignoreList.includes(event.target as HTMLElement)))) {
            callback();
        }
    }

    document.addEventListener('click', onClick);

    return {
        update(newCallbackFunction: () => void) {
            callback = newCallbackFunction;
        },
        destroy() {
            document.removeEventListener('click', onClick);
        }
    }
}
