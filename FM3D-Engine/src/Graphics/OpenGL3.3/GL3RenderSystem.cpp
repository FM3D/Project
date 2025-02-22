#include <Engine.h>

namespace FM3D {

	bool GL3RenderSystem::Initialize(int screenWidth, int screenHeight, bool vsync, HWND hwnd, bool fullscreen) {
		m_hDevContext = GetDC(hwnd);

		PIXELFORMATDESCRIPTOR pfd;
		ZeroMemory(&pfd, sizeof(PIXELFORMATDESCRIPTOR));
		pfd.nSize = sizeof(PIXELFORMATDESCRIPTOR);
		pfd.nVersion = 1;
		pfd.dwFlags = PFD_DRAW_TO_WINDOW | PFD_SUPPORT_OPENGL | PFD_DOUBLEBUFFER;
		pfd.iPixelType = PFD_TYPE_RGBA;
		pfd.cColorBits = 32;
		pfd.cDepthBits = 24;
		pfd.cStencilBits = 8;
		int format = ChoosePixelFormat(m_hDevContext, &pfd);
		if (!SetPixelFormat(m_hDevContext, format, &pfd))
			throw std::exception();

		m_hGLRenderContext = wglCreateContext(m_hDevContext);
		if (!wglMakeCurrent(m_hDevContext, m_hGLRenderContext))
			throw std::exception();

		if (glewInit())
			throw std::exception();

		typedef BOOL(APIENTRY *PFNWGLSWAPINTERVALPROC)(int);
		PFNWGLSWAPINTERVALPROC wglSwapIntervalEXT = 0;

		GLCall(glEnable(GL_DEPTH_CLAMP));

		const char *extensions = (char*)glGetString(GL_EXTENSIONS);
		bool extensionError = false;

		if (strstr(extensions, "WGL_EXT_swap_control") == 0) {
			extensionError = extensionError || vsync;
		} else {
			wglSwapIntervalEXT = (PFNWGLSWAPINTERVALPROC)wglGetProcAddress("wglSwapIntervalEXT");

			if (wglSwapIntervalEXT)
				wglSwapIntervalEXT(vsync);
		}
		if (strstr(extensions, "GL_ARB_clip_control") == 0) {
			extensionError = true;
		}
		else {
			//GLCall(glClipControl(GL_LOWER_LEFT, GL_ZERO_TO_ONE));
		}

		return !extensionError;
	}

	void GL3RenderSystem::BeginRendering(const Color4f& color) {
		GLCall(glClearColor(color[0], color[1], color[2], color[3]));
		GLCall(glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT));
	}

	void GL3RenderSystem::EndRendering() {
		GLCall(SwapBuffers(m_hDevContext));
	}

	void GL3RenderSystem::Shutdown() {
		//GLCall(wglMakeCurrent(NULL, NULL));
		//GLCall(wglDeleteContext(m_hGLRenderContext));
		//GLCall(ReleaseDC(NULL, m_hDevContext));
	}
}