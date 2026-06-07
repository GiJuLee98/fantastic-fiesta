#include "IntegrationDialog.h"
#include "SubDialog1.h"
#include "SubDialog2.h"
#include "SubDialogOpenCV.h"
#include <imgui.h>

IntegrationDialog::IntegrationDialog()
    : sub_dialog_1_(std::make_unique<SubDialog1>()),
      sub_dialog_2_(std::make_unique<SubDialog2>()),
      sub_dialog_opencv_(std::make_unique<SubDialogOpenCV>()) {}

void IntegrationDialog::Draw() {
    ImGui::Begin("dlg_integration");
    if (ImGui::BeginTabBar("IntegrationTabBar")) {
        // 첫 실행인지 체크하는 변수
        static bool select_opencv_first = true;

        // 첫 실행일때만 
        ImGuiTabItemFlags opencv_flags = 0;
        if (select_opencv_first) {
            opencv_flags |= ImGuiTabItemFlags_SetSelected;
            select_opencv_first = false;
        }

        if (ImGui::BeginTabItem("sub_dialog_1")) {
            if (sub_dialog_1_) {
                sub_dialog_1_->Draw();
            }
            ImGui::EndTabItem();
        }
        if (ImGui::BeginTabItem("sub_dialog_2")) {
            if (sub_dialog_2_) {
                sub_dialog_2_->Draw();
            }
            ImGui::EndTabItem();
        }
        if (ImGui::BeginTabItem("OpenCV Test", nullptr, opencv_flags)) {
            if (sub_dialog_opencv_) {
                sub_dialog_opencv_->Draw();
            }
            ImGui::EndTabItem();
        }
        ImGui::EndTabBar();
    }
    ImGui::End();
}
