---
title: Graphics
notebook: Graphics
layout: note
date: 2020-12-03
tags: 
...

## OpenGL Graphics Pipeline

![Graphics Pipeline](img/pipeline.png)

- input: array of vertices with vertex attributes, e.g. position and colour
- __vertex shader:__ operates on a vertex, transforming between 3D coordinate systems
  - also allows basic processing of vertex attributes
- __primitive assembly:__ receives all vertices from the vertex shader to form a primitive,
  assembling them into the required shape (e.g. triangle)
- __geometry shader:__ receives collection of vertices forming a primitive, and generates new shapes by
  emitting new vertices to form new/other primitives
- __rasterisation:__ maps the primitives to corresponding pixels on the screen, producing fragments
  - clipping is also performed, discarding fragments outside the view
- __fragment shader:__ calculates final colour of a pixel
  - typically contains data about 3D scene allowing calculation of lights, shadows, ...
- __alpha test and blending:__ checks depth of the fragment, and whether the fragment is in front/behind other objects

## Shaders

### Ins and Outs

- `in`/`out` are input/output variables respectively
- vertex shader _should_ receive input in the form of the vertex data (otherwise it can't do much)
- fragment shader _requires_ `vec4` colour output variable

__Vertex Shader__

```c
#version 330 core
// position variable has attribute position 0
layout (location = 0) in vec3 aPos;

// specify colour output to fragment shader
out vec4 vertexColor;

void main() {
    gl_Position = vec4(aPos, 1.0);
    vertexColor = vec4(0.5, 0.0, 0.0, 1.0);
}
```

__Fragment Shader__

```c
#version 330 core
out vec4 FragColor;

// input variable from the vertex shader
in vec4 vertexColor;

void main() {
    FragColor = vertexColor;
}
```

### Uniforms

- `uniform`s are
  - global
  - maintain value until they are reset/updated


## Sources

[Learn OpenGL](https://learnopengl.com)
