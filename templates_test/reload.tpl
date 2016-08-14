{{- $tableNameSingular := .Table.Name | singular | titleCase -}}
{{- $tableNamePlural := .Table.Name | plural | titleCase -}}
{{- $varNamePlural := .Table.Name | plural | camelCase -}}
{{- $varNameSingular := .Table.Name | singular | camelCase -}}
func Test{{$tableNamePlural}}Reload(t *testing.T) {
  t.Parallel()

  {{$varNameSingular}} := &{{$tableNameSingular}}{}
  if err := boil.RandomizeStruct({{$varNameSingular}}, {{$varNameSingular}}DBTypes, true, {{$varNameSingular}}ColumnsWithDefault...); err != nil {
    t.Errorf("Unable to randomize {{$tableNameSingular}} slice: %s", err)
  }

  tx, err := boil.Begin()
  if err != nil {
    t.Fatal(err)
  }
  defer tx.Rollback()

  if err = {{$varNameSingular}}.Insert(tx); err != nil {
    t.Error(err)
  }

  if err = {{$varNameSingular}}.Reload(tx); err != nil {
    t.Error(err)
  }
}

func Test{{$tableNamePlural}}ReloadAll(t *testing.T) {
  t.Parallel()

  {{$varNameSingular}} := &{{$tableNameSingular}}{}
  if err := boil.RandomizeStruct({{$varNameSingular}}, {{$varNameSingular}}DBTypes, true, {{$varNameSingular}}ColumnsWithDefault...); err != nil {
    t.Errorf("Unable to randomize {{$tableNameSingular}} slice: %s", err)
  }

  tx, err := boil.Begin()
  if err != nil {
    t.Fatal(err)
  }
  defer tx.Rollback()

  if err = {{$varNameSingular}}.Insert(tx); err != nil {
    t.Error(err)
  }

  slice := {{$tableNameSingular}}Slice{{"{"}}{{$varNameSingular}}{{"}"}}

  if err = slice.ReloadAll(tx); err != nil {
    t.Error(err)
  }
}
