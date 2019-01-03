// +build ignore

package main

import (
	"html/template"
	"io/ioutil"
	"os"
	"sort"
	"time"

	yaml "gopkg.in/yaml.v2"
)

type templateData struct {
	Time      time.Time
	ErrorInfo []errorInfo
}

type errorInfo struct {
	Code    int64
	Name    string
	Message string
}

func (t templateData) Len() int {
	return len(t.ErrorInfo)
}

func (t templateData) Less(i, j int) bool {
	return t.ErrorInfo[i].Code < t.ErrorInfo[j].Code
}

func (t templateData) Swap(i, j int) {
	t.ErrorInfo[i], t.ErrorInfo[j] = t.ErrorInfo[j], t.ErrorInfo[i]
}

var exeTemplate = template.Must(template.New("").Parse(`
// This file is auto generated.
// Last generation time: {{.Time}}

package dynagatewaytypes

const(
{{- range .ErrorInfo}}
	// {{.Message}}
	DGW_ERROR_{{.Name}} = {{.Code}}
{{- end}}
)

var errorMessages = map[int64]string{
{{- range .ErrorInfo}}
	{{.Code}}: "{{.Message}}",
{{- end}}
}

func ErrorCodeToMessage(code int64) (msg string) {
	msg = errorMessages[code]
	return
}

`))

func main() {
	var err error
	var output string
	var errors []errorInfo
	var errorsFile []byte
	var errorsMap map[int64]map[string]string

	input := os.Args[2]
	output = os.Args[3]

	// Retrieve the error YAML file
	errorsFile, err = ioutil.ReadFile(input)
	if err != nil {
		panic(err)
	}

	// Load up the configuration from the provided yaml file.
	errorsMap = make(map[int64]map[string]string)
	err = yaml.Unmarshal(errorsFile, errorsMap)
	if err != nil {
		panic(err)
	}

	for code, data := range errorsMap {
		errors = append(errors, errorInfo{Code: code, Name: data["name"], Message: data["message"]})
	}

	templData := templateData{
		time.Now(),
		errors,
	}

	sort.Sort(templData)

	f, err := os.Create(output)
	if err != nil {
		panic(err)
	}
	defer f.Close()

	exeTemplate.Execute(f, templData)
}
