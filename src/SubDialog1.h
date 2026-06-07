#ifndef SUB_DIALOG_1_H
#define SUB_DIALOG_1_H

#include "BaseDialog.h"
#include <imgui.h>

class SubDialog1 : public BaseDialog {
public:
    void Draw() override {
        ImGui::Text("sub_dialog_1");
    }
};

#endif // SUB_DIALOG_1_H
