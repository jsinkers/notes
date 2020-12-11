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

## Transformations

### Homogeneous coordinates

- in order to do matrix translations, an additional coordinate is needed
- the homogeneous coordinate $w$ is added as a component of the vector
- the 3D vector is derived by dividing the $x,y,z$ components by $w$, but usually $w = 1$, so no conversion is required
- if $w$ is 0, the vector is a _direction vector_ as it cannot be translated

### Scaling

Scaling by $(S_1, S_2, S_3)$ on a vector $(x,y,z)$ can be done with the following matrix:

$$
\begin{bmatrix}
  S_1 & 0 & 0 & 0 \\
  0 & S_2 & 0 & 0 \\
  0 & 0 & S_3 & 0 \\
  0 & 0 & 0 & 1 \\
\end{bmatrix}
\cdot
\begin{bmatrix}
  x \\
  y \\
  z \\
  1 \\
\end{bmatrix}
= 
\begin{bmatrix}
  S_1x \\
  S_2y \\
  S_3z \\
  1 \\
\end{bmatrix}
$$

### Translation

- translation of a vector by $(T_x, T_y, T_z)$ can be achieved with the following matrix:
$$
\begin{bmatrix}
  1 & 0 & 0 & T_x \\
  0 & 1 & 0 & T_y \\
  0 & 0 & 1 & T_z \\
  0 & 0 & 0 & 1 \\
\end{bmatrix}
\cdot
\begin{bmatrix}
  x \\
  y \\
  z \\
  1 \\
\end{bmatrix}
= 
\begin{bmatrix}
  x + T_x \\
  y + T_y \\
  z + T_z \\
  1 \\
\end{bmatrix}
$$

### Rotations

- specified with an angle and a rotation axis
- rotation about the $x$-axis:

$$
\begin{bmatrix}
  1 & 0 & 0 & 0 \\
  0 & \cos \theta & -\sin \theta & 0 \\
  0 & \sin \theta0 & \cos \theta & 0 \\
  0 & 0 & 0 & 1 \\
\end{bmatrix}
\cdot
\begin{bmatrix}
  x \\
  y \\
  z \\
  1 \\
\end{bmatrix}
= 
\begin{bmatrix}
  x \\
  \cos\theta y - \sin\theta z\\
  \sin\theta y + \cos\theta z\\
  1 \\
\end{bmatrix}
$$

- there are similar matrices around the other axes
- by combining these matrices you can achieve arbitrary rotations
  - __gimbal lock__ is possible using this approach, can be avoided by quaternions
