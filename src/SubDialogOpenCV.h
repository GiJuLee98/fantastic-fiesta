#ifndef SUB_DIALOG_OPENCV_H
#define SUB_DIALOG_OPENCV_H

#include "BaseDialog.h"
#include <imgui.h>
#include <opencv2/opencv.hpp>

class SubDialogOpenCV : public BaseDialog {
public:
    SubDialogOpenCV() = default;
    ~SubDialogOpenCV() override = default;

    void Draw() override {
        ImGui::Text("OpenCV Version: %s", CV_VERSION);
    }
};

#endif // SUB_DIALOG_OPENCV_H
