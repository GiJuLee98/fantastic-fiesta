#include "IntegrationDialog.h"
#include "SubDialog1.h"
#include "SubDialog2.h"
#include <imgui.h>

IntegrationDialog::IntegrationDialog()
    : sub_dialog_1_(std::make_unique<SubDialog1>()),
      sub_dialog_2_(std::make_unique<SubDialog2>()) {}

void IntegrationDialog::Draw() {
    ImGui::Begin("dlg_integration");
    if (ImGui::BeginTabBar("IntegrationTabBar")) {
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
        ImGui::EndTabBar();
    }
    ImGui::End();
}
