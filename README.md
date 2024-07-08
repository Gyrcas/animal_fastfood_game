# animal fastfood game

## Interesting things
### 3d mesh previewer
In Godot, if you want to do a preview, there isn't a lot of different ways to do it. You can use the official method, which they use for the preview of assets in the editor. Or you can use the method that a lot of creator, including myself, use because it is simpler.

You create a viewport with its own 3d space and a camera. Put your camera at an angle to showcase your meshes. After that, you instantiate the mesh and copy the viewport texture to a normal texture. You can then free the mesh. You might need to add multiple await to let the viewport instantiate and free the mesh.

You can find this technique in:
- scripts/singletons/MeshPreview.gd
- scenes/mesh_preview_viewport.tscn
