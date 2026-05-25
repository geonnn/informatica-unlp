# Ejercicio 3: Iteradores circulares bis
Se cuenta con las siguientes implementaciones de iteradores circulares, las cuales presentan implementaciones similares.

**CharRing.java**
```java
public class CharRing {
	private char[] source;
	private int idx;
	public CharRing(String src) {
		source = src.toCharArray();
		idx = 0;
	}
	public char next() {
		if (idx >= source.length)
		idx = 0;
		return source[idx++];
	}
}
```

**IntRing.java**
```java
public class IntRing {
    private int[] source;
    private int idx;
    public IntRing(int[] src) {
        source = src;
        idx = 0;
    }
	public int next() {
	    if (idx >= source.length)
	        idx = 0;
		return source[idx++];
	}
}
```
**Tareas:​**
1) Diseñe e implemente Test de Unidad para las clases CharRing e IntRing. Asegúrese de que los test pasen.
2) Aplique el refactoring Extract Superclass. Detalle cada uno de los pasos intermedios que son necesarios para poder aplicar correctamente este refactoring.
3) Verifique que los tests definidos en el paso 1 sigan funcionando correctamente.
4) Realice un diagrama de clases UML con el diseño refactorizado.

## 1)
#### CharRingTest.java
```java
package objetosdos;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CharRingTest {
    CharRing cr;

    @Test
    public void testNext() {
        cr = new CharRing("ring");
        assertEquals('r', cr.next());
        assertEquals('i', cr.next());
        assertEquals('n', cr.next());
        assertEquals('g', cr.next());
        assertEquals('r', cr.next());
    }
}

```

#### IntRingTest.java
```java
package objetosdos;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class IntRingTest {
    IntRing ir;

    @Test
    public void testNext() {
        ir = new IntRing(new int[] {1, 2, 3});
        assertEquals(1, ir.next());
        assertEquals(2, ir.next());
        assertEquals(3, ir.next());
        assertEquals(1, ir.next());
    }
}
```

## 2)
#### *Extract superclass*
>*You have two classes with similar features.*
>*Create a superclass and move the common features to the superclass.*

**Extract superclass paso 1:**
>*Create a blank abstract superclass; make the original classes subclasses of this superclass.*

**Extract superclass paso 2:**
>*One by one, use Pull Up Field, Pull Up Method, and Pull Up Constructor Body to move common elements to the superclass.*

##### *Pull up field (`int idx`)*
>*Two subclasses have the same field.*
>*Move the field to the superclass.*

**Pull up field paso 1:**
>*Inspect all uses of the candidate fields to ensure they are used in the same way.*

Sí, se usan en ambos casos como un índice.

**Pull up field paso 2:**
>*If the fields do not have the same name, rename the fields so that they have the name you want to use for the superclass field.*

Tienen el mismo nombre.

**Pull up field paso 3:**
>*Compile and test.* ✅

**Pull up field paso 4:**
>*Create a new field in the superclass.*
```java
package objetosdos;

public abstract class Ring {
    private int idx;
}
```

**Pull up field paso 5:**
>*Delete the subclass fields.*

**Pull up field paso 6:**
>*Compile and test.* ✅

**Pull up field paso 7:**
>*Consider using Self Encapsulate Field on the new field.*

**Resultado:**

**Ring.java**
```java
package objetosdos;

public abstract class Ring {
    private int idx;
}
```

**CharRing.java**
```java
public class CharRing extends Ring {
	private char[] source;
	public CharRing(String src) {
		source = src.toCharArray();
		idx = 0;
	}
	public char next() {
		if (idx >= source.length)
			idx = 0;
		return source[idx++];
	}
}
```

**IntRing.java**
```java
public class IntRing extends Ring {
    private int[] source;
    public IntRing(int[] src) {
        source = src;
        idx = 0;
    }
	public int next() {
	    if (idx >= source.length)
	        idx = 0;
		return source[idx++];
	}
}
```
##### *Pull up method (`next()`)*
>*You have methods with identical results on subclasses.*
>*Move them to the superclass.*

**Pull up method paso 1:**
>*Inspect the methods to ensure they are identical.*

Sí, el comportamiento es idéntico.

**Pull up method paso 2:**
>*If the methods have different signatures, change the signatures to the one you want to use in the superclass.*

Varían sólo en el tipo de dato que devuelven.
Sobre *pull up method* Fowler dice: *If you have two methods that are similar but not the same, you may be able to use Form
Template Method.* 
Como no son exactamente idénticos, paso a aplicar *Form template method*.

##### *Form template method*
>*You have two methods in subclasses that perform similar steps in the same order, yet the steps are different.
>Get the steps into methods with the same signature, so that the original methods become the same. Then you can pull them up.*

**Form template method paso 1:**
>*Decompose the methods so that all the extracted methods are either identical or completely different.*

Aplico *Extract method* para extraer la lógica común del método `next()`.
```java
	public int next() {
		if (idx >= source.length)
			idx = 0;
		return source[idx++];
	}
```

