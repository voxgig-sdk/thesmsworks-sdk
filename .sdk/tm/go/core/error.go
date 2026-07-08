package core

type ThesmsworksError struct {
	IsThesmsworksError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewThesmsworksError(code string, msg string, ctx *Context) *ThesmsworksError {
	return &ThesmsworksError{
		IsThesmsworksError: true,
		Sdk:              "Thesmsworks",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *ThesmsworksError) Error() string {
	return e.Msg
}
