#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "imgui.h"
#include "imgui_impl_glfw.h"
#include "imgui_impl_opengl3.h"
#include <iostream>

// GLFW 에러 콜백 함수
void glfw_error_callback(int error, const char* description) {
    std::cerr << "GLFW Error " << error << ": " << description << std::endl;
}

int main() {
    // 1. GLFW 에러 콜백 설정 및 초기화
    glfwSetErrorCallback(glfw_error_callback);
    if (!glfwInit()) {
        std::cerr << "Failed to initialize GLFW" << std::endl;
        return -1;
    }

    // OpenGL 3.3 Core Profile 설정
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
#ifdef __APPLE__
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
#endif

    // 2. GLFW 윈도우 생성
    GLFWwindow* window = glfwCreateWindow(1280, 720, "Fantastic Fiesta", nullptr, nullptr);
    if (window == nullptr) {
        std::cerr << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    glfwSwapInterval(1); // V-Sync 활성화

    // 3. GLAD 로드 및 OpenGL 함수 포인터 초기화
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        std::cerr << "Failed to initialize GLAD" << std::endl;
        glfwDestroyWindow(window);
        glfwTerminate();
        return -1;
    }

    // 4. ImGui 컨텍스트 생성
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;     // 키보드 컨트롤 활성화
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableGamepad;      // 게임패드 컨트롤 활성화
    
    // 다중 뷰포트(ViewportsEnable) 플래그를 명시적으로 비활성화 유지 (일반 단일 뷰포트 타겟)
    // io.ConfigFlags |= ImGuiConfigFlags_ViewportsEnable;

    // ImGui 테마 설정
    ImGui::StyleColorsDark();

    // 5. GLFW 및 OpenGL3 백엔드 초기화
    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL3_Init("#version 330");

    // 기본 배경색 설정 (Clear Color)
    ImVec4 clear_color = ImVec4(0.45f, 0.55f, 0.60f, 1.00f);

    // 6. 메인 이벤트 루프
    while (!glfwWindowShouldClose(window)) {
        // 이벤트 폴링
        glfwPollEvents();

        // ImGui 새 프레임 시작
        ImGui_ImplOpenGL3_NewFrame();
        ImGui_ImplGlfw_NewFrame();
        ImGui::NewFrame();

        // ImGui 데모 윈도우 표시
        bool show_demo_window = true;
        ImGui::ShowDemoWindow(&show_demo_window);

        // 테스트를 위한 간단한 제어 패널 윈도우
        {
            ImGui::Begin("Fantastic Fiesta Control Panel");
            ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / io.Framerate, io.Framerate);
            ImGui::ColorEdit3("Clear Color", (float*)&clear_color);
            ImGui::End();
        }

        // ImGui 렌더링
        ImGui::Render();
        
        // 렌더링 프레임 버퍼 크기 조회 및 뷰포트 설정
        int display_w, display_h;
        glfwGetFramebufferSize(window, &display_w, &display_h);
        glViewport(0, 0, display_w, display_h);
        
        // 화면 클리어
        glClearColor(clear_color.x * clear_color.w, clear_color.y * clear_color.w, clear_color.z * clear_color.w, clear_color.w);
        glClear(GL_COLOR_BUFFER_BIT);

        // ImGui 드로우 데이터 렌더링
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

        // 화면 버퍼 스왑
        glfwSwapBuffers(window);
    }

    // 7. 자원 정리 및 해제
    ImGui_ImplOpenGL3_Shutdown();
    ImGui_ImplGlfw_Shutdown();
    ImGui::DestroyContext();

    glfwDestroyWindow(window);
    glfwTerminate();

    return 0;
}
