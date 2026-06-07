#ifndef INTEGRATION_DIALOG_H
#define INTEGRATION_DIALOG_H

#include "BaseDialog.h"
#include <memory>

class IntegrationDialog : public BaseDialog {
public:
    IntegrationDialog();
    ~IntegrationDialog() override = default;

    void Draw() override;

private:
    std::unique_ptr<BaseDialog> sub_dialog_1_;
    std::unique_ptr<BaseDialog> sub_dialog_2_;
    std::unique_ptr<BaseDialog> sub_dialog_opencv_;
};

#endif // INTEGRATION_DIALOG_H
