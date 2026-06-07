#ifndef BASE_DIALOG_H
#define BASE_DIALOG_H

class BaseDialog {
public:
    virtual ~BaseDialog() = default;
    virtual void Draw() = 0;
};

#endif // BASE_DIALOG_H
