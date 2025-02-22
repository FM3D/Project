#pragma once
#include <Engine.h>

namespace FM3D {

	class Model;
	class Texture;
	class Shader;

	class ENGINE_DLL RenderSystem {
	public:
		virtual bool Initialize(int screenWidth, int screenHeight, bool vsync, HWND hwnd, bool fullscreen) = 0;
		virtual void BeginRendering(const Color4f& color) = 0;
		virtual void EndRendering() = 0;
		virtual void Shutdown() = 0;

		virtual Mesh* CreateMesh(const Skeleton* skeleton, bool supportsInstancing, const std::vector<MeshPart>& parts) const = 0;
		virtual Texture* CreateTexture(uint width, uint height, Texture::FilterMode filterMode, Texture::WrapMode wrapMode, Texture::MipMapMode mipMapMode, char* pixels, uint bits) = 0;
		virtual Texture* CreateTexture(uint width, uint height, Texture::FilterMode filterMode, Texture::WrapMode wrapMode, Texture::MipMapMode mipMapMode, float* pixels, uint bits) = 0;
		virtual Renderer2D* CreateRenderer2D(const RenderTarget2D* renderTarget) = 0;
		virtual Renderer3D* CreateRenderer3D(Matrix4f& projectionMatrix, uint width, uint height, RenderTarget2D* target) = 0;
		virtual RenderTarget2D* CreateRenderTarget2D(const Vector2i& size, bool useDepth) = 0;

		static RenderSystem* Create(Renderer renderer);
	};
}