```java
    public int next() {
        return source[getIndex()];
    }
    
    private int getIndex() {
	    if (idx >= source.length)
		    idx = 0;
		return idx++;
    }
```

**Form template method paso 2:**
>*Use Pull Up Method to pull the identical methods into the superclass.*

El método `getIndex()` sube a la superclase `Ring` como protected para que las clases que heredan puedan conocerlo.
```java
package objetosdos;

public abstract class Ring {
    protected int idx;

    protected int getIndex() {
        if (idx >= source.length)
            idx = 0;
        return idx++;
    }
}
```

```java
package objetosdos;

public class CharRing extends Ring {
    private char[] source;
    
    public CharRing(String src) {
        source = src.toCharArray();
        idx = 0;
    }
    
    public char next() {
        return source[getIndex()];
    }
}
```

```java
package objetosdos;

public class IntRing extends Ring {
    private int[] source;
    
    public IntRing(int[] src) {
        source = src;
        idx = 0;
    }
    
    public int next() {
        return source[getIndex()];
    }
}
```
Esto por sí mismo no funcionaría porque la clase `Ring` no conoce la variable `source`, pero Fowler escribe lo siguiente sobre *Pull up method*:
>*If the method uses a subclass field, use Pull Up Field or Self Encapsulate Field and declare and use an abstract getting method.*

Entonces aplico para `source`:
```java
package objetosdos;

public abstract class Ring {
    protected int idx;

	protected abstract int getSourceLength();

    protected int nextIndex() {
        if (idx >= this.getSourceLength())
            idx = 0;
        return idx++;
    }
}
```

Y lo implemento en las clases concretas:
```java
package objetosdos;

public class CharRing extends Ring {
    private char[] source;
    
    public CharRing(String src) {
        source = src.toCharArray();
        idx = 0;
    }
    
    public char next() {
        return source[nextIndex()];
    }
    
    @Override
    protected int getSourceLength() {
	    return source.length;
    }
}
```

```java
package objetosdos;

public class IntRing extends Ring {
    private int[] source;
    
    public IntRing(int[] src) {
        source = src;
        idx = 0;
    }
    
    public int next() {
        return source[nextIndex()];
    }
    
    @Override
	protected int getSourceLength() {
		return source.length;
    }
}
```

**Form template method paso 3:**
>*For the different methods use Rename Method so the signatures for all the methods at each step are the same.*

**Form template method paso 4:**
>*Compile and test after each signature change.* ✅

**Form template method paso 5:**
>*Use Pull Up Method on one of the original methods. Define the signatures of the different methods as abstract methods on the superclass.* **<-- ¿?**

**Form template method paso 6:**
>*Compile and test.* ✅

**Form template method paso 7:**
>*Remove the other methods, compile, and test after each removal.* **<-- ¿?**

##### *Pull up constructor*
>*You have constructors on subclasses with mostly identical bodies.*
>*Create a superclass constructor; call this from the subclass methods.*

**Pull up constructor paso 1:**
>*Define a superclass constructor.*

**Pull up constructor paso 2:**
>*Move the common code at the beginning from the subclass to the superclass constructor.*

**Pull up constructor paso 3:**
>*Call the superclass constructor as the first step in the subclass constructor.*

La lógica de inicialización del índice `idx = 0` sube a la superclase.
```java
package objetosdos;

public abstract class Ring {
    protected int idx;

    protected Ring() {
        idx = 0;
    }

    protected abstract int getSourceLength();

    protected int nextIndex() {
        if (idx >= getSourceLength())
            idx = 0;
        return idx++;
    }
}
```

```java
package objetosdos;

public class CharRing extends Ring {
    private char[] source;

    public CharRing(String src) {
        super();
        source = src.toCharArray();
    }

    public char next() {
        return source[nextIndex()];
    }

    @Override
    protected int getSourceLength() {
        return source.length;
    }
}
```

```java
package objetosdos;

public class IntRing extends Ring {
    private int[] source;

    public IntRing(int[] src) {
        super();
        source = src;
    }

    public int next() {
        return source[nextIndex()];
    }

    @Override
    protected int getSourceLength() {
        return source.length;
    }
}
```

**Pull up constructor paso 4:**
>*Compile and test.* ✅

####
**Extract superclass paso 3:**
>*Compile and test after each pull.*

**Extract superclass paso 4:**
>*Examine the methods left on the subclasses. See if there are common parts, if there are you can use Extract Method followed by Pull Up Method on the common parts. If the overall flow is similar, you may be able to use Form Template Method.*

Los métodos concretos `next()` y `getSourceLength()` de las subclases son idénticos, pero operan sobre la variable `source` que varía por el tipo (una es `char[]` y la otra `int[]`).
Esto se podría mejorar usando tipos genéricos `T` (pero no sé si se incluye en el scope de la materia o si es la resolución que esperan).

**Extract superclass paso 5:**
>*After pulling up all the common elements, check each client of the subclasses. If they use only the common interface you can change the required type to the superclass.*

## 4)
![[ejercicio03_uml.png]]