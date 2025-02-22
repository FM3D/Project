#pragma once
#include <memory>
#ifdef NO_FM3D
namespace FM3D {
	class RenderSystem;
	class Window;
	class RenderTarget2D;
	class Renderer3D;
	class Model;
	class Mesh;
	class Texture;
	class Material;
	class Skeleton;
	namespace EntitySystem {
		class EntityCollection;
		class Entity;
		using EntityPtr = std::shared_ptr<Entity>;
} }
#else
#include <Engine.h>
#endif
#include <vector>

namespace DesignerLib {

	class InternOpenGL {
	private:
		HINSTANCE m_hInst;

		unsigned int m_width;
		unsigned int m_height;

		std::unique_ptr<FM3D::RenderSystem> m_renderSystem;
		std::unique_ptr<FM3D::Window> m_window;
		std::unique_ptr<FM3D::RenderTarget2D> m_renderTarget;
		std::unique_ptr<FM3D::Renderer3D> m_renderer;
		std::unique_ptr<FM3D::EntitySystem::EntityCollection> m_collection;
		FM3D::EntitySystem::EntityPtr m_entity;
		FM3D::Camera* m_camera;
		FM3D::Mesh* m_mesh;
		FM3D::Model* m_model;
		FM3D::Texture* m_emptyTex;
		FM3D::Material* m_emptyMat;
	public:
		InternOpenGL(HINSTANCE hInst);
		~InternOpenGL();

		FM3D::Model* Initialize(double width, double height, FM3D::Camera* cam, std::vector<FM3D::MeshPart*>& parts, FM3D::Skeleton* skeleton);
		void ChangeSize(double width, double height);
		void Update(float x, float y, float z, float rx, float ry, float rz, float sx, float sy, float sz);
		std::vector<unsigned char> Render();

		inline unsigned int GetWidth() const { return m_width; }
		inline unsigned int GetHeight() const { return m_height; }
	};
}