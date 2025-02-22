#include <Engine.h>

namespace FM3D {




	void CompCoords::Initialize(int windowWidth, int windowHeigth) {
		s_matPixelToScreenSpace = Matrix4f::Orthographic(0.0f, (float)windowWidth, (float)windowHeigth, 0.0f, 1.0f, -1.0f);
		s_matScreenSpaceToPixel = Matrix4f::Invert(s_matPixelToScreenSpace);
		Window::GetInstance()->GetSizeChangeSource().AddHandler(&CompCoords::OnSizeChange);
	}

	Matrix4f CompCoords::s_matPixelToScreenSpace = Matrix4f::Identity();
	Matrix4f CompCoords::s_matScreenSpaceToPixel = Matrix4f::Identity();

	Vector2f CompCoords::PixelToScreenSpace(Vector2f &pixel) {
		return (s_matPixelToScreenSpace * Vector3f(pixel, 0.0f)).xy;
	}
	Vector2f CompCoords::ScreenSpaceToPixel(Vector2f &pixel) {
		return (s_matScreenSpaceToPixel * Vector3f(pixel, 0.0f)).xy;
	}

	void CompCoords::OnSizeChange(Window::SizeChangeEvent* sce) {
		s_matPixelToScreenSpace = Matrix4f::Orthographic(0.0f, (float)sce->winNewsize.x, (float)sce->winNewsize.y, 0.0f, 1.0f, -1.0f);
		s_matScreenSpaceToPixel = Matrix4f::Invert(s_matPixelToScreenSpace);
	}

	void CompCoords::ScalePixelToScreenSpace(Vector2f& pixel) {
		pixel.x /= ((float)Window::GetInstance()->GetWidth());
		pixel.y /= ((float)Window::GetInstance()->GetHeight());

		pixel.x *= 2.0f;
		pixel.y *= 2.0f;
	}
}