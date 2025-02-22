//
//	DO NOT TOUCH THIS!!!
//	AUTOGENERATED FILE BY FM3D-DESIGNER!!!
//
#pragma once
#include <map>
#include <Engine.h>

#define MESH_ALLOSAURUS 0
#define MESH_ARGENTAVIS 1
#define SKELETON_ALLOSAURUS_SKEL 0
#define SKELETON_ARGENTAVIS_SKELETON 1

class Resources {
private:
	std::map<unsigned int, FM3D::Texture*> m_textures;
	std::map<unsigned int, FM3D::Mesh*> m_meshes;
	std::map<unsigned int, FM3D::Model*> m_models;
	std::map<unsigned int, FM3D::Skeleton*> m_skeleton;
	std::map<unsigned int, FM3D::Material*> m_materials;
public:
	inline FM3D::Texture* GetTexture(FM3D::uint id) { return m_textures.at(id); }
	inline FM3D::Mesh* GetMesh(FM3D::uint id) { return m_meshes.at(id); }
	inline FM3D::Model* GetModel(FM3D::uint id) { return m_models.at(id); }
	inline FM3D::Skeleton* GetSkeleton(FM3D::uint id) { return m_skeleton.at(id); }
	inline FM3D::Material* GetMaterial(FM3D::uint id) { return m_materials.at(id); }

	void LoadResources(FM3D::RenderSystem* renderSystem);
};