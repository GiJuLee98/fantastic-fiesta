#ifndef SUB_DIALOG_2_H
#define SUB_DIALOG_2_H

#include "BaseDialog.h"
#include <imgui.h>

class SubDialog2 : public BaseDialog {
public:
    void Draw() override {
        ImGui::Text("sub_dialog_2");
    }
};

#endif // SUB_DIALOG_2_H